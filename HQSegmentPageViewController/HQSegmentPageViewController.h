//
//  HQSegmentPageViewController.h
//  HqUtils
//
//  Created by hehuiqi on 4/22/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HqTableView.h"
#import "HqPageContainerVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HQSegmentPageViewController : UIViewController<HqPageViewProtocol>

@property(nonatomic,strong) HqTableView *mainTableView;
@property(nonatomic,assign) BOOL containerCanScroll;


@property(nonatomic,strong) UIView *headerView;//可自定义配置
@property (nonatomic,assign) CGFloat headerViewHeight;

@property (nonatomic,strong) UISegmentedControl *segment;//
@property(nonatomic,strong) UIView *sectionHeaderView;//可自定义配置
@property (nonatomic,assign) CGFloat sectionHeaderHeight;

@property(nonatomic,strong) HqPageContainerVC *pageContainerVC;

//子类重写或直接调用
- (void)pageContainerScrollToindex:(NSInteger)index animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
