//
//  JCSunRefreshHeader.m
//  JCCustomRefresh
//
//  Created by xingjian on 2017/4/7.
//  Copyright © 2017年 xingjian. All rights reserved.
//

#import "JCSunRefreshHeader.h"

@implementation JCSunRefreshHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    // 设置普通状态的动画图片30
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<100; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"下拉刷新_太阳_000%zd", 0]];
        [idleImages addObject:image];
    }
    for (NSUInteger i = 0; i<=30; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"下拉刷新_太阳_000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）89
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 31; i<=78; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"下拉刷新_太阳_000%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];

    
//    // 设置正在刷新状态的动画图片
//    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:1.5 forState:MJRefreshStateRefreshing];

    
}

@end
