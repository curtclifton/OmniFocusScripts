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
    
    SBElementArray *tasks = [defaultDocument flattenedTasks];
    // CCC, 5/22/2012. This is dog slow because of all the events sent:
    NSArray *availableTasks = [tasks arrayWithObjectsMatching:^BOOL(SBObject *object) {
        OmniFocusTask *task = (OmniFocusTask *)object;
        return !task.blocked;
    }];
    NSLog(@"and %ld available tasks.", [availableTasks count]);
}

@end
