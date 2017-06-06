//
//  WKHeaderCollectionReusableView.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKHeaderCollectionReusableView : UICollectionReusableView
@property(strong,nonatomic)SDCycleScrollView *cycle;
-(void)imageURLStringsGroup:(NSArray*)array;
@end
