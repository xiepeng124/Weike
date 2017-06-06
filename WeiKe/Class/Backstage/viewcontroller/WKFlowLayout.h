//
//  WKFlowLayout.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKFlowLayout;

@protocol CustomeCollectionViewLayoutDelegate <NSObject>
/**
 * 确定布局行数的回调
 */
@required
- (NSInteger)numberOfColumnWithCollectionView:(UICollectionView *)collectionView
                         collectionViewLayout:( WKFlowLayout *)collectionViewLayout;

/**
 * 确定cell的Margin
 */
@required
- (CGFloat)marginOfCellWithCollectionView:(UICollectionView *)collectionView
                     collectionViewLayout:( WKFlowLayout *)collectionViewLayout;
/**
 * 确定cell的最小高度
 */
@required
- (CGFloat)minHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:(WKFlowLayout *)collectionViewLayout;

/**
 * 确定cell的最大高度
 */
@required
- (CGFloat)maxHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:( WKFlowLayout *)collectionViewLayout;

@end

@interface WKFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id<CustomeCollectionViewLayoutDelegate> layoutDelegate;
@end
