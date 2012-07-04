//
//  OSAScript+CCKAppleScript.h
//  OFKanban
//
//  Created by Curt Clifton on 7/3/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import <OSAKit/OSAKit.h>

@interface OSAScript (CCKAppleScript)
+ (OSAScript *)scriptWithName:(NSString *)name inBundle:(NSBundle *)bundle; // loads resource <name>.scpt in the given bundle
- (id)executeHandlerWithName:(NSString *)handlerName arguments:(NSArray *)arguments; // parameters and result are unboxed, Objective-C objects
@end
