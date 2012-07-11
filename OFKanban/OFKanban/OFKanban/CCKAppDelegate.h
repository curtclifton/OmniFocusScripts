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

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet CCKKanbanView *collectionView;
// CCC, 7/10/2012. Make separate, infinitely tall views with a title and a list of notes.

@end
