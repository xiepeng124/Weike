//
//  WKHeaderCollectionReusableView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHeaderCollectionReusableView.h"
@interface WKHeaderCollectionReusableView ()<SDCycleScrollViewDelegate>
@end

@implementation WKHeaderCollectionReusableView
-(void)awakeFromNib{
    [super awakeFromNib];
    
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        //UIImage *imag=[UIImage imageNamed:@"placeholer"];
        //NSArray *arr=[NSArray arrayWithObjects:imag,imag,imag, nil];
       //self.cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.4) imageNamesGroup:arr];
        self.cycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.4) delegate:self placeholderImage:[UIImage imageNamed:@"placeholer"]];
        //cycle2.backgroundColor=[UIColor greenColor];
        //cycleScroll.imageURLStringsGroup=nil;
        self.cycle.autoScrollTimeInterval=2;
        
        [self addSubview:self.cycle];
    }
    NSLog(@"header is here");
    //
    
    return self;
}
-(void)drawRect:(CGRect)rect{
   
}
-(void)imageURLStringsGroup:(NSArray*)array{
    self.cycle.imageURLStringsGroup = array;
    //NSLog(@"array=%@",array);
}

@end
