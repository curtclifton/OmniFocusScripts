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
@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // CCC, 6/24/2012. Just hacking this in here for experimentation:
    NSArray *backlog = [CCKTaskFactory backlogTasks];
    for (id taskID in backlog) {
        NSLog(@"taskID %@ of type %@", taskID, [taskID class]);
    }
}

@end
