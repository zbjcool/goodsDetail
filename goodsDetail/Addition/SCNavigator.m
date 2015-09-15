//
//  SCNavigator.m
//  iWedding
//
//  Created by v2m on 13-1-9.
//  Copyright (c) 2013年 suncloud. All rights reserved.
//

#import "SCNavigator.h"

static __strong UINavigationController* _sharedNVC = nil;
//static __strong DDMenuController* _ddMenuController = nil;


@implementation SCNavigator

/*
+(DDMenuController*) ddMenuController
{
    return _ddMenuController;
}

+(DDMenuController*)createMenuControllerWithRootVC:(UIViewController*)rootVC
{
    _ddMenuController = [[DDMenuController alloc] initWithRootViewController:rootVC];
    return _ddMenuController;
}*/

#pragma mark shared navigation controller
+(UINavigationController *)sharedNav
{
    return _sharedNVC;
}

+(void)setNVC:(UINavigationController*)vc
{
    _sharedNVC = vc;
}


#pragma mark - push view controller
+ (UIViewController*)pushFromNib:(NSString *)nibName withClass:className
{
    UIViewController* newController = [[NSClassFromString(className) alloc] initWithNibName:nibName bundle:nil];
    [_sharedNVC pushViewController:newController animated:YES];
    return newController;
}


+ (UIViewController*)pushFromNib:(NSString*)className {
    return [self pushFromNib:className withClass:className];
}


+ (UIViewController *)pushFromVC:(NSString *)className {
    UIViewController * newController = [[NSClassFromString(className) alloc] init];
    [_sharedNVC pushViewController:newController animated:YES];
    return newController;
}

+ (UIViewController*)modeFromNib:(NSString *)nibName withClass:className animate:(BOOL)animate
{
    UIViewController* newController = [[NSClassFromString(className) alloc] initWithNibName:nibName bundle:nil];
    
    [[_sharedNVC topViewController] presentViewController:newController animated:animate completion:^{
        
    }];
    return newController;
}

@end
