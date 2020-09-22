//
//  NetworkUtil.h
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OFRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkUtil : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *operationDict;

+ (instancetype)shareManager;

- (void)requestPOSTWithQueue:(OFRequest *)request
                  completion:(void(^)(RequestState state, id result))callback;

@end

NS_ASSUME_NONNULL_END
