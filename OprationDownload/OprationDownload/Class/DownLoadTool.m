//
//  DownLoadTool.m
//  OprationDownload
//
//  Created by OFweek01 on 2020/12/23.
//

#import "DownLoadTool.h"
#import "VideoOpration.h"
#import "AppDelegate.h"

@implementation DownLoadTool

- (void)downLoadWithUrl:(NSString *)videoUrl videoPath:(NSString *)videoPath videoPlist:(NSString *)videoPlist videoName:(NSString *)videoName{
    VideoOpration *opration = [[VideoOpration alloc] init]; /// 创建下载操作线程
    // 传递关键信息
    opration.videoUrl = videoUrl;
    opration.videoName = videoName;
    opration.videoPath = videoPath;
    opration.videoPlist = videoPlist;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.downLoadQueue addOperation:opration]; /// 将下载线程加进队列里
    [delegate.uploadArray addObject:opration];  /// 将队列加进全局数组
}

@end


/*
 在下载列表页 创建tableView 创建一个获取下载进度的计时器

 [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
 - (void)timerAction{
     [self.listTableView reloadData];
 }

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *reuse = @"reuse";
     DownLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
     if (!cell) {
         cell = [[DownLoadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
     }
     AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     VideoOpration *opration = delegate.uploadArray[indexPath.row];
     [cell refreshui:opration];
     return cell;
 }



 cell.m 中

 - (void)refreshui:(VideoOpration *)opration{
     self.videoOption = opration;
     self.progressLabel.text = [NSString stringWithFormat:@"%f",opration.progress];
    // NSLog(@"-=-=-=-=%f",opration.progress);
 }

 - (void)pauseAction{
     if (self.play == YES) {
         [self.videoOption pauseAction];  暂停点击实现
     }else{
         [self.videoOption continiueAction]; 继续点击实现
     }
     self.play = !self.play;
 }
 */
