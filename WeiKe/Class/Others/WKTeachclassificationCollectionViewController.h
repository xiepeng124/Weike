//
//  WKTeachclassificationCollectionViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKGrade.h"
#import "WKAcedemyHandler.h"
@protocol TeachClassDelegate <NSObject>
-(void)showGradeOrCourse:(NSString*) celltext withModel:(WKGrade*)model;
@end
@interface WKTeachclassificationCollectionViewController : UICollectionViewController
@property (assign,nonatomic)NSInteger gradeNumber;
@property(weak,nonatomic) id<TeachClassDelegate>delegate;
-(void)selectgradeAction:(NSInteger)segmentIndex;
-(void)selectcourseAction:(NSInteger)gradeIds;
@end
