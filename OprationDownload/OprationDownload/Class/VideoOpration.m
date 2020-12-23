//
//  VideoOpration.m
//  OprationDownload
//
//  Created by OFweek01 on 2020/12/23.
//

#import "VideoOpration.h"
#import <AFNetworking.h>

@interface VideoOpration()

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation VideoOpration

- (void)main{
    //网络视频地址
    NSURL *URL = [NSURL URLWithString:self.videoUrl];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //下载Task操作
    self.downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull          downloadProgress) {
        //downloadProgress.totalUnitCount; 文件的总大小
        //downloadProgress.completedUnitCount; 当前已经下载的大小
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
           self.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        return [NSURL fileURLWithPath:self.videoPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable       error) {
              // 每次APP启动沙盒路径都会改变，，只存储视频名字，，每次取出时获取沙盒路径进行拼接得到视频路径
        NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:self.videoPlist];
        if (arr.count == 0) {
            arr = [NSMutableArray arrayWithObject:self.videoName];
        }else{
            [arr addObject:self.videoName];
        }
        [NSKeyedArchiver archiveRootObject:arr toFile:self.videoPlist];
    }];
     // 开始下载 需要有这句话 没有的话不开始下载
    [self.downloadTask resume];
}
- (void)pauseAction{
    [self.downloadTask suspend]; // 暂停下载
}
- (void)continiueAction{
    [self.downloadTask resume]; // 继续下载
}

@end
