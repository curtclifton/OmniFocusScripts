//
//  CCKTaskListController.m
//  OFKanban
//
//  Created by Curtis Clifton on 7/24/12.
//  Copyright (c) 2012 The Omni Group. All rights reserved.
//

#import "CCKTaskListController.h"

// CCC, 7/24/2012. Implementing with stock NSTableViewCell's with a single text field initially. Will want to switch to custom CCKStickyNoteView <: NSTableViewCell

@implementation CCKTaskListController

- (id)initWithTaskList:(CCKTaskList *)taskList tableView:(NSTableView *)tableView;
{
    self = [super init];
    if (!self)
        return nil;
    
    _taskList = taskList;
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    return self;
}

#pragma mark NSTableViewDataSource protocol
// CCC, 7/24/2012. Implement.

#pragma mark NSTableViewDelegate protocol
// CCC, 7/24/2012. Implement.

@end
