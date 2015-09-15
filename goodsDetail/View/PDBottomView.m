//
//  PDBottomView.m
//  iWedding
//
//  Created by jack steven on 05/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDBottomView.h"

@interface PDBottomView (){
    
}
@property (weak, nonatomic) IBOutlet UILabel *contactMerchantLabel;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation PDBottomView

- (void)awakeFromNib{
    self.lineView.backgroundColor = [UIColor grayColor];
    self.contactMerchantLabel.textColor = [UIColor blackColor];
}




- (CGFloat)cellHeight{
    return 50;
}
@end
