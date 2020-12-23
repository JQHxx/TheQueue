//
//  VideoOpration.h
//  OprationDownload
//
//  Created by OFweek01 on 2020/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoOpration : NSOperation

@property (nonatomic, strong) NSString *videoUrl; // 视频地址
@property (nonatomic, strong) NSString *videoPath; // 本地存储地址
@property (nonatomic, strong) NSString *videoPlist; // 存放下载列表地址
@property (nonatomic, strong) NSString *videoName; // 视频的名字
@property (nonatomic, assign) float progress; //下载进度
- (void)pauseAction; // 下载暂停
- (void)continiueAction; // 下载继续

@end

NS_ASSUME_NONNULL_END
