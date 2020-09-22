//
//  PendingOperations.m
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import "PendingOperations.h"

@interface PendingOperations()


@end

@implementation PendingOperations

static PendingOperations *_instance = nil;
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[PendingOperations alloc]init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self requestQueue];
    }
    return self;
}
#pragma mark - Public
// 队列挂起
- (void)suspendAllOperations {
    self.requestQueue.suspended = YES;
}

// 队列重启
- (void)resumeAllOperations {
    self.requestQueue.suspended = NO;
}

// 队列重置
- (void)resetAllOperations {
    [self.requestQueue cancelAllOperations];
    [self resumeAllOperations];
}

#pragma mark - Setter & Getter
- (NSOperationQueue *)requestQueue {
    if (!_requestQueue) {
        _requestQueue = [[NSOperationQueue alloc]init];
        _requestQueue.name = @"Request queue";
        _requestQueue.maxConcurrentOperationCount = 1;
    }
    return _requestQueue;
}

@end
