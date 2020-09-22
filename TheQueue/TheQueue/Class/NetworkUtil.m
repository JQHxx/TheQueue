//
//  NetworkUtil.m
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import "NetworkUtil.h"
#import "PendingOperations.h"
#import "OFRequestTask.h"

@interface NetworkUtil()

@property (nonatomic, strong) NSMutableDictionary *operationDict;

@end

@implementation NetworkUtil

static NetworkUtil *_instance = nil;
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NetworkUtil alloc]init];
    });
    return _instance;
}

- (void)requestPOSTWithQueue:(OFRequest *)request
                  completion:(void(^)(RequestState state, id result))callback {
    if (request.tag) {
        if([self.operationDict.allKeys containsObject:request.tag]) {
            return;
        }
    }
    OFRequest *mRequest = request;
    mRequest.completion = ^(OFRequest *resRequest, id  _Nonnull result) {
        /*
        if (resRequest.state == RequestStateSuccess) {
            // 成功时重新启动操作队列
            [PendingOperations.shareManager resumeAllOperations];
        } else {
            // 失败时重置操作队列
            [PendingOperations.shareManager resetAllOperations];
        }
         */
        [PendingOperations.shareManager resumeAllOperations];
        if (callback) {
            callback(resRequest.state, result);
        }
        if (request.tag) {
            [self.operationDict removeObjectForKey:request.tag];
        }
    };
    OFRequestTask *requestTask = [[OFRequestTask alloc]initWithRequest:mRequest];
    [PendingOperations.shareManager.requestQueue addOperation:requestTask];
    if (request.tag) {
        [self.operationDict setValue:requestTask forKey:request.tag];
    }
}

#pragma mark - Setter & Getter
- (NSMutableDictionary *)requestDict {
    if (!_operationDict) {
        _operationDict = [NSMutableDictionary dictionary];
    }
    return _operationDict;
}

@end
