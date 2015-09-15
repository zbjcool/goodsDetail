//
//  PDSubViewController.h
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDPullDownRefreshView.h"
#import "ProductV2.h"

@interface PDSubViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, weak) UIViewController *mainViewController;
@property(nonatomic, strong) PDPullDownRefreshView *pullFreshView;
@property(nonatomic) BOOL isFromScrollView;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) ProductV2 *product;

@end
