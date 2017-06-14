//
//  WKSearchResultViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBaseViewController.h"

@interface WKSearchResultViewController : WKBaseViewController
@property (nonatomic,strong) UICollectionView *resultCollectionView;
@property (nonatomic,strong) NSString *searchtext;
-(void)initData;
@end
