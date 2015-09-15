//
//  PDHeadPhoto.m
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PhotoItem.h"

@implementation PhotoItem

+(PhotoItem*)parseInfo:(NSDictionary *)info
{
    PhotoItem *photo = [[PhotoItem alloc] init];
    photo.img = info[@"img"];
    photo.width = [info[@"width"] floatValue];
    photo.height = [info[@"height"] floatValue];
    return photo;
}
@end
