//
//  AppDelegate.h
//  OprationDownload
//
//  Created by OFweek01 on 2020/12/23.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;
@property (strong, nonatomic) NSOperationQueue *downLoadQueue;
@property (strong, nonatomic) NSMutableArray *uploadArray;

@end

