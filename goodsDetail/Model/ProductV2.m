//
//  Goods.m
//  goodsDetail
//
//  Created by jack steven on 15/9/14.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "ProductV2.h"
#import "PhotoItem.h"

@implementation ProductV2
+(ProductV2*)parseInfo:(NSDictionary *)info
{
    ProductV2 *product = [[ProductV2 alloc] init];
    product.desc = info[@"desc"];
    product.marketPrice = [info[@"marketPrice"] floatValue];
    product.actualPrice = [info[@"actualPrice"] floatValue];
    product.headerPhotos = [NSMutableArray array];
    NSMutableArray *headerArray = info[@"headerPhotos"];
    [headerArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PhotoItem *photoItem = obj;
        [product.headerPhotos addObject:photoItem];
    }];
    product.detailPhotos = [NSMutableArray array];
    NSMutableArray *detailArray = info[@"detailPhotos"];
    [detailArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PhotoItem *photoItem = obj;
        [product.detailPhotos addObject:photoItem];
    }];
    
    return product;
}
@end
