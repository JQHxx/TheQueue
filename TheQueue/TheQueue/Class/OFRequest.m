//
//  OFRequest.m
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import "OFRequest.h"

@implementation OFRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _state = RequestStateNew;
    }
    return self;
}

@end
