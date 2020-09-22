//
//  ViewController.m
//  TheQueue
//
//  Created by OFweek01 on 2020/9/22.
//  Copyright © 2020 OFweek01. All rights reserved.
//

#import "ViewController.h"
#import "PendingOperations.h"
#import "NetworkUtil.h"

@interface ViewController ()

@property (nonatomic, assign) int index1;
@property (nonatomic, assign) int index2;
@property (nonatomic, assign) int index3;
@property (nonatomic, assign) int index4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [PendingOperations.shareManager.requestQueue addObserver:self forKeyPath:@"operationCount" options:0 context:nil];
}

int i = 1;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (i % 2 == 0) {
        [self addRequests];
    } else {
        OFRequest *request = [[OFRequest alloc]init];
        request.url = @"http://www.weather.com.cn/data/sk/101010100.html";
        request.requestMethod = GET;
        request.tag = @"5";
        [NetworkUtil.shareManager requestPOSTWithQueue:request completion:^(RequestState state, id  _Nonnull result) {
            //self.index4 = 4;
            [self refresh];
            NSLog(@"5--> %@",result);
        }];
    }
    //i++;
    
}

- (void)addRequests {
    _index1 = 0;
    _index2 = 0;
    _index3 = 0;
    _index4 = 0;
    {
        OFRequest *request = [[OFRequest alloc]init];
        request.url = @"http://www.weather.com.cn/data/sk/101010100.html";
        request.requestMethod = GET;
        request.tag = @"1";
        [NetworkUtil.shareManager requestPOSTWithQueue:request completion:^(RequestState state, id  _Nonnull result) {
            self.index1 = 1;
            [self refresh];
            NSLog(@"1--> %@",result);
        }];
    }
    
    {
        OFRequest *request = [[OFRequest alloc]init];
        request.url = @"http://www.weather.com.cn/data/sk/101010100.html";
        request.requestMethod = GET;
        request.tag = @"2";
        [NetworkUtil.shareManager requestPOSTWithQueue:request completion:^(RequestState state, id  _Nonnull result) {
            self.index2 = 2;
            [self refresh];
            NSLog(@"2--> %@",result);
        }];
    }
    
    {
        OFRequest *request = [[OFRequest alloc]init];
        request.url = @"http://www.weather.com.cn/data/sk/101010100.html";
        request.requestMethod = GET;
        request.tag = @"3";
        [NetworkUtil.shareManager requestPOSTWithQueue:request completion:^(RequestState state, id  _Nonnull result) {
            self.index3 = 3;
            [self refresh];
            NSLog(@"3--> %@",result);
        }];
    }
    
    {
        OFRequest *request = [[OFRequest alloc]init];
        request.url = @"http://www.weather.com.cn/data/sk/101010100.html";
        request.requestMethod = GET;
        request.tag = @"4";
        [NetworkUtil.shareManager requestPOSTWithQueue:request completion:^(RequestState state, id  _Nonnull result) {
            self.index4 = 4;
            [self refresh];
            NSLog(@"4--> %@",result);
        }];
    }
}

- (void)refresh {

}

- (void)dealloc
{
    [PendingOperations.shareManager.requestQueue removeObserver:self forKeyPath:@"operationCount"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"operationCount"]) {
        NSOperationQueue *queue = (NSOperationQueue *)object;
        //NSLog(@"operationCount %lu", (unsigned long)queue.operationCount);
        // 返回当前队列中的操作数量，对应 operations.count
        if (queue.operationCount == 0) {
            //主线程刷新界面
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"操作完成");
                NSLog(@"%d-%d-%d-%d",self->_index1, self->_index2, self->_index3, self->_index4);
                //NSLog(@"%d===",__LINE__);
            });
        }
    }
}


@end
