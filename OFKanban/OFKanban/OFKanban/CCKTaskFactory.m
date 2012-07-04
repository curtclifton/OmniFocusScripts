//
//  CCKTaskFactory.m
//  OFKanban
//
//  Created by Curt Clifton on 6/24/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "CCKTaskFactory.h"

#import <OSAKit/OSAKit.h>

#import "CCKTask.h"
#import "NSAppleEventDescriptor+CCKValueUnboxing.h"

#if 0 && defined(DEBUG)
#define DEBUG_FACTORY(format, ...) NSLog(@"FACTORY: " format, ## __VA_ARGS__)
#else
#define DEBUG_FACTORY(format, ...)
#endif

static NSString *scriptAsString = @"on getBacklogTaskIDs()\n    return {\"hello\", \"world\"}\nend getText";
static OSAScript *fetchingScript;

@implementation CCKTaskFactory
+ (void)initialize;
{
    NSBundle *factoryBundle = [NSBundle bundleForClass:self];
    NSURL *scriptURL = [factoryBundle URLForResource:@"GetTasks" withExtension:@"scpt"];
    OSALanguageInstance *language = [OSALanguageInstance languageInstanceWithLanguage:[OSALanguage languageForName:@"AppleScript"]];
    NSError *error;
    fetchingScript = [[OSAScript alloc] initWithContentsOfURL:scriptURL languageInstance:language usingStorageOptions:OSANull error:&error];
    if (!fetchingScript) {
        // CCC, 6/24/2012. Handle error.
        NSLog(@"Error getting script: %@", error);
        abort();
    }
}


# pragma mark Public API
+ (NSArray *)backlogTasks;
{
    return [CCKTaskFactory tasksFromHandlerNamed:@"getBacklogTaskIDs"];
}

+ (NSArray *)readyTasks;
{
    return [CCKTaskFactory tasksFromHandlerNamed:@"getReadyTaskIDs"];
}

+ (NSArray *)workInProgressTasks;
{
    return [CCKTaskFactory tasksFromHandlerNamed:@"getWorkInProgressTaskIDs"];
}

+ (NSArray *)recentlyDoneTasks;
{
    return [CCKTaskFactory tasksFromHandlerNamed:@"getRecentlyDoneTaskIDs"];
}

#pragma  mark Private API
+ (NSArray *)tasksFromHandlerNamed:(NSString *)handlerName;
{
    // Must invoke handlers using all-lowercase names.
    handlerName = [handlerName lowercaseString];
    NSDictionary *errorDictionary;
    NSAppleEventDescriptor *result = [fetchingScript executeHandlerWithName:handlerName arguments:[NSArray array] error:&errorDictionary];
    DEBUG_FACTORY(@"result: %@", result);
    if (!result) {
        // CCC, 6/24/2012. Handle non-empty errorDictionary
        NSLog(@"fetching error: %@", errorDictionary);
        abort();
    }
    
    NSError *error;
    NSArray *taskIDArray = [result arrayValue:&error];
    if (!result) {
        // CCC, 6/24/2012. Handle error
        NSLog(@"unboxing error: %@", error);
        abort();
    }
    
    NSMutableArray *taskArray = [NSMutableArray new];
    for (NSString *taskID in taskIDArray) {
        [taskArray addObject:[[CCKTask alloc] initWithTaskID:taskID]];
    }
    
    return taskArray;
}
@end
