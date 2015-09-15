//
//  PDBaseTableCell.h
//  iWedding
//
//  Created by jack steven on 18/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductV2.h"

@interface PDBaseTableCell : UITableViewCell
@property(nonatomic,strong) ProductV2 *product;
@property(nonatomic,strong) NSIndexPath *indexPath;
@end
