//
//  FiniteScrollView.m
//  iWedding
//
//  Created by jack steven on 05/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "FiniteScrollView.h"
#import "PDHeadImageView.h"

#define Forward_Slide_String @"滑\n动\n查\n看\n详\n情"
#define Release_Slide_String @"释\n放\n查\n看\n详\n情"
#define Slider_View_Width 50
@implementation FiniteScrollView

- (id)initWithFrame:(CGRect)frame
{
    _sideSpaceWidth = 0;
    return [self initWithFrame:frame pageControl:nil];
}

- (id)initWithFrame:(CGRect)frame pageControl:(UIPageControl*)pageCtrl
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled=YES;
        
        viewSize=CGRectMake(0, 0, frame.size.width, frame.size.height);
        scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        
        if(pageCtrl == nil) {
            pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0,0, 120, 20)];
            pageControl.center = CGPointMake(frame.size.width/2, frame.size.height-10);
            pageControl.currentPage=0;
            [self addSubview:pageControl];
        } else {
            pageControl = pageCtrl;
        }
        

    }
    return self;
}

- (void)setImageList:(NSArray *)images {
    
    imageArray = [NSArray arrayWithArray:images];
    
    pageCount=[imageArray count];
    scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
    
//    for (NSObject *obj in scrollView.subviews) {
//        UIView *itemV = (UIView *)obj;
//        [itemV removeFromSuperview];
//    }
    
    for (int i=0; i<pageCount; i++) {
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(viewSize.size.width*i, 0,viewSize.size.width, viewSize.size.height)];
        

        
        PDHeadImageView *imgView = [[PDHeadImageView alloc] initWithFrame:CGRectMake(0, 0, viewSize.size.width, viewSize.size.height)];
        imgView.tag = i;
        imgView.clipsToBounds = YES;
        PhotoItem *photoItem = imageArray[i];
        imgView.photoItem = photoItem;
        [itemView addSubview:imgView];
//        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
//        [Tap setNumberOfTapsRequired:1];
//        [Tap setNumberOfTouchesRequired:1];
//        imgView.userInteractionEnabled=YES;
//        [imgView addGestureRecognizer:Tap];
        [scrollView addSubview:itemView];
    }
    
    if (!sliderView && _showSlider) {
        sliderView = [[UIView alloc] initWithFrame:CGRectMake(viewSize.size.width * pageCount, 0, Slider_View_Width, self.frame.size.height)];
        
        sliderView.backgroundColor = [UIColor clearColor];
        UILabel *sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 20, self.frame.size.height)];
        sliderLabel.numberOfLines = 0;
        sliderLabel.backgroundColor = [UIColor clearColor];
        sliderLabel.font = [UIFont systemFontOfSize:12];
        sliderLabel.textAlignment = NSTextAlignmentCenter;
        sliderLabel.text = Forward_Slide_String;
        sliderLabel.textColor = [UIColor grayColor];
        [sliderView addSubview:sliderLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inspect_detail"]];
        imageView.center = CGPointMake(10,sliderView.frame.size.height/2);
        imageView.bounds = CGRectMake(0, 0, 12, 12);
        [sliderView addSubview:imageView];
        [scrollView addSubview:sliderView];
    }
    
    
    [scrollView setContentOffset:CGPointMake(0, 0)];
    
    pageControl.numberOfPages=pageCount;
    
    [scrollView setScrollEnabled:images.count>1];
    pageControl.hidden = images.count <= 1;
}

-(int)imageCount
{
    return (int)imageArray.count ;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floorf(scrollView.contentOffset.x/pageWidth);
    currentPageIndex=page;
    pageControl.currentPage=page;
    if (!_showSlider) {
        return;
    }
    if (scrollView.contentOffset.x > pageWidth * (imageArray.count - 1)  && scrollView.contentOffset.x < (pageWidth * (imageArray.count - 1) + 50)) {
        for (NSObject *obj in sliderView.subviews) {
            if ([obj isKindOfClass:[UILabel class]]) {
                UILabel *itemV = (UILabel *)obj;
                itemV.text = Forward_Slide_String;
            }
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *arrowIV = (UIImageView *)obj;
                [UIView animateWithDuration:0.3 animations:^{
                    arrowIV.transform = CGAffineTransformMakeRotation(0);
                } completion:nil];
            }
        }
    }
    if (scrollView.contentOffset.x > (pageWidth * (imageArray.count - 1) + 50)) {
        for (NSObject *obj in sliderView.subviews) {
            if ([obj isKindOfClass:[UILabel class]]) {
                UILabel *itemV = (UILabel *)obj;
                itemV.text = Release_Slide_String;
            }
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *arrowIV = (UIImageView *)obj;
                [UIView animateWithDuration:0.3 animations:^{
                    arrowIV.transform = CGAffineTransformMakeRotation(M_PI);
                } completion:nil];
            }
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!_showSlider) {
        return;
    }
    if (scrollView.contentOffset.x >= (scrollView.frame.size.width * (imageArray.count - 1) + 50)) {
        [self.delegate scrollerViewDidEnd];
    }
}

@end
