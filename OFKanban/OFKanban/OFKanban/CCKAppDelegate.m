//
//  CCKAppDelegate.m
//  OFKanban
//
//  Created by Curt Clifton on 5/22/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "CCKAppDelegate.h"

#import "OmniFocus.h"
#import "CCKTaskFactory.h"

@implementation CCKAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // CCC, 6/24/2012. Just hacking this in here for experimentation:
    // CCC, 7/10/2012. Need to fetch these on a background queue too.
    NSArray *backlog = [CCKTaskFactory backlogTasks];
    NSLog(@"backlog:\n%@", backlog);
    NSArray *ready = [CCKTaskFactory readyTasks];
    NSLog(@"ready:\n%@", ready);
    NSArray *workInProgress = [CCKTaskFactory workInProgressTasks];
    NSLog(@"workInProgress:\n%@", workInProgress);
    NSArray *recentlyDone = [CCKTaskFactory recentlyDoneTasks];
    NSLog(@"recentlyDone:\n%@", recentlyDone);
}

@end
