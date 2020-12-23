//
//  DownLoadTool.h
//  OprationDownload
//
//  Created by OFweek01 on 2020/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownLoadTool : NSObject

/// 下载视频的接口
- (void)downLoadWithUrl:(NSString *)videoUrl videoPath:(NSString *)videoPath videoPlist:(NSString *)videoPlist videoName:(NSString *)videoName;

@end

NS_ASSUME_NONNULL_END
