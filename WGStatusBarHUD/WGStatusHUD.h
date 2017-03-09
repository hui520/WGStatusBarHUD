//
//  WGStatusHUD.h
//  WGStatusBarHUD
//
//  Created by workguy on 2017/3/1.
//  Copyright © 2017年 workguy. All rights reserved.
//  0.0.0


#import <UIKit/UIKit.h>

@interface WGStatusHUD : NSObject
/**加载成功信息*/
+ (void)showSuccess:(NSString *)info;

/**加载失败信息*/
+ (void)showError:(NSString *)info;

/**加载正在加载信息*/
+ (void)showLoading:(NSString *)info;

/**隐藏*/
+ (void)hide;

//显示文字
+ (void)showMessage:(NSString *)msg image:(UIImage *)image;

@end
