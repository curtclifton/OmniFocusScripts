//
//  OSAScript+CCKAppleScript.m
//  OFKanban
//
//  Created by Curt Clifton on 7/3/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "OSAScript+CCKAppleScript.h"

#import "NSAppleEventDescriptor+CCKValueUnboxing.h"

@implementation OSAScript (CCKAppleScript)
+ (OSAScript *)scriptWithName:(NSString *)name inBundle:(NSBundle *)bundle; // loads resource <name>.scpt in the given bundle
{
    NSURL *scriptURL = [bundle URLForResource:name withExtension:@"scpt"];
    OSALanguageInstance *language = [OSALanguageInstance languageInstanceWithLanguage:[OSALanguage languageForName:@"AppleScript"]];
    NSError *error;
    OSAScript *result = [[OSAScript alloc] initWithContentsOfURL:scriptURL languageInstance:language usingStorageOptions:OSANull error:&error];
    if (!result) {
        // CCC, 6/24/2012. Handle error.
        NSLog(@"Error getting script: %@", error);
        abort();
    }
    
    return result;
}

- (id)executeHandlerWithName:(NSString *)handlerName arguments:(NSArray *)arguments; // parameters and result are unboxed, Objective-C objects
{
    // Must invoke handlers using all-lowercase names.
    handlerName = [handlerName lowercaseString];
    // CCC, 7/3/2012. Box values in arguments.

    NSDictionary *errorDictionary;
    NSAppleEventDescriptor *result = [self executeHandlerWithName:handlerName arguments:arguments error:&errorDictionary];
    if (!result) {
        // CCC, 6/24/2012. Handle non-empty errorDictionary
        NSLog(@"fetching error: %@", errorDictionary);
        abort();
    }
    
    NSError *error;
    id unboxedResult = [result unboxedValue:&error];
    if (!unboxedResult) {
        // CCC, 6/24/2012. Handle error
        NSLog(@"unboxing error: %@", error);
        abort();
    }
    
    return unboxedResult;
}

@end
