//
//  PendingOperations.h
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PendingOperations : NSObject

@property (nonatomic, strong) NSOperationQueue *requestQueue;


+ (instancetype)shareManager;

// 队列挂起
- (void)suspendAllOperations;

// 队列重启
- (void)resumeAllOperations;

// 队列重置
- (void)resetAllOperations;

@end

NS_ASSUME_NONNULL_END
