//
//  Goods.h
//  goodsDetail
//
//  Created by jack steven steven on 15/9/14.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductV2 : NSObject
@property (nonatomic,assign) float marketPrice;
@property (nonatomic,assign) float actualPrice;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSMutableArray *headerPhotos;
@property (nonatomic, strong) NSMutableArray *detailPhotos;

+(ProductV2*)parseInfo:(NSDictionary *)info;
@end
