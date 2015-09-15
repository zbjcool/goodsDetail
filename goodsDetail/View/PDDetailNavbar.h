//
//  PDDetailNavbar.h
//  iWedding
//
//  Created by jack steven on 05/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductV2.h"

@interface PDDetailNavbar : UIView
@property(nonatomic,strong) NSString* parentTrackName;
@property(nonatomic) CGFloat colorTransitionProgress;
@property(nonatomic,strong) ProductV2 *product;
@property(nonatomic,strong) void(^collectedBlock)(BOOL isCollected);
@property(nonatomic) BOOL isSnapshot;
@end
