//
//  CCKTask.h
//  OFKanban
//
//  Created by Curt Clifton on 5/29/12.
//  Copyright (c) 2012 The Omni Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OmniFocusTask;

@interface CCKTask : NSObject
- (id)initWithOmniFocusTask:(OmniFocusTask *)task;
@end
