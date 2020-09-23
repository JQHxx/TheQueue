//
//  OFRequestTask.m
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import "OFRequestTask.h"
#import "PendingOperations.h"
#import "OFRequest.h"
#import <AFNetworking.h>

@interface OFRequestTask()

@property (nonatomic, strong) OFRequest *request;
@property (nonatomic, assign, getter=isExecuting) BOOL executing;
@property (nonatomic, assign, getter=isFinished) BOOL finished;


@end

@implementation OFRequestTask
@synthesize finished = _finished, executing = _executing;

- (instancetype)initWithRequest:(OFRequest *)request
{
    self = [super init];
    if (self) {
        _request = request;
    }
    return self;
}


- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}
 
- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}
 
- (void)start {
    if (self.isCancelled) {
        self.finished = YES;
        return;
    }
    
    [self sendRequest];
    /*
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
   
        // 这里开始异步
        // 如果用非同步的网络请求，这里没有必要手动添加到异步队列
        // 当任务完成是需要修改finished和executing
        //self.finished = YES;
        //self.executing = NO;
    });
     */
    
    self.executing = YES;
}

- (void)sendRequest {
    // 每次启动一个operation时将整个队列挂起，暂停所有operations
       [[PendingOperations shareManager] suspendAllOperations];
       
       /***  网络请求 工具类  ***/
       AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       
       // 设置超时时间
       [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
       manager.requestSerializer.timeoutInterval = 15.0f;
       [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
       
       self.request.state = RequestStatesStart;
       if (self.request.requestMethod == GET) {
           
           [manager GET:self.request.url parameters:self.request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               self.request.state = RequestStateSuccess;
               if (self.request.completion) {
                   self.request.completion(self.request, responseObject);
               }
               self.finished = YES;
               self.executing = NO;
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               self.request.state = RequestStateFailed;
               if (self.request.completion) {
                   self.request.completion(self.request, error);
               }
               self.finished = YES;
               self.executing = NO;
           }];
       } else {
           [manager POST:self.request.url parameters:self.request.params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
               self.request.state = RequestStateSuccess;
               if (self.request.completion) {
                   self.request.completion(self.request, responseObject);
               }
               self.finished = YES;
               self.executing = NO;
           } failure:^(NSURLSessionDataTask *task, NSError * error) {
               self.request.state = RequestStateFailed;
               if (self.request.completion) {
                   self.request.completion(self.request, error);
               }
               self.finished = YES;
               self.executing = NO;
           }];
       }
}
 
/*
//是否同步
- (BOOL)isAsynchronous{
    return YES;
}
 */

@end
