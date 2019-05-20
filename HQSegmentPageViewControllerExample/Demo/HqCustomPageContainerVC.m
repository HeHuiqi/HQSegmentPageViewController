//
//  HqCustomPageContainerVC.m
//  HqUtils
//
//  Created by hehuiqi on 5/19/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#import "HqCustomPageContainerVC.h"

@interface HqCustomPageContainerVC ()

@end

@implementation HqCustomPageContainerVC

- (instancetype)init{
    if (self = [super init]) {
        self.pageItems = @[self.pageV1,self.pageV2,self.pageV3];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self hqAddChildVCWithindex:self.currentPageIndex];
}

- (HQPage1VC *)pageV1{
    if (!_pageV1) {
        _pageV1 = [[HQPage1VC alloc] init];
        _pageV1.title = @"HQPage1VC";
//        _pageV1.delegate = self;
        
    }
    return _pageV1;
}

- (HQPage2VC *)pageV2{
    if (!_pageV2) {
        _pageV2 = [[HQPage2VC alloc] init];
        _pageV2.title = @"HQPage2VC";
//        _pageV2.delegate = self;
    }
    return _pageV2;
}
- (HqPage3VC *)pageV3{
    if (!_pageV3) {
        _pageV3 = [[HqPage3VC alloc] init];
        _pageV3.title = @"HQPage3VC";
//        _pageV3.delegate = self;
        
    }
    return _pageV3;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
