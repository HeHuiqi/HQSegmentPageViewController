//
//  ViewController.m
//  HQSegmentPageViewControllerExample
//
//  Created by hehuiqi on 5/20/19.
//  Copyright © 2019 hehuiqi. All rights reserved.
//

#import "ViewController.h"
#import "HqCustomSegmentPageVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lab = [[UILabel alloc] init];
    [self.view addSubview:lab];
    lab.text = @"点击屏幕";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = self.view.bounds;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    HqCustomSegmentPageVC *vc = [[HqCustomSegmentPageVC alloc] init];
    [self.navigationController pushViewController:vc
                                         animated:YES];
}


@end
