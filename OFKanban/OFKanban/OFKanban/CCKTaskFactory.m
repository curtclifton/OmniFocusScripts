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
#import "OSAScript+CCKAppleScript.h"

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
    fetchingScript = [OSAScript scriptWithName:@"GetTasks" inBundle:[NSBundle bundleForClass:self]];
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
    NSArray *taskIDArray = [fetchingScript executeHandlerWithName:handlerName arguments:[NSArray array]];
    NSMutableArray *taskArray = [NSMutableArray new];
    for (NSString *taskID in taskIDArray) {
        [taskArray addObject:[[CCKTask alloc] initWithTaskID:taskID]];
    }
    
    return taskArray;
}
@end
