//
//  PDPullDownRefreshView.m
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDPullDownRefreshView.h"

#define REFRESH_PULL_UP_STATUS  @"下拉,返回宝贝详情"
#define REFRESH_RELEASED_STATUS @"释放,返回宝贝详情"
// 加载中
#define REFRESH_LOADING_STATUS @""
#define REFRESHER_HEIGHT 34.0f

@interface PDPullDownRefreshView ()

@end

@implementation PDPullDownRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, REFRESHER_HEIGHT)];
        self.refreshLabel.backgroundColor = [UIColor clearColor];
        self.refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
        self.refreshLabel.textAlignment = NSTextAlignmentCenter;
        self.refreshLabel.textColor = [UIColor blackColor];
        self.refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.refreshSpinner.frame = CGRectMake((frame.size.width - 20)/2, (REFRESHER_HEIGHT - 20)/2, 20, 20);
        self.refreshSpinner.hidesWhenStopped = YES;
        self.refreshSpinner.hidden = YES;
        [self addSubview:self.refreshLabel];
        [self addSubview:self.refreshSpinner];
    }
    return self;
}

- (void)setupWithOwner:(UIScrollView *)owner  delegate:(id)delegate {
    self.owner = owner;
    self.delegate = delegate;
    
    [_owner addSubview:self];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (isLoading && scrollView.contentOffset.y > 0) {
        return;
    }
    
    if (isDragging && scrollView.contentOffset.y <= 0 ) {
        
        [self.refreshSpinner stopAnimating];
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        
        if (scrollView.contentOffset.y <= -REFRESHER_HEIGHT) {
            
            // User is scrolling above the header
            self.refreshLabel.text = REFRESH_RELEASED_STATUS;
        }
        
        else {
            
            // User is scrolling somewhere within the header
            self.refreshLabel.text = REFRESH_PULL_UP_STATUS;
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    
    // 上拉刷新
    if(scrollView.contentOffset.y <= -REFRESHER_HEIGHT){
        [self startLoading];
    }
}


- (void)startLoading
{
    if (isLoading) {
        return;
    }
    isLoading = YES;
    
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.refreshLabel.text = REFRESH_LOADING_STATUS;
    [self.refreshSpinner startAnimating];
    [UIView commitAnimations];
    
    // Refresh action!
    if ([self.delegate respondsToSelector:@selector(pullDownRefreshDidFinish)]) {
        [self.delegate performSelector:@selector(pullDownRefreshDidFinish) withObject:nil];
    }
}

- (void)stopLoading
{
    isLoading = NO;
    
    // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1];
    
    [UIView commitAnimations];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    // Reset the header
//    NSLog(@"%f",self.owner.contentSize.height);
    
    self.refreshLabel.text = REFRESH_PULL_UP_STATUS;
    
    [self setFrame:CGRectMake(0, -REFRESHER_HEIGHT, self.frame.size.width, 0)];
    [self.refreshSpinner stopAnimating];
}

@end
