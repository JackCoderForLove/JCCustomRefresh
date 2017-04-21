//
//  ViewController.m
//  JCCustomRefresh
//
//  Created by xingjian on 2017/4/7.
//  Copyright © 2017年 xingjian. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "JCSunRefreshHeader.h"
#import "JCSaplingRefreshFooter.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * jcTable;
@property (nonatomic,strong)NSArray * jcData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.title = @"JC自定义下拉刷新";
    self.jcData = @[@"大狗",@"二猪",@"三驴",@"四猫"];
    [self.view addSubview:self.jcTable];
    self.jcTable.tableFooterView = [UIView new];
    [self configJCHeader];
    [self configJCFooter];

    // Do any additional setup after loading the view, typically from a nib.
}
//双指针引用测试
- (void)jcDoublePointerTest
{
    //onStr是个指针，指向空
    
    NSString  *onStr = nil;
    
    NSLog(@"11111对象的值%@----对象的地址%p-----指针的地址%p-----",onStr,onStr,&onStr);
    //调用创建方法
    [self onePoit:&onStr];
    NSLog(@"44444对象的值%@----对象的地址%p-----指针的地址%p-----",onStr,onStr,&onStr);
    int  a = 10;
    int  b = 20;
    //不做const限制
    int *p = &a;
    p = &b;
    //常指针
    int * const j = &a;
    //   j = &b;常指针，不能修改j的指向，但是可以修改j的值
    *j = 30;
    
    //常量
    int  const * k = &a;
    // *k = 30; 不能修改指针指向内容的值，但是可以修改指针的指向
    k = &b;
    
    //常指针常量
    int const *  const m = &a;
    //*m = 100; 不能修改m指向内容的值
    //m = &b; 不能修改m的指向
    
    NSString *  const a1 = @"a1";
    //a1 = @"bbb";//不能修改a1的指向
    [a1 stringByAppendingString:@"abc"];
    NSLog(@"%@",a1);
    NSString const * b1 = @"b1";
    b1 = [b1 stringByAppendingString:@"ccc"];
    NSString * jcAB = @"ccc";
    jcAB =[jcAB stringByAppendingString:@"ddd"];
    NSLog(@"jcAB------%@",jcAB);
    

}
- (void)onePoit:(NSString **)jcStr
{
    NSLog(@"22222对象的值%@----对象的地址%p-----指针的地址%p-----",*jcStr,jcStr,&jcStr);

    *jcStr = @"abc";
    NSLog(@"33333对象的值%@----对象的地址%p-----指针的地址%p-----",*jcStr,jcStr,&jcStr);

}
- (void)configJCHeader
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    JCSunRefreshHeader *header = [JCSunRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    
//    // 隐藏状态
//    header.stateLabel.hidden = YES;
//    
//    // 马上进入刷新状态
//    [header beginRefreshing];
//    
//    // 设置header
//    self.jcTable.mj_header = header;
    self.jcTable.mj_header =  [JCSunRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.jcTable.mj_header beginRefreshing];

}
- (void)configJCFooter
{
    JCSaplingRefreshFooter *footer = [JCSaplingRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
  
    // 隐藏状态
    footer.stateLabel.hidden = YES;
    self.jcTable.mj_footer = footer;

    
}
#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.jcTable;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}
#pragma mark - 数据处理相关
#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.jcTable;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_footer endRefreshing];
    });
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jcData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * jcCellID = @"jcCellID";
    UITableViewCell * jcCell = [tableView dequeueReusableCellWithIdentifier:jcCellID];
    if (!jcCell) {
        jcCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jcCellID];
        if (indexPath.row<self.jcData.count) {
            jcCell.textLabel.text = [self.jcData objectAtIndex:indexPath.row];
        }
    }
    return jcCell;
}
- (UITableView *)jcTable
{
    if (!_jcTable) {
        _jcTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _jcTable.delegate = self;
        _jcTable.dataSource = self;
       
    }
    return _jcTable;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
