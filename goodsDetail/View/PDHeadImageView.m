//
//  PDHeadImageView.m
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDHeadImageView.h"
#import "ProductV2.h"
#import "PhotoItem.h"

@interface PDHeadImageView ()

@end

@implementation PDHeadImageView
- (void)setPhotoItem:(PhotoItem *)photoItem
{
    _photoItem = photoItem;
    
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;

    [self setImage:[UIImage imageNamed:photoItem.img]];
}


@end
