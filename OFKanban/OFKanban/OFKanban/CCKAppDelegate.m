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

@implementation CCKAppDelegate
@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
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
    
    for (SBObject *obj in availableTasks) {
        OmniFocusTask *task = (OmniFocusTask *)obj;
        NSLog(@"%@", [task name]);
    }
    NSLog(@"and %ld available tasks.", [availableTasks count]);
}

@end
