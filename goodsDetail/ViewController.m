//
//  ViewController.m
//  goodsDetail
//
//  Created by jack steven on 15/9/14.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "ViewController.h"
#import "PDMainViewController.h"
#import "SCNavigator.h"
#import "ProductV2.h"
#import "PhotoItem.h"

@interface ViewController ()
@property (nonatomic, strong) ProductV2 *product;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    PhotoItem *photoItem1 = [PhotoItem parseInfo:@{
                                                   @"width":@(100),
                                                   @"height":@(300),
                                                   @"img":@"1.png"
                                                   }];
    PhotoItem *photoItem2 = [PhotoItem parseInfo:@{
                                                   @"width":@(100),
                                                   @"height":@(300),
                                                   @"img":@"2.png"
                                                   }];
    PhotoItem *photoItem3 = [PhotoItem parseInfo:@{
                                                   @"width":@(100),
                                                   @"height":@(300),
                                                   @"img":@"3.png"
                                                   }];
    NSDictionary *infoDic = @{
                              @"desc":@"商品详情：所得税法师打发的法师打发打发似的发射的法师打发士大夫sdfsdfsdfffffffffffffffffffffsdfdsfsdfsdfs暗示法第三方士大夫士大夫士大夫士大夫士大夫士大夫水电费水电费水电费是东方闪电发斯蒂芬斯蒂芬上的发生的发送到发送到发送到发生地方水电费水电费水电费是对方是否单身的方式大放送大放送大放送大放送的方式的发生东方闪电发送到分水电费水电费水电费是方式发生地方水电费水电费水电费是的发斯蒂芬斯蒂芬水电费水电费水电费是的时尚大方 ",
                              @"marketPrice":@(121),
                              @"actualPrice":@(11),
                              @"headerPhotos":@[photoItem1,photoItem2,photoItem3],
                              @"detailPhotos":@[photoItem1,photoItem2,photoItem3]
                              };
    ProductV2 *product = [ProductV2 parseInfo:infoDic];
    self.product = product;
    [SCNavigator setNVC:self.navigationController];
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"商品详情" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    button.bounds = CGRectMake(0, 0, 100, 50);
    [button addTarget:self action:@selector(showGoodsDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)showGoodsDetail:(id)sender{
    PDMainViewController *vc = [[PDMainViewController alloc] initWithNibName:@"PDMainViewController" bundle:nil];
    vc.product = self.product;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
