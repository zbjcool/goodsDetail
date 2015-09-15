//
//  PDHeaderView.h
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductV2;

@interface PDHeaderView :UIView
@property(nonatomic,strong)void(^refreshView)(void);
@property(nonatomic,strong)ProductV2 *product;

-(CGFloat)cellHeight;
@end
