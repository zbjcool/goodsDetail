//
//  PDMainViewController.m
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDMainViewController.h"
#import "PDHeaderView.h"
#import "PDBottomView.h"
#import "ProductV2.h"
#import "PDDetailNavbar.h"
#import "PDPullUpRefreshCell.h"
#import "PDDescribeCell.h"

@interface PDMainViewController (){
    int _cellNumber;
    CGFloat _topViewHeight;
}

@property(nonatomic, weak) IBOutlet UITableView *tableView;
@property(nonatomic, strong) PDSubViewController *subViewController;
@property (weak, nonatomic) IBOutlet PDDetailNavbar *navigationBar;
@property(nonatomic) BOOL isResponseToScroll;
@property(nonatomic, strong)PDPullUpRefreshView *pullFreshView;
@property(nonatomic) NSInteger refreshCounter;
@property (strong, nonatomic) IBOutlet PDHeaderView *headView;
@property (weak, nonatomic) IBOutlet PDBottomView *bottomView;
@property (strong, nonatomic) IBOutlet PDPullUpRefreshCell *pullRefreshCell;

@property (strong, nonatomic) IBOutlet PDDescribeCell *descibeCell;
@end

@implementation PDMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];


    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
        && [[UIApplication sharedApplication] respondsToSelector:NSSelectorFromString(@"setStatusBarStyle:")]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;

    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollsToTop = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.descibeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.pullRefreshCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.subViewController = [[PDSubViewController alloc] init];
    // TODO: edgeInsetTop 要放到上层去设置
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self loadUI];
    self.isResponseToScroll = YES;
    __weak PDMainViewController *_self = self;
    self.headView.refreshView = ^(){
        [_self resetUI];
    };
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _hasEndTheVC = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
        && [[UIApplication sharedApplication] respondsToSelector:NSSelectorFromString(@"setStatusBarStyle:")]) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        _hasEndTheVC = YES;
    }
}

#pragma mark - private method

-(void)setProductBaseCellInfo:(PDBaseTableCell *)cell rowIndex:(int)rowIndex product:(ProductV2*)product
{
    cell.indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    cell.product = product;
}

- (void)resetUI{
    _topViewHeight = [self.headView cellHeight];
    CGRect rect = self.headView.frame;
    rect.size.height = _topViewHeight;
    self.headView.frame = rect;
    self.tableView.tableHeaderView = self.headView;
}
- (void)setProduct:(ProductV2 *)product{
    _product = product;
    
}
- (void)loadUI{

    self.navigationBar.product = self.product;
    self.navigationBar.collectedBlock = ^(BOOL isCollected){
    };

    self.headView.product = self.product;
    _topViewHeight = [self.headView cellHeight];
    CGRect rect = self.headView.frame;
    rect.size.height = _topViewHeight;
    self.headView.frame = rect;
    self.tableView.tableHeaderView = self.headView;
    
     __block int rowIndex = 0;
    
    if (self.product.desc) {
        [self setProductBaseCellInfo:self.descibeCell rowIndex:rowIndex product:self.product];
        rowIndex ++;
    }

    if (self.product.detailPhotos.count > 0) {
        [self setProductBaseCellInfo:self.pullRefreshCell rowIndex:rowIndex product:self.product];
        rowIndex ++;
    }
  
    _cellNumber = rowIndex;
    [self.tableView reloadData];
    if (self.product.detailPhotos.count > 0) {
        [self addRefreshView];
        [self addSubPage];
    }
    
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height);
    
}


- (void)addRefreshView {
    if (self.pullFreshView == nil) {
        float originY = self.tableView.contentSize.height;
        self.pullFreshView = [[PDPullUpRefreshView alloc]initWithFrame:CGRectMake(0, originY, [UIScreen mainScreen].bounds.size.width, 0)];
    }
    
    if (!self.pullFreshView.superview) {
        [self.pullFreshView setupWithOwner:self.tableView delegate:self];
    }
}

- (void)addSubPage
{
    if (!self.subViewController) {
        return;
    }
    
    self.subViewController.mainViewController = self;
    self.subViewController.view.frame = CGRectMake(0, self.tableView.contentSize.height, self.view.frame.size.width, self.view.frame.size.height);
    self.subViewController.dataArray = self.product.detailPhotos;
    self.subViewController.product = self.product;
    [self.tableView addSubview:self.subViewController.view];
}

#pragma mark - PDPullUpRefreshViewDelegate

- (void)pullUpRefreshDidFinish
{
    if (!self.refreshCounter) {
        self.refreshCounter = 0;
    }
    
    // 上拉分页动画
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(-self.tableView.contentSize.height -50 , 0, 0, 0);
        self.subViewController.view.frame = CGRectMake(0, self.tableView.contentSize.height+50 + 64, self.view.frame.size.width, self.view.frame.size.height);
    }];

    self.isResponseToScroll = NO;
    self.tableView.bounces = NO;
    [self.pullFreshView stopLoading];
    self.pullFreshView.hidden = YES;
}

#pragma mark - PDPullDownRefreshViewDelegate

- (void)pullDownRefreshDidFinish
{
    [self.subViewController.pullFreshView stopLoading];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        // maintable重绘之后，contentsize要重新加上offset
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height);
        self.subViewController.view.frame = CGRectMake(0, self.tableView.contentSize.height, self.view.frame.size.width, self.view.frame.size.height);
    }];
    self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, self.tableView.contentOffset.y);

    self.tableView.bounces = YES;
    self.isResponseToScroll = YES;
    self.pullFreshView.hidden = NO;
}

#pragma mark - UIScrollView delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewWillBeginDragging:scrollView];
    } else {
        [self.subViewController.pullFreshView scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        CGPoint point = CGPointMake(scrollView.contentOffset.x, 0);
        scrollView.contentOffset = point;
    }
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewDidScroll:scrollView];
    } else {
        [self.subViewController.pullFreshView scrollViewDidScroll:scrollView];
    }
    CGFloat colorTransProgress = (scrollView.contentOffset.y)/[UIScreen mainScreen].bounds.size.width;
    if(colorTransProgress < 0) colorTransProgress = 0;
    if(colorTransProgress > 1) colorTransProgress = 1;
    if (!_hasEndTheVC) {
        self.navigationBar.colorTransitionProgress = colorTransProgress;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    } else {
        [self.subViewController.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewDidEndDecelerating:scrollView];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.descibeCell.indexPath.row)
        return _descibeCell.cellHeight;
    else if (indexPath.row == self.pullRefreshCell.indexPath.row)
        return _pullRefreshCell.cellHeight;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == self.descibeCell.indexPath.row)
            return _descibeCell;
    else if (indexPath.row == self.pullRefreshCell.indexPath.row)
            return _pullRefreshCell;
    else
        return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
