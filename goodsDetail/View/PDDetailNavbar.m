//
//  PDDetailNavbar.m
//  iWedding
//
//  Created by jack steven on 05/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDDetailNavbar.h"
#import "SCNavigator.h"

@interface PDDetailNavbar()
@property(nonatomic,weak) IBOutlet NSLayoutConstraint *barHeightLC;
@property(nonatomic,weak) IBOutlet UIButton *backButton;
@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UIView *backgroundView;
@property (weak, nonatomic)IBOutlet UIImageView *imageViewBg;
@property(nonatomic) UIView *backImageView;
@property(nonatomic) UIView *shareImageView;
@property(nonatomic) UIView *collectImageView;
@property(nonatomic) UIView *shoppingCartImageView;
@end

@implementation PDDetailNavbar

-(void)awakeFromNib
{
    self.backgroundView.alpha = 0;
    [self initBackButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectNotify:) name:@"kCollectionNotification" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)collectNotify:(NSNotification *)nofity{
    [self updateUI];
}

-(void)initBackButton
{
    UIImage *backImageMask = [UIImage imageNamed:@"thinBackIcon_red"];
    
    _backImageView = [[UIView alloc] initWithFrame:CGRectMake((_backButton.bounds.size.width - backImageMask.size.width)/2, (_backButton.bounds.size.height - backImageMask.size.height)/2, backImageMask.size.width, backImageMask.size.height)];
    _backImageView.userInteractionEnabled = NO;
    [_backButton addSubview:_backImageView];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contents = (__bridge id)(backImageMask.CGImage);
    maskLayer.frame = CGRectMake(0, 0, backImageMask.size.width, backImageMask.size.height);
    _backImageView.layer.mask = maskLayer;
    _backImageView.backgroundColor = [UIColor whiteColor];
}


- (void)setProduct:(ProductV2 *)product{
    _product = product;
    [self updateUI];
}


-(void)updateCollectedUI
{
    UIImage *collectImageMask = nil;
//    if(_product.isCollect) {
////        _product.collectUsers.num ++;
//        collectImageMask = [UIImage imageNamed:@"work_collect_yellow"];
//        _collectButton.selected = YES;
//        CALayer *maskLayer = [CALayer layer];
//        maskLayer.contents = (__bridge id)(collectImageMask.CGImage);
//        maskLayer.frame = CGRectMake(0, 0, collectImageMask.size.width, collectImageMask.size.height);
//        _collectImageView.layer.mask = maskLayer;
//        _collectImageView.backgroundColor = kColorYellow1;
//        
//    } else {
////        _product.collectUsers.num --;
//        collectImageMask = [UIImage imageNamed:@"work_collect_white"];
//        _collectButton.selected = NO;
//        CALayer *maskLayer = [CALayer layer];
//        maskLayer.contents = (__bridge id)(collectImageMask.CGImage);
//        maskLayer.frame = CGRectMake(0, 0, collectImageMask.size.width, collectImageMask.size.height);
//        _collectImageView.layer.mask = maskLayer;
//        
//        CGFloat colorTransitionProgress = self.backgroundView.alpha;
//        CGFloat red, green, blue;
//        [kColorRed1 getRed:&red green:&green blue:&blue alpha:nil];
//        red = 1 + (red-1)*colorTransitionProgress;
//        green = 1 + (green-1)*colorTransitionProgress;
//        blue = 1 + (blue-1)*colorTransitionProgress;
//        _collectImageView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
//    }
    
}

- (void)updateUI{
    UIImage *collectImageMask = nil;
//    if(_product.isCollect) {
//        collectImageMask = [UIImage imageNamed:@"work_collect_yellow"];
//        _collectButton.selected = YES;
//        CALayer *maskLayer = [CALayer layer];
//        maskLayer.contents = (__bridge id)(collectImageMask.CGImage);
//        maskLayer.frame = CGRectMake(0, 0, collectImageMask.size.width, collectImageMask.size.height);
//        _collectImageView.layer.mask = maskLayer;
//        _collectImageView.backgroundColor = kColorYellow1;
//        
//    } else {
//        collectImageMask = [UIImage imageNamed:@"work_collect_white"];
//        _collectButton.selected = NO;
//        CALayer *maskLayer = [CALayer layer];
//        maskLayer.contents = (__bridge id)(collectImageMask.CGImage);
//        maskLayer.frame = CGRectMake(0, 0, collectImageMask.size.width, collectImageMask.size.height);
//        _collectImageView.layer.mask = maskLayer;
//        
//        CGFloat colorTransitionProgress = self.backgroundView.alpha;
//        CGFloat red, green, blue;
//        [kColorRed1 getRed:&red green:&green blue:&blue alpha:nil];
//        red = 1 + (red-1)*colorTransitionProgress;
//        green = 1 + (green-1)*colorTransitionProgress;
//        blue = 1 + (blue-1)*colorTransitionProgress;
//        _collectImageView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
//    }
}

-(IBAction)back:(id)sender
{
    [[SCNavigator sharedNav] popViewControllerAnimated:YES];
}

-(void)setColorTransitionProgress:(CGFloat)colorTransitionProgress
{
    if(colorTransitionProgress == 1)
    {
        _imageViewBg.hidden = YES;
        if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
            && [[UIApplication sharedApplication] respondsToSelector:NSSelectorFromString(@"setStatusBarStyle:")]) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
    }else{
        _imageViewBg.hidden = NO;
        if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
            && [[UIApplication sharedApplication] respondsToSelector:NSSelectorFromString(@"setStatusBarStyle:")]) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }
    }
    self.backgroundView.alpha = colorTransitionProgress;
    
//    CGFloat red, green, blue;
//    [kColorRed1 getRed:&red green:&green blue:&blue alpha:nil];
//    red = 1 + (red-1)*colorTransitionProgress;
//    green = 1 + (green-1)*colorTransitionProgress;
//    blue = 1 + (blue-1)*colorTransitionProgress;
//    self.backImageView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
//    self.shareImageView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
//    self.shoppingCartImageView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
//    self.titleLabel.alpha = colorTransitionProgress;
//    if (_collectButton.selected) {
//        self.collectImageView.backgroundColor = kColorYellow1;
//    }else{
//        self.collectImageView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
//    }
}


@end
