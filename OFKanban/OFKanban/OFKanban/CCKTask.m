//
//  CCKTask.m
//  OFKanban
//
//  Created by Curt Clifton on 5/29/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "CCKTask.h"

#import "OmniFocus.h"

@implementation CCKTask

- (id)initWithTaskID:(NSString *)taskID;
{
    if (!(self = [super init]))
        return nil;
    
    _taskID = [taskID copy];
    
    return self;
}

#pragma mark NSObject subclass

- (NSString *)description;
{
    return [NSString stringWithFormat:@"Task ID = %@", self.taskID];
}

#pragma mark Public API

@synthesize taskID = _taskID;

@end
