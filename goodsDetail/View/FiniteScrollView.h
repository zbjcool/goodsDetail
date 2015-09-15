//
//  FiniteScrollView.h
//  iWedding
//
//  Created by jack steven on 05/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FiniteScrollViewDelegate <NSObject>
@optional
- (void)scrollerViewDidEnd;

@end

@interface FiniteScrollView : UIView<UIScrollViewDelegate>{
    CGRect viewSize;
    UIScrollView *scrollView;
    NSArray *imageArray;
    UIPageControl *pageControl;
    int currentPageIndex;
    NSUInteger pageCount;
    UIView *sliderView;
}

@property(nonatomic,weak)id<FiniteScrollViewDelegate> delegate;
@property(nonatomic) CGFloat sideSpaceWidth;
@property(nonatomic) BOOL showSlider;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame pageControl:(UIPageControl*)pageCtrl;
- (void)setImageList:(NSArray *)images;

@end
