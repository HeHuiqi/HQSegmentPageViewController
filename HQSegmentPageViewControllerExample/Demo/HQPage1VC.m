//
//  HQPage1VC.m
//  HqUtils
//
//  Created by hehuiqi on 4/22/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HQPage1VC.h"
#import "HqPageDetailVC.h"
#import "MJRefreshAutoNormalFooter.h"
@interface HQPage1VC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSMutableArray *datas;

@end

@implementation HQPage1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datas = [[NSMutableArray alloc] init];
    for (int i = 0; i<30; i++) {
        [self.datas addObject:@""];
    }
    [self  initView];
}
- (void)initView{
    [self.view addSubview:self.tableView];
    self.scrollView = self.tableView;

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];

    self.tableView.mj_footer = footer;
   
}
- (void)refreshData{
    [super refreshData];
    //刷新数据
    NSLog(@"刷新--%@--数据",self.title);
}
- (void)loadData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"end=endRefreshing=");
        [self.tableView.mj_footer endRefreshing];
    });
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-138);
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text = [self.title stringByAppendingFormat:@"-%@",@(indexPath.row)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HqPageDetailVC *vc = [[HqPageDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 请求
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
