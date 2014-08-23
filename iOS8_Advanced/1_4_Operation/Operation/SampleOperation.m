//
//  SampleOperation.m
//  1_4_Operation
//
//  Created by Masayuki Nii on 2014/02/26.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "SampleOperation.h"

//#define PLUS_THREAD

@interface SampleOperation()

@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isFinished;
- (void)finishMyOperation;

#ifdef PLUS_THREAD
- (void)backgroundTask;
#endif

@end

@implementation SampleOperation

- (BOOL)isConcurrent
{
    return YES;
}

- (BOOL)isExecuting {
    return _isExecuting;
}

- (BOOL)isFinished {
    return _isFinished;
}

- (id) init
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    if ( (self = [super init]) )    {
        self.isExecuting = NO;
        self.isFinished = NO;
        // プロパティの初期化など
    }
    return self;
}

- (void)start
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    if ([self isCancelled])
    {
        [self willChangeValueForKey:@"isFinished"];
        self.isFinished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    self.isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self main];
}

- (void)finishMyOperation
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    self.isExecuting = NO;
    self.isFinished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)main {
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    @try {
        for ( int i = 0 ; i < 1000 ; i++)  {
            NSLog( @"Label = %@[%4d]", self.label, i);
            if ( self.isCancelled ) {
                [self finishMyOperation];
                return;
            }
        }
#ifdef PLUS_THREAD
        [NSThread detachNewThreadSelector: @selector(backgroundTask)
                                 toTarget: self
                               withObject: nil];
#endif
    }
    @catch(NSException *ex) {
        //例外への対応。例外は再度スルーはしない
    }
}

- (void)backgroundTask
{
    for ( int i = 0 ; i < 1000 ; i++)  {
        NSLog( @"Label = %@[%4d] (background)", self.label, i);
        if ( self.isCancelled ) {
            [self finishMyOperation];
            return;
        }
    }
    [self finishMyOperation];
}
@end
