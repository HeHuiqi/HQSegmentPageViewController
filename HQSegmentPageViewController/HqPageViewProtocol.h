//
//  HqPageViewProtocol.h
//  HqUtils
//
//  Created by hehuiqi on 4/22/19.
//  Copyright © 2019 hhq. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width     //屏幕宽度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height    //屏幕高度

#import <UIKit/UIKit.h>

@class HqPageItemSuperVC;
typedef void(^HqScrollViewOffetYBlock)(CGFloat offsetY);

typedef void(^HqPageItemScrollViewOffetYBlock)(HqPageItemSuperVC * _Nonnull vc,CGFloat offsetY);


NS_ASSUME_NONNULL_BEGIN

@protocol HqPageViewProtocol <NSObject>

@optional
//由HqPageItemViewSuperVC实现
- (void)hqPageItemVC:(HqPageItemSuperVC *)vc scrollViewOffetY:(CGFloat)offsetY;
// 由HqPageContainerVC 实现
- (void)mainScrollViewCanScroll;
- (void)mainScrollViewScrollEnabled:(BOOL)scrollEnabled;
- (void)pageContainerScrollViewToIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
