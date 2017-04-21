//
//  JCSaplingRefreshFooter.m
//  JCCustomRefresh
//
//  Created by xingjian on 2017/4/7.
//  Copyright © 2017年 xingjian. All rights reserved.
//

#import "JCSaplingRefreshFooter.h"

@implementation JCSaplingRefreshFooter
#pragma mark - 重写方法
- (void)placeSubviews
{
    [super placeSubviews];
    self.mj_h = 60;

}
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
  
//    // 设置普通状态的动画图片30
    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 0; i<100; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"下拉刷新_太阳_000%zd", 0]];
//        [idleImages addObject:image];
//    }
    for (NSUInteger i = 0; i<=20; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"小叶子_000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）89
    NSMutableArray *refreshingImages = [NSMutableArray array];
        for (NSUInteger i = 0; i<10; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"小叶子_000%zd", 21]];
            [refreshingImages addObject:image];
        }

    for (NSUInteger i = 21; i<=119; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"小叶子_000%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:3.5 forState:MJRefreshStateRefreshing];

  

    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
