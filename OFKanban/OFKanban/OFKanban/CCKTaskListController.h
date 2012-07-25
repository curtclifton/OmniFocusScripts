//
//  CCKTaskListController.h
//  OFKanban
//
//  Created by Curtis Clifton on 7/24/12.
//  Copyright (c) 2012 The Omni Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCKTaskList;

@interface CCKTaskListController : NSObject <NSTableViewDataSource, NSTableViewDelegate>

- (id)initWithTaskList:(CCKTaskList *)taskList tableView:(NSTableView *)tableView;

@property (strong) CCKTaskList *taskList;
@end
