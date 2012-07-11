//
//  CCKTask.m
//  OFKanban
//
//  Created by Curt Clifton on 5/29/12.
//  Copyright (c) 2012 Curtis Clifton. All rights reserved.
//

#import "CCKTask.h"

#import <OSAKit/OSAKit.h>

#import "NSAppleEventDescriptor+CCKValueUnboxing.h"
#import "OSAScript+CCKAppleScript.h"

NSOperationQueue *_TaskDetailFetchQueue;

static OSAScript *fetchingScript;

@interface CCKTask ()
@property (nonatomic, readwrite) NSString *title;
@end

@implementation CCKTask
{
    BOOL _loaded;
}

+ (void)initialize;
{
    _TaskDetailFetchQueue = [NSOperationQueue new];    
    fetchingScript = [OSAScript scriptWithName:@"GetTaskInfo" inBundle:[NSBundle bundleForClass:self]];
}

- (id)initWithTaskID:(NSString *)taskID;
{
    if (!(self = [super init]))
        return nil;
    
    _taskID = [taskID copy];
    _title = NSLocalizedString(@"Loading…", @"interim task title");
    
    [self enqueueInitializationBlock];
    
    return self;
}

#pragma mark NSObject subclass

- (NSString *)description;
{
    return [NSString stringWithFormat:@"%@ — Task ID = %@", self.title, self.taskID];
}

#pragma mark Public API

@synthesize taskID = _taskID;
@synthesize title = _title;

#pragma mark Private API

- (void)enqueueInitializationBlock;
{
    [_TaskDetailFetchQueue addOperationWithBlock:^{
        NSString *handlerName = @"gettaskinfo";
        NSArray *arguments = [NSArray arrayWithObject:self.taskID];
        
        id result = [fetchingScript executeHandlerWithName:handlerName arguments:arguments];
        NSAssert([result isKindOfClass:[NSDictionary class]],@"expected dictionary");
        NSDictionary *taskFieldDictionary = result;
        
        self.title = [taskFieldDictionary objectForKey:@"title"];
        // CCC, 7/10/2012. Initialize other properties
        NSLog(@"initialized: %@", self);        
    }];
}

@end
