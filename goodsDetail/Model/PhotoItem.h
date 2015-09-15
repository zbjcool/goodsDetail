//
//  PDHeadPhoto.h
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoItem : NSObject

@property(nonatomic,strong) NSNumber* photoId;
@property(nonatomic) float width;
@property(nonatomic) float height;
@property(nonatomic,strong) NSString* img;

+(PhotoItem*)parseInfo:(NSDictionary*)info;

// 同步执行，到七牛取图片宽高
-(BOOL)fixItemSize;

@end
