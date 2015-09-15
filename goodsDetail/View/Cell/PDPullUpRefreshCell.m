//
//  PDPullUpRefreshCell.m
//  iWedding
//
//  Created by jack steven on 12/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDPullUpRefreshCell.h"

@interface PDPullUpRefreshCell (){
    
}
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView2;

@end

@implementation PDPullUpRefreshCell

- (void)awakeFromNib {
    self.lineView1.backgroundColor = [UIColor grayColor];
    self.lineView2.backgroundColor = [UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)cellHeight{
    return 44;
}

@end
