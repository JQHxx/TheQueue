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

@end

@implementation OFRequestTask

- (instancetype)initWithRequest:(OFRequest *)request
{
    self = [super init];
    if (self) {
        _request = request;
    }
    return self;
}

- (void)main {
    // 每次启动一个operation时将整个队列挂起，暂停所有operations
    [[PendingOperations shareManager] suspendAllOperations];
    
    /***  网络请求 工具类  ***/
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    _request.state = RequestStatesStart;
    if (_request.requestMethod == GET) {
        
        [manager GET:_request.url parameters:_request.params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.request.state = RequestStateSuccess;
            if (self.request.completion) {
                self.request.completion(self.request, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.request.state = RequestStateFailed;
            if (self.request.completion) {
                self.request.completion(self.request, error);
            }
        }];
    } else {
        [manager POST:_request.url parameters:_request.params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            self.request.state = RequestStateSuccess;
            if (self.request.completion) {
                self.request.completion(self.request, responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError * error) {
            self.request.state = RequestStateFailed;
            if (self.request.completion) {
                self.request.completion(self.request, error);
            }
        }];
    }

}

@end
