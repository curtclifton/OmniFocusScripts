//
//  SBElementArray+CCKExtensions.m
//  OFKanban
//
//  Created by Curt Clifton on 5/22/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "SBElementArray+CCKExtensions.h"

@implementation SBElementArray (CCKExtensions)
- (NSArray *)arrayWithObjectsMatching:(SBElementPredicate)predicate;
{
    NSMutableArray *result = [NSMutableArray new];
    for (SBObject *element in self) {
        if (predicate(element)) {
            [result addObject:element];
        }
    }
    return result;
}
@end
