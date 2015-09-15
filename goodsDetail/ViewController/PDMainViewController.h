//
//  PDMainViewController.h
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDSubViewController.h"
#import "PDPullUpRefreshView.h"
#import "PDBaseTableCell.h"
#import "ProductV2.h"

@interface PDMainViewController : UIViewController<PDPullUpRefreshViewDelegate,PDPullDownRefreshViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    BOOL _hasEndTheVC;
}
@property (nonatomic, strong) ProductV2 *product;
@end
