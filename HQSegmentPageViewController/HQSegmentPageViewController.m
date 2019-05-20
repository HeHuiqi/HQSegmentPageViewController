//
//  HQSegmentPageViewController.m
//  HqUtils
//
//  Created by hehuiqi on 4/22/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HQSegmentPageViewController.h"
#define IS_iPhoneX (UIScreen.mainScreen.bounds.size.width >= 375.f && UIScreen.mainScreen.bounds.size.height >= 812.f)

@interface HQSegmentPageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) CGFloat navBarHeight;


@end

@implementation HQSegmentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    _headerViewHeight = 150;
    _sectionHeaderHeight = 50;
    
    self.containerCanScroll = YES;

    //主视图
    [self.view addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = self.headerView;
    
    [self scrollViewDidScroll:self.mainTableView];

    
}
#pragma mark - set
- (void)setContainerCanScroll:(BOOL)containerCanScroll{
    _containerCanScroll = containerCanScroll;
    self.mainTableView.showsVerticalScrollIndicator = _containerCanScroll;
}
- (void)setHeaderViewHeight:(CGFloat)headerViewHeight{
    _headerViewHeight = headerViewHeight;
    if (_headerViewHeight>0) {
        CGRect bounds = self.headerView.bounds;
        bounds.size.height = _headerViewHeight;
        self.headerView.bounds = bounds;
        self.mainTableView.tableHeaderView = self.headerView;
    }
}
- (void)setSectionHeaderHeight:(CGFloat)sectionHeaderHeight{
    _sectionHeaderHeight = sectionHeaderHeight;
    if (_sectionHeaderHeight>0) {
        CGRect bounds = self.sectionHeaderView.bounds;
        bounds.size.height = _sectionHeaderHeight;
        self.sectionHeaderView.bounds = bounds;
        [self.mainTableView reloadData];
    }
}
- (CGFloat )navBarHeight{
    BOOL device = IS_iPhoneX;
    CGFloat barHeight = 64;
    if (device) {
        barHeight = 88;
    }
    return barHeight;
}
#pragma mark get
- (UIScrollView *)mainTableView{
    if (!_mainTableView) {
        CGRect rect = CGRectMake(0, self.navBarHeight, self.view.bounds.size.width, self.view.bounds.size.height-self.navBarHeight);
        _mainTableView = [[HqTableView alloc] initWithFrame:rect];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainTableView.alwaysBounceVertical = YES;
    }
    return _mainTableView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, _headerViewHeight);
        _headerView.backgroundColor = [UIColor greenColor];
    }
    return _headerView;
}
- (UIView *)sectionHeaderView{
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[UIView alloc] init];
        _sectionHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _sectionHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, _sectionHeaderHeight);
    }
    return _sectionHeaderView;
}
//自行改变
- (UISegmentedControl *)segment{
    if (!_segment) {
        
        UISegmentedControl *sg = [[UISegmentedControl alloc] initWithItems:@[@"P1",@"p2",@"p3"]];
        sg.frame  = CGRectMake(0, 10, SCREEN_WIDTH, 30);
        [sg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
        sg.selectedSegmentIndex = 0;
        _segment = sg;
    }
    return _segment;
}
- (void)segChange:(UISegmentedControl *)sg{
    
    NSInteger index = sg.selectedSegmentIndex;
    
    [self pageContainerScrollToindex:index animated:YES];
    
}
- (void)pageContainerScrollToindex:(NSInteger)index animated:(BOOL)animated{
    [self.pageContainerVC scrollToIndex:index animated:animated];

}
//设置自定义的HqCustomPageContainerVC
- (void)setPageContainerVC:(HqPageContainerVC *)pageContainerVC{
    _pageContainerVC = pageContainerVC;
    if (_pageContainerVC) {
        _pageContainerVC.delegate = self;
    }
    [self.mainTableView reloadData];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    [self.sectionHeaderView addSubview:self.segment];
    return self.sectionHeaderView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.sectionHeaderHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT-self.navBarHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"segment"];
    if (self.pageContainerVC) {
        [self addChildViewController:self.pageContainerVC];
        [cell addSubview:self.pageContainerVC.view];
        self.pageContainerVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.bounds.size.height-self.navBarHeight);
    }

    return cell;
}

#pragma mark - HqPageViewProtocol
- (void)mainScrollViewCanScroll{
    self.containerCanScroll = YES;
}
- (void)pageContainerScrollViewToIndex:(NSInteger)index{
    self.segment.selectedSegmentIndex = index;
}
- (void)mainScrollViewScrollEnabled:(BOOL)scrollEnabled{
    self.mainTableView.scrollEnabled = scrollEnabled;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    CGFloat shvY = [self.mainTableView rectForHeaderInSection:0].origin.y;
    if (y>=shvY) {
        self.containerCanScroll = NO;
        scrollView.contentOffset = CGPointMake(0, shvY);
        [self.pageContainerVC updatePageItemCanScroll];
    }else{
        if (!self.containerCanScroll) {
            scrollView.contentOffset = CGPointMake(0, shvY);
            [self.pageContainerVC updatePageItemCanScroll];
        }
    }
}

@end
