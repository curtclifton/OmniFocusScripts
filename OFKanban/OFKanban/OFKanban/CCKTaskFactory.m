//
//  CCKTaskFactory.m
//  OFKanban
//
//  Created by Curt Clifton on 6/24/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "CCKTaskFactory.h"

#import <OSAKit/OSAKit.h>

static NSString *scriptAsString = @"on getBacklogTaskIDs()\n    return {\"hello\", \"world\"}\nend getText";
static OSAScript *fetchingScript;

@implementation CCKTaskFactory
+ (void)initialize;
{
    // CCC, 6/24/2012. use initWithContentsOfURL:... once this is conceptually working
    fetchingScript = [[OSAScript alloc] initWithSource:scriptAsString];
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
    // CCC, 6/24/2012. Handle non-empty errorDictionary
    // CCC, 6/24/2012. Parse results.
    NSLog(@"result: %@", result);
    NSLog(@"errorDictionary: %@", errorDictionary);
    return [NSArray new];
}
@end
