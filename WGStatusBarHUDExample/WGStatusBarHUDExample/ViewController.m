//
//  ViewController.m
//  WGStatusBarHUDExample
//
//  Created by workguy on 2017/3/5.
//  Copyright © 2017年 workguy. All rights reserved.
//

#import "ViewController.h"
#import "WGStatusHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self back];
}

- (IBAction)success:(id)sender
{
    [WGStatusHUD showSuccess:@"加载成功"];
}
- (IBAction)failure:(id)sender
{
    [WGStatusHUD showError:@"加载失败"];
}
- (IBAction)loading:(id)sender
{
    [WGStatusHUD showLoading:@"正在加载中...."];
}
- (IBAction)hide:(id)sender
{
    [WGStatusHUD hide];
}
- (IBAction)showMessage
{
    [WGStatusHUD showMessage:@"天气不错" image:nil];
}

- (void)back
{
    NSLog(@"我小灰灰又回来了");
}

@end
