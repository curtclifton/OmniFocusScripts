//
//  NSAppleEventDescriptor+ValueUnboxing.m
//  OFKanban
//
//  Created by Curt Clifton on 6/24/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//  
//  Based on sample code from Jim Correia. Thanks, Jim!
//

#import "NSAppleEventDescriptor+ValueUnboxing.h"

#import <Carbon/Carbon.h>

NSString * const CCKOffendingDescriptorKey = @"CCKOffendingDescriptorKey";

static NSError * _ErrorWithCodeForOffendingDescriptorAndDescription(OSStatus errorCode, NSAppleEventDescriptor *offendingDescriptor, NSString *description);
static NSError * _ErrorWithCodeForOffendingDescriptor(OSStatus errorCode, NSAppleEventDescriptor *offendingDescriptor);

#pragma mark -

static NSDictionary * _DictionaryByUnboxingUserFields(NSAppleEventDescriptor *descriptor, NSError **error);

static id _ValueByUnboxingAppleEventRecordDescriptor(NSAppleEventDescriptor *descriptor, NSError **error);
static id _ValueByUnboxingAppleEventListDescriptor(NSAppleEventDescriptor *descriptor, NSError **error);
static id _ValueByUnboxingAppleEventScalarDescriptor(NSAppleEventDescriptor *descriptor, NSError **error);
static id _ValueByUnboxingAppleEventDescriptor(NSAppleEventDescriptor *descriptor, NSError **error);

#pragma mark -

static NSError * _ErrorWithCodeForOffendingDescriptorAndDescription(OSStatus errorCode, NSAppleEventDescriptor *offendingDescriptor, NSString *description)
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:offendingDescriptor forKey:CCKOffendingDescriptorKey];
    if (description != nil) {
        [userInfo setObject:description forKey:NSLocalizedDescriptionKey];
    }
    
    return [NSError errorWithDomain:NSOSStatusErrorDomain code:errorCode userInfo:userInfo];
}

static NSError * _ErrorWithCodeForOffendingDescriptor(OSStatus errorCode, NSAppleEventDescriptor *offendingDescriptor)
{
    return _ErrorWithCodeForOffendingDescriptorAndDescription(errorCode, offendingDescriptor, nil);
}

#pragma mark -

static NSDictionary * _DictionaryByUnboxingUserFields(NSAppleEventDescriptor *descriptor, NSError **error)
{
    NSInteger numberOfItems = [descriptor numberOfItems];
    
    if (numberOfItems % 2 != 0) {
        if (error != NULL) {
            *error = _ErrorWithCodeForOffendingDescriptor(errOSACorruptData, descriptor);
        }
        return nil;
    }
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    for (NSInteger i = 1; i < numberOfItems; i += 2) {
        NSString *key = [[descriptor descriptorAtIndex:i] stringValue];
        id value = _ValueByUnboxingAppleEventDescriptor([descriptor descriptorAtIndex:i + 1], error);
        
        if (value == nil) {
            return nil;
        }
        
        [dictionary setObject:value forKey:key];
    }
    
    return dictionary;
}

static id _ValueByUnboxingAppleEventRecordDescriptor(NSAppleEventDescriptor *descriptor, NSError **error)
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSUInteger numberOfItems = [descriptor numberOfItems];
    
    for (NSUInteger i = 1; i <= numberOfItems; i++) {
        OSType keyword = [descriptor keywordForDescriptorAtIndex:i];
        if (keyword == keyASUserRecordFields) {
            NSDictionary *userFields = _DictionaryByUnboxingUserFields([descriptor descriptorAtIndex:i], error);
            if (userFields == nil) {
                return nil;
            }
            [dictionary addEntriesFromDictionary:userFields];
        } else {
            NSNumber *key = [NSNumber numberWithInteger:keyword];
            id value = _ValueByUnboxingAppleEventDescriptor([descriptor descriptorAtIndex:i], error);
            if (value == nil) {
                return nil;
            }
            [dictionary setObject:value forKey:key];
        }
    }
    
    return dictionary;
}

static id _ValueByUnboxingAppleEventListDescriptor(NSAppleEventDescriptor *descriptor, NSError **error)
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger numberOfItems = [descriptor numberOfItems];
    
    for (NSInteger i = 1; i <= numberOfItems; i++) {
        id value = _ValueByUnboxingAppleEventDescriptor([descriptor descriptorAtIndex:i], error);
        
        if (value == nil) {
            return nil;
        }
        
        [array addObject:value];
    }
    
    return array;
}

static id _ValueByUnboxingAppleEventScalarDescriptor(NSAppleEventDescriptor *descriptor, NSError **error)
{
    /* We only support unboxing string or number types, as well as 'missing value'.
     We intentionally avoid -coerceToDescriptorType:, or unchecked usage of the -stringValue or int<XXX>Value methods because I've seen them do inappropriate things when used on a descriptor of an inappropriate type.
     */
    
    id value = nil;
    AEDesc coercedDesc = {typeNull, NULL};
    
    switch ([descriptor descriptorType]) {
            
        case typeSInt16:
        case typeSInt32: {
            NSInteger int32Value = [descriptor int32Value];
            value = [NSNumber numberWithInteger:int32Value];
            break;
        }
            
        case typeUInt32: {
            uint32_t uint32Value = 0;
            if (noErr == AECoerceDesc([descriptor aeDesc], typeUInt32, &coercedDesc) &&
                noErr == AEGetDescData(&coercedDesc, &uint32Value, sizeof(uint32Value))) {
                value = [NSNumber numberWithUnsignedInteger:uint32Value];
            }
            break;
        }
            
        case typeType:
        case typeEnumerated:
        case typeKeyword: {
            uint32_t uint32Value = 0;
            if (noErr == AEGetDescData([descriptor aeDesc], &uint32Value, sizeof(uint32Value))) {
                if (uint32Value == cMissingValue || uint32Value == typeNull) {
                    value = [NSNull null];
                } else {
                    value = [NSNumber numberWithUnsignedInteger:uint32Value];
                }
            }
            break;
        }
            
        case typeSInt64: {
            int64_t int64Value = 0;
            if (noErr == AECoerceDesc([descriptor aeDesc], typeSInt64, &coercedDesc) &&
                noErr == AEGetDescData(&coercedDesc, &int64Value, sizeof(int64Value))) {
                value = [NSNumber numberWithLongLong:int64Value];
            }
            break;
        }
            
        case typeIEEE32BitFloatingPoint: {
            float floatValue = 0;
            if (noErr == AECoerceDesc([descriptor aeDesc], typeIEEE32BitFloatingPoint, &coercedDesc) &&
                noErr == AEGetDescData(&coercedDesc, &floatValue, sizeof(floatValue))) {
                value = [NSNumber numberWithFloat:floatValue];
            }
            break;
        }
            
        case typeIEEE64BitFloatingPoint: {
            double doubleValue = 0;
            if (noErr == AECoerceDesc([descriptor aeDesc], typeIEEE64BitFloatingPoint, &coercedDesc) &&
                noErr == AEGetDescData(&coercedDesc, &doubleValue, sizeof(doubleValue))) {
                value = [NSNumber numberWithDouble:doubleValue];
            }
            break;
        }
            
        case typeUnicodeText:
        case typeCString:
        case typePString: {
            value = [descriptor stringValue];
            break;
        }
            
        default: {
#if DEBUG
            CFStringRef OSTypeString = UTCreateStringForOSType([descriptor descriptorType]);
            NSLog(@"Type '%@' unhandled in %s", OSTypeString, __PRETTY_FUNCTION__);
            CFRelease(OSTypeString);
#endif
            break;
        }
    }
    
    if (value == nil && error != NULL) {
        *error = _ErrorWithCodeForOffendingDescriptor(errAEWrongDataType, descriptor);
    }
    
    AEDisposeDesc(&coercedDesc);
    
    return value;
}

static id _ValueByUnboxingAppleEventDescriptor(NSAppleEventDescriptor *descriptor, NSError **error)
{
    id value = nil;
    
    switch ([descriptor descriptorType]) {
            
        case typeAERecord: {
            value = _ValueByUnboxingAppleEventRecordDescriptor(descriptor, error);
            break;
        }
            
        case typeAEList: {
            value = _ValueByUnboxingAppleEventListDescriptor(descriptor, error);
            break;
        }
            
        default: {
            value = _ValueByUnboxingAppleEventScalarDescriptor(descriptor, error);
            break;
        }
    }
    
    return value;
}

@implementation NSAppleEventDescriptor (CCKValueUnboxing)
- (NSArray *)arrayValue:(NSError **)error;
{
    if ([self descriptorType] != typeAEList) {
        if (error != NULL) {
            *error = _ErrorWithCodeForOffendingDescriptor(errAEWrongDataType, self);
        }
        return nil;
    }
    
    return _ValueByUnboxingAppleEventDescriptor(self, error);
}

- (NSDictionary *)dictionaryValue:(NSError **)error;
{
    if ([self descriptorType] != typeAERecord) {
        if (error != NULL) {
            *error = _ErrorWithCodeForOffendingDescriptor(errAEWrongDataType, self);
        }
        return nil;
    }
    
    return _ValueByUnboxingAppleEventDescriptor(self, error);
}
@end
