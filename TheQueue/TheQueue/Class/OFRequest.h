//
//  OFRequest.h
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestState.h"

NS_ASSUME_NONNULL_BEGIN

@interface OFRequest : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, assign) RequestState state;
@property (nonatomic, assign) RequestMethod requestMethod;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) void(^completion)(OFRequest *request, id result);

@end

NS_ASSUME_NONNULL_END
