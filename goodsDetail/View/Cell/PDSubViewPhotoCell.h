//
//  PDSubViewPhotoCell.h
//  iWedding
//
//  Created by jack steven on 11/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoItem.h"

@interface PDSubViewPhotoCell : UITableViewCell
@property(nonatomic,strong) PhotoItem *photoItem;
- (CGFloat)cellHeight;
@end
