//
//  SCNavigator.h
//  iWedding
//
//  Created by v2m on 13-1-9.
//  Copyright (c) 2013年 suncloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SCNavigator : NSObject

+(UINavigationController *)sharedNav;
+(void)setNVC:(UINavigationController*)vc;

+ (UIViewController*)pushFromNib:(NSString *)nibName withClass:className;
+ (UIViewController*)pushFromNib:(NSString*)className;
+ (UIViewController *)pushFromVC:(NSString *)className;

+ (UIViewController*)modeFromNib:(NSString *)nibName withClass:className animate:(BOOL)animate;

@end
