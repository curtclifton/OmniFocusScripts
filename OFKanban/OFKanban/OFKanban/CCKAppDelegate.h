//
//  CCKAppDelegate.h
//  OFKanban
//
//  Created by Curt Clifton on 5/22/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CCKKanbanView, CCKTaskListController;

@interface CCKAppDelegate : NSObject <NSApplicationDelegate>

+ (NSOperationQueue *)omniFocusFetchQueue;

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *backlogTableView;
@property (weak) IBOutlet NSTableView *readyTableView;
@property (weak) IBOutlet NSTableView *workInProgressTableView;
@property (weak) IBOutlet NSTableView *recentlyDoneTableView;

@property (strong) CCKTaskListController *backlogController;
@property (strong) CCKTaskListController *readyController;
@property (strong) CCKTaskListController *workInProgressController;
@property (strong) CCKTaskListController *recentlyDoneController;

@end
