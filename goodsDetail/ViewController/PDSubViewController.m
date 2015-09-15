//
//  PDSubViewController.m
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDSubViewController.h"
#import "PDSubViewPhotoCell.h"

@interface PDSubViewController ()
@property (strong, nonatomic) IBOutlet UITableViewCell *topViewCell;

@end

@implementation PDSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    if (self.tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-64)];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.showsVerticalScrollIndicator = YES;
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
    }

    UINib *nib = [UINib nibWithNibName:@"PDSubViewPhotoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.topViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addRefreshView];
}

- (void)setDataArray:(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithArray:dataArray];
//        [self.tableView reloadData];
    }
}

- (void)setProduct:(ProductV2 *)product{
    _product = product;

}

- (void)addRefreshView {
    if (self.pullFreshView == nil) {
        self.pullFreshView = [[PDPullDownRefreshView alloc]initWithFrame:CGRectMake(0, -34, [UIScreen mainScreen].bounds.size.width, 34)];
        self.pullFreshView.backgroundColor = [UIColor clearColor];
    }
    
    if (!self.pullFreshView.superview) {
        [self.pullFreshView setupWithOwner:self.tableView delegate:(id<PDPullDownRefreshViewDelegate>)self.mainViewController];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.pullFreshView scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pullFreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 54;
    }


    return 100 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return _topViewCell;
    }
    PDSubViewPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    [cell setPhotoItem:self.dataArray[indexPath.row-1]];
    
    return cell;
}

#pragma mark - private method

@end
