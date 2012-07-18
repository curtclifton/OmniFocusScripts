//
//  CCKTaskFactory.h
//  OFKanban
//
//  Created by Curt Clifton on 6/24/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCKTaskList : NSObject
+ (CCKTaskList *)backlogTasks;
+ (CCKTaskList *)readyTasks;
+ (CCKTaskList *)workInProgressTasks;
+ (CCKTaskList *)recentlyDoneTasks;
@end
