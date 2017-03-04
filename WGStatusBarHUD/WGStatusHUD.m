//
//  WGStatusHUD.m
//  WGStatusBarHUD
//
//  Created by workguy on 2017/3/1.
//  Copyright © 2017年 workguy. All rights reserved.
//

#import "WGStatusHUD.h"

#define WGTextFont [UIFont systemFontOfSize:14]
//消息停留时间
static CGFloat const WGMessageDuration = 2.0;
//消息的动画时间
static CGFloat const WGAnimationDuration = 0.25;


@implementation WGStatusHUD

/**全局窗口*/
static UIWindow *window_;

/**定时器*/
static NSTimer * timer_;

//显示窗口
+ (void)showWindow
{
    //frame数据
    CGFloat windowH = 30;
    CGRect frame = CGRectMake(0, -windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    
    //显示窗口
    window_.hidden = YES;
    window_ = [[UIWindow alloc] init];
    window_.frame = frame;
    window_.hidden = NO;
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelStatusBar;
    
    //动画
    frame.origin.y = 0;
    [UIView animateWithDuration:WGAnimationDuration animations:^{
        window_.frame = frame;
    }];
}

+ (void)showMessage:(NSString *)msg image:(UIImage *)image
{
    //停止定时器
    [timer_ invalidate];
    
    [self showWindow];
    //添加按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = window_.bounds;
    if (image)
    {//有图片
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    [button setTitle:msg forState:UIControlStateNormal];
    button.titleLabel.font = WGTextFont;
    [window_ addSubview:button];
    
    //定时消失 dispatch 会有问题（eg.点了成功按钮1s后，再点失败按钮，失败样式只会持续1s就消失）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self hide];
//    });
    
    
    
//    NSObject * obj;
//    [WGStatusHUD cancelPreviousPerformRequestsWithTarget:obj selector:@selector(hide) object:nil];
//    [obj performSelector:@selector(hide) withObject:nil afterDelay:2.0];
    
    //创建定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:WGMessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

+ (void)showSuccess:(NSString *)info
{
    NSLog(@"%@",NSTemporaryDirectory());
    
    [WGStatusHUD showMessage:info image:[UIImage imageNamed:@"WGStatusBarHUD.bundle/success"]];
}

+ (void)showError:(NSString *)info
{
    [WGStatusHUD showMessage:info image:[UIImage imageNamed:@"WGStatusBarHUD.bundle/error"]];
}

+ (void)showLoading:(NSString *)info
{
    //停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    [self showWindow];
    //添加label
    UILabel * label = [[UILabel alloc] init];
    label.frame = window_.bounds;
    label.text = info;
    label.font = WGTextFont;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [window_ addSubview:label];
    
    //添加圈圈
    UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicatorView startAnimating];
    CGFloat infoW = [info sizeWithAttributes:@{NSFontAttributeName : WGTextFont}].width;
    CGFloat centerX = (window_.frame.size.width - infoW) * 0.5 - 20 ;
    CGFloat centerY = window_.frame.size.height * 0.5;
    indicatorView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:indicatorView];
}

+ (void)hide
{
    [UIView animateWithDuration:WGAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = - frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
}



@end
