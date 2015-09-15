//
//  PDHeaderView.m
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDHeaderView.h"
#import "ProductV2.h"
#import "PDHeaderView.h"
#import "PDHeadImageView.h"
#import "FiniteScrollView.h"
#import "PDSubViewController.h"
#import "SCNavigator.h"

@interface PDHeaderView ()<FiniteScrollViewDelegate>{
   
}
@property(nonatomic,weak) IBOutlet UIView *mediaItemView;
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *mediaItemViewHeightLC;
@property(nonatomic,weak) IBOutlet UIView *priceView;
@property(nonatomic,weak) IBOutlet UILabel *actualPriceLabel; // 真实价格Label
@property(nonatomic,weak) IBOutlet UILabel *marketPriceLabel;//市场价Label

@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTailToSuperViewLC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelLeadingToSuperViewLC;


@property(nonatomic,weak) IBOutlet UIView *innerContentView;

@end

@implementation PDHeaderView

- (void)awakeFromNib{
    self.mediaItemViewHeightLC.constant = [UIScreen mainScreen].bounds.size.width;
    self.backgroundColor = [UIColor clearColor];
    self.priceView.hidden = NO;
}

#pragma mark - private method

-(CGFloat)cellHeight
{
    CGFloat workPriceViewHeight = 30;
    CGFloat titleLabelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-30*2, MAXFLOAT) lineBreakMode:self.titleLabel.lineBreakMode].height;
    
    return [UIScreen mainScreen].bounds.size.width + 16 + titleLabelHeight + 16 + workPriceViewHeight+10;
}

#pragma mark - setting getting

- (void)setMarketPriceLabelText:(CGFloat)price{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f", price]];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, attributeString.length)];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, attributeString.length)];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@1
                            range:NSMakeRange(0, [attributeString length])];
    [attributeString addAttribute:NSStrikethroughColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, [attributeString length])];
    self.marketPriceLabel.attributedText = attributeString;
}

- (void)setActualPriceLabelText:(float)price{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f", price]];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:NSMakeRange(0, attributeString.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, attributeString.length)];
    
    _actualPriceLabel.attributedText = attributeString;
}


-(void)setProduct:(ProductV2 *)product
{
    _product = product;
    [self setMarketPriceLabelText:product.marketPrice];
    [self setActualPriceLabelText:product.actualPrice];
    [self setHeaderPhotos];
}


-(void)setHeaderPhotos
{
    if(self.product.headerPhotos.count <= 0)
        return;
    FiniteScrollView *finiteScrollView = [[FiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
    finiteScrollView.showSlider = self.product.detailPhotos.count > 0 ? YES:NO;
    [finiteScrollView setImageList:self.product.headerPhotos];
    finiteScrollView.delegate = self;
    [self.mediaItemView addSubview:finiteScrollView];
}

#pragma mark - FiniteScrollView delegate

- (void)scrollerViewDidEnd{
    PDSubViewController *subViewController = [[PDSubViewController alloc] initWithNibName:@"PDSubViewController" bundle:nil];
    subViewController.dataArray = self.product.detailPhotos;
    subViewController.isFromScrollView = YES;
    subViewController.product = self.product;
    [[SCNavigator sharedNav] pushViewController:subViewController animated:YES];
}

@end
