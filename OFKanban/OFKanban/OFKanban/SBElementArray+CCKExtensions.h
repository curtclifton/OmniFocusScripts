//
//  SBElementArray+CCKExtensions.h
//  OFKanban
//
//  Created by Curt Clifton on 5/22/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import <ScriptingBridge/ScriptingBridge.h>

typedef BOOL(^SBElementPredicate)(SBObject *);

@interface SBElementArray (CCKExtensions)
- (NSArray *)arrayWithObjectsMatching:(SBElementPredicate)predicate;
@end
