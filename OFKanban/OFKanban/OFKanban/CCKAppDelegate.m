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
#import "CCKTaskListController.h"

static NSOperationQueue *_OmniFocusFetchQueue;

@implementation CCKAppDelegate

#pragma mark Class methods

+ (void)initialize;
{
    _OmniFocusFetchQueue = [NSOperationQueue new];
    _OmniFocusFetchQueue.maxConcurrentOperationCount = 1;
}

+ (NSOperationQueue *)omniFocusFetchQueue;
{
    return _OmniFocusFetchQueue;
}

#pragma mark NSApplicationDelegate protocol

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.backlogController = [[CCKTaskListController alloc] initWithTaskList:[CCKTaskList backlogTasks] tableView:self.backlogTableView];
    
    self.readyController = [[CCKTaskListController alloc] initWithTaskList:[CCKTaskList readyTasks] tableView:self.readyTableView];
    
    self.workInProgressController = [[CCKTaskListController alloc] initWithTaskList:[CCKTaskList workInProgressTasks] tableView:self.workInProgressTableView];
    
    self.recentlyDoneController = [[CCKTaskListController alloc] initWithTaskList:[CCKTaskList recentlyDoneTasks] tableView:self.recentlyDoneTableView];
    
}

#pragma mark Public API

#pragma mark Private API


@end
