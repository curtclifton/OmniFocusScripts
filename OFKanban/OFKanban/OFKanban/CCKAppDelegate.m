//
//  CCKAppDelegate.m
//  OFKanban
//
//  Created by Curt Clifton on 5/22/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "CCKAppDelegate.h"

#import "OmniFocus.h"
#import "CCKTaskList.h"

static NSOperationQueue *_OmniFocusFetchQueue;
// CCC, 7/17/2012. Hang on to these here for the moment so ARC doesn't helpfully autorelease them.
static CCKTaskList *backlog;
static CCKTaskList *ready;
static CCKTaskList *workInProgress;
static CCKTaskList *recentlyDone;

@implementation CCKAppDelegate

+ (void)initialize;
{
    _OmniFocusFetchQueue = [NSOperationQueue new];
    _OmniFocusFetchQueue.maxConcurrentOperationCount = 1;
}

+ (NSOperationQueue *)omniFocusFetchQueue;
{
    return _OmniFocusFetchQueue;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // CCC, 6/24/2012. Just hacking this in here for experimentation:
    // CCC, 7/10/2012. Need to fetch these on a background queue too.
    backlog = [CCKTaskList backlogTasks];
    NSLog(@"backlog:\n%@", backlog);
    ready = [CCKTaskList readyTasks];
    NSLog(@"ready:\n%@", ready);
    workInProgress = [CCKTaskList workInProgressTasks];
    NSLog(@"workInProgress:\n%@", workInProgress);
    recentlyDone = [CCKTaskList recentlyDoneTasks];
    NSLog(@"recentlyDone:\n%@", recentlyDone);
}

@end
