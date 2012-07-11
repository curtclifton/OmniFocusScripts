//
//  CCKKanbanView.m
//  OFKanban
//
//  Created by Curtis Clifton on 7/10/12.
//  Copyright (c) 2012 The Omni Group. All rights reserved.
//

#import "CCKKanbanView.h"

@implementation CCKKanbanView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    NSLog(@"Drawing with dirty rect: %@", NSStringFromRect(dirtyRect));
}

@end
