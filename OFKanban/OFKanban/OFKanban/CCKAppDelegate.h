//
//  CCKAppDelegate.h
//  OFKanban
//
//  Created by Curt Clifton on 5/22/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CCKKanbanView;

@interface CCKAppDelegate : NSObject <NSApplicationDelegate>

+ (NSOperationQueue *)omniFocusFetchQueue;

@property (assign) IBOutlet NSWindow *window;

@end
