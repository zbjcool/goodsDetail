//
//  PDPullUpRefreshView.h
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PDPullUpRefreshViewDelegate;

@interface PDPullUpRefreshView : UIView
{
    BOOL isDragging;
    BOOL isLoading;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) UIScrollView *owner;
@property (nonatomic, strong) UILabel *refreshLabel;

/**
 *  是否还有更多数据需要加载
 */
@property (nonatomic) BOOL hasMore;

- (void)setupWithOwner:(UIScrollView *)owner delegate:(id<PDPullUpRefreshViewDelegate>)delegate;
- (void)updateOffsetY:(CGFloat)y;

- (void)startLoading;
- (void)stopLoading;

// 拖动过程中
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@protocol PDPullUpRefreshViewDelegate <NSObject>

- (void)pullUpRefreshDidFinish;
@end
