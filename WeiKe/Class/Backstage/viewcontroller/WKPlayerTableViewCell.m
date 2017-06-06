//
//  WKPlayerTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/26.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKPlayerTableViewCell.h"

@implementation WKPlayerTableViewCell
//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        [self initCollectionview];
//        NSLog(@"12%%%3");
//    }
//    return self;
//}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //[self initCollectionview];
        NSLog(@"3334");
    }
    return self;
}
-(void)drawRect:(CGRect)rect{

    
 //[self initCollectionview];
    NSLog(@"111");
}
-(void)initCollectionview{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(128, 102);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing =10;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 102) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor redColor];
//    collectionView.delegate = self;
//    collectionView.dataSource = self;
    collectionView.scrollsToTop = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"WKCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Videocell2"];
     [self.collectionView addSubview:collectionView];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
