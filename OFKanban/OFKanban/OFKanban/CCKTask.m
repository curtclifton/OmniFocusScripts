//
//  CCKTask.m
//  OFKanban
//
//  Created by Curt Clifton on 5/29/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "CCKTask.h"

#import <OSAKit/OSAKit.h>

#import "NSAppleEventDescriptor+ValueUnboxing.h"

NSOperationQueue *_TaskDetailFetchQueue;

static OSAScript *fetchingScript;

@interface CCKTask ()
@property (nonatomic, readwrite) NSString *title;
@end

@implementation CCKTask
{
    BOOL _loaded;
}

+ (void)initialize;
{
    _TaskDetailFetchQueue = [NSOperationQueue new];
    // CCC, 7/3/2012. Factor out common code from here and CCKTaskFactory into a factory method in a category on OSAScript that returns an OSAScript object. 
    NSBundle *factoryBundle = [NSBundle bundleForClass:self];
    NSURL *scriptURL = [factoryBundle URLForResource:@"GetTaskInfo" withExtension:@"scpt"];
    OSALanguageInstance *language = [OSALanguageInstance languageInstanceWithLanguage:[OSALanguage languageForName:@"AppleScript"]];
    NSError *error;
    fetchingScript = [[OSAScript alloc] initWithContentsOfURL:scriptURL languageInstance:language usingStorageOptions:OSANull error:&error];
    if (!fetchingScript) {
        // CCC, 6/24/2012. Handle error.
        NSLog(@"Error getting script: %@", error);
        abort();
    }
    
}

- (id)initWithTaskID:(NSString *)taskID;
{
    if (!(self = [super init]))
        return nil;
    
    _taskID = [taskID copy];
    _title = NSLocalizedString(@"Loading…", @"interim task title");
    
    [self enqueueInitializationBlock];
    
    return self;
}

#pragma mark NSObject subclass

- (NSString *)description;
{
    return [NSString stringWithFormat:@"%@ — Task ID = %@", self.title, self.taskID];
}

#pragma mark Public API

@synthesize taskID = _taskID;
@synthesize title = _title;

#pragma mark Private API

- (void)enqueueInitializationBlock;
{
    [_TaskDetailFetchQueue addOperationWithBlock:^{
        // CCC, 7/3/2012. Implement.
        NSString *handlerName = @"gettaskinfo";
        NSArray *arguments = [NSArray arrayWithObject:self.taskID];
        
        // CCC, 7/3/2012. Add handler invoker to category on OSAScript.
        NSDictionary *errorDictionary;
        NSAppleEventDescriptor *result = [fetchingScript executeHandlerWithName:handlerName arguments:arguments error:&errorDictionary];
        if (!result) {
            // CCC, 6/24/2012. Handle non-empty errorDictionary
            NSLog(@"fetching error: %@", errorDictionary);
            abort();
        }
        
        NSError *error;
        NSDictionary *taskFieldDictionary = [result dictionaryValue:&error];
        if (!result) {
            // CCC, 6/24/2012. Handle error
            NSLog(@"unboxing error: %@", error);
            abort();
        }
        
        self.title = [taskFieldDictionary objectForKey:@"title"];
        NSLog(@"initialized: %@", self);        
    }];
}

@end
