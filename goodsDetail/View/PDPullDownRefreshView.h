//
//  PDPullDownRefreshView.h
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PDPullDownRefreshViewDelegate;

@interface PDPullDownRefreshView : UIView
{
    BOOL isDragging;
    BOOL isLoading;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) UIScrollView *owner;
@property (nonatomic, strong) UILabel *refreshLabel;
@property (nonatomic, strong) UIActivityIndicatorView *refreshSpinner;

- (void)setupWithOwner:(UIScrollView *)owner delegate:(id<PDPullDownRefreshViewDelegate>)delegate;

- (void)startLoading;
- (void)stopLoading;

// 拖动过程中
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end

@protocol PDPullDownRefreshViewDelegate <NSObject>

- (void)pullDownRefreshDidFinish;

@end
