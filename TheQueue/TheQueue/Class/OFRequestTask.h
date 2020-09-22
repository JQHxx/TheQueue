//
//  OFRequestTask.h
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class OFRequest;
@interface OFRequestTask : NSOperation

- (instancetype)initWithRequest:(OFRequest *)request;

@end

NS_ASSUME_NONNULL_END
