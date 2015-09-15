//
//  PDSubViewPhotoCell.m
//  iWedding
//
//  Created by jack steven on 11/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDSubViewPhotoCell.h"

@interface PDSubViewPhotoCell(){
    
}
@property (weak, nonatomic) IBOutlet UIImageView *subViewimageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightLC;

@end

@implementation PDSubViewPhotoCell

- (void)awakeFromNib {
    // Initialization code
    self.subViewimageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPhotoItem:(PhotoItem *)photoItem{
    _photoItem = photoItem;
    CGFloat coverIVWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat coverIVHeight = photoItem.height * coverIVWidth / photoItem.width;
    _imageViewHeightLC.constant = coverIVHeight;
    
    [_subViewimageView setImage:[UIImage imageNamed:photoItem.img]];
}

-(CGFloat)cellHeight
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat height = [self.subViewimageView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

@end
