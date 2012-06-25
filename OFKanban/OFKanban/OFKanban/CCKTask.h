//
//  CCKTask.h
//  OFKanban
//
//  Created by Curt Clifton on 5/29/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OmniFocusTask;

@interface CCKTask : NSObject
- (id)initWithTaskID:(NSString *)taskID;

// CCC, 6/24/2012. Add read-only properties for the other bits you need to visualize tasks. Probably will want to initialize those lazily to reduce AS traffic?
@property (nonatomic, copy) NSString *taskID;
@end
