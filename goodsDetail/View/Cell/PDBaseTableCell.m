//
//  PDBaseTableCell.m
//  iWedding
//
//  Created by jack steven on 18/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDBaseTableCell.h"

@implementation PDBaseTableCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(NSIndexPath *)indexPath
{
    if(_indexPath == nil) {
        return [NSIndexPath indexPathForRow:-1 inSection:0];
    }
    return _indexPath;
}
@end
