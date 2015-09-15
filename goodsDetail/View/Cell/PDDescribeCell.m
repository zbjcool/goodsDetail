//
//  PDDescribeCell.m
//  iWedding
//
//  Created by jack steven on 12/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDDescribeCell.h"

@interface PDDescribeCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property(nonatomic,weak) IBOutlet UIView *innerView;
@end

@implementation PDDescribeCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor grayColor];
    self.contentLabel.textColor = [UIColor blackColor];
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 16*2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProduct:(ProductV2 *)product{
    self.contentLabel.text = product.desc;
    [super setProduct:product];
}

- (CGFloat)cellHeight{
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGFloat height = [self.innerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    height += 10;
    return height;
}
@end
