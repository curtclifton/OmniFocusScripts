//
//  CCKAppDelegate.m
//  OFKanban
//
//  Created by Curt Clifton on 5/22/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "CCKAppDelegate.h"

#import <ScriptingBridge/ScriptingBridge.h>

#import "OmniFocus.h"
#import "SBElementArray+CCKExtensions.h"
#import "CCKTaskFactory.h"

@implementation CCKAppDelegate
@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // CCC, 6/24/2012. Let's try using OSAScript instead. Just hacking this in here for experimentation:
    NSArray *backlog = [CCKTaskFactory backlogTasks];
    for (id taskID in backlog) {
        NSLog(@"taskID %@ of type %@", taskID, [taskID class]);
    }
#if 0
    // CCC, 6/24/2012. Decide between scripting bridge and OSAScript, delete and unlink the other.
    // CCC, 5/22/2012.  Just putting some code here temporarily to get the scripting bridge working;
    id omnifocusApplication = [SBApplication applicationWithBundleIdentifier:@"com.omnigroup.OmniFocus"];
    if (!omnifocusApplication)
        omnifocusApplication = [SBApplication applicationWithBundleIdentifier:@"com.omnigroup.omnifocus.macappstore"];
    if (!omnifocusApplication)
        abort(); // CCC, 5/22/2012. Handle gracefully.

    if (![omnifocusApplication isRunning])
        abort(); // CCC, 5/22/2012. Handle gracefully.
    
    OmniFocusDocument *defaultDocument = [omnifocusApplication defaultDocument];
    NSUInteger taskCount = [[defaultDocument flattenedTasks] count];
    NSLog(@"Default document has %ld tasks", taskCount);
    
    SBElementArray *contexts = [defaultDocument flattenedContexts];
    NSMutableArray *availableTasks = [NSMutableArray new];
    for (SBObject *obj in contexts) {
        OmniFocusContext *context = (OmniFocusContext *)obj;
        SBElementArray *availableTasksInContext = [context availableTasks];
        [availableTasks addObjectsFromArray:availableTasksInContext];
    }
    
    NSMutableSet *backlogTasks = [NSMutableSet new];
    NSMutableSet *wipTasks = [NSMutableSet new];
    for (SBObject *obj in availableTasks) {
        OmniFocusTask *task = (OmniFocusTask *)obj;
        id dueDate = [task.dueDate get];
        BOOL isFlagged = task.flagged;
        NSLog(@"%@ %@ %@", task.name, dueDate, isFlagged ? @"flagged" : @"not flagged");
    }
    NSLog(@"and %ld available tasks.", [availableTasks count]);
#endif
}

@end
