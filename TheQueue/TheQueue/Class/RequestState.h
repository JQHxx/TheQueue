//
//  RequestState.h
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

//请求状态枚举
typedef enum _RequestState {
    RequestStateNew  = 0,
    RequestStatesStart,
    RequestStateFailed,
    RequestStateSuccess
} RequestState;

typedef enum _RequestMethod {
    GET  = 0,
    POST,
} RequestMethod;
