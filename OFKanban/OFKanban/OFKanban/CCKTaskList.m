//
//  CCKTaskFactory.m
//  OFKanban
//
//  Created by Curt Clifton on 6/24/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "CCKTaskList.h"

#import <OSAKit/OSAKit.h>

#import "CCKAppDelegate.h"
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

@interface CCKTaskList ()
@property (nonatomic, copy, readonly) NSString *handlerScriptName;
@property (nonatomic, readwrite) BOOL tasksLoaded;
@property (nonatomic, strong) NSArray *taskList;
@end

@implementation CCKTaskList
+ (void)initialize;
{
    fetchingScript = [OSAScript scriptWithName:@"GetTasks" inBundle:[NSBundle bundleForClass:self]];
}


# pragma mark Class Methods
+ (CCKTaskList *)backlogTasks;
{
    return [[CCKTaskList alloc] initWithHandler:@"getBacklogTaskIDs"];
}

+ (CCKTaskList *)readyTasks;
{
    return [[CCKTaskList alloc] initWithHandler:@"getReadyTaskIDs"];
}

+ (CCKTaskList *)workInProgressTasks;
{
    return [[CCKTaskList alloc] initWithHandler:@"getWorkInProgressTaskIDs"];
}

+ (CCKTaskList *)recentlyDoneTasks;
{
    return [[CCKTaskList alloc] initWithHandler:@"getRecentlyDoneTaskIDs"];
}

#pragma mark NSObject subclass
- (NSString *)description;
{
    if (self.tasksLoaded) {
        return [NSString stringWithFormat:@"%@: %@", self.handlerScriptName, self.taskList];
    }
    return [NSString stringWithFormat:@"Load pending for handler %@", self.handlerScriptName];
}

#pragma  mark Private API
- (id)initWithHandler:(NSString *)handlerName;
{
    self = [super init];
    if (self) {
        _handlerScriptName = [handlerName copy];
        [self enqueueTaskFetching];
    }
    
    return self;
}

- (void)enqueueTaskFetching;
{
    [[CCKAppDelegate omniFocusFetchQueue] addOperationWithBlock:^{
        id result = [fetchingScript executeHandlerWithName:self.handlerScriptName arguments:[NSArray array]];
        NSAssert([result isKindOfClass:[NSArray class]],@"expected array");
        NSArray *taskIDArray = result;

        NSMutableArray *taskArray = [NSMutableArray new];
        for (NSString *taskID in taskIDArray) {
            [taskArray addObject:[[CCKTask alloc] initWithTaskID:taskID]];
        }
        self.taskList = taskArray;
        self.tasksLoaded = YES;
        NSLog(@"Finished loading: %@", self);
    }];
}


@end
