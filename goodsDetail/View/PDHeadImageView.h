//
//  PDHeadImageView.h
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoItem;

@interface PDHeadImageView : UIImageView

@property(nonatomic,strong) PhotoItem *photoItem;
-(void)setHeadImage:(PhotoItem *)headPhoto;

@end
