//
//  WKTeacherScreenViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/3.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBaseViewController.h"
@protocol TeacherScreenDelegate <NSObject>
-(void)Changeframe:(CGFloat)height;
-(void)GetSelectefResultGradeCell:(NSString*)grade coursecell:(NSString *)course;
-(void)GetTeacherGradeId:(NSNumber*)grade courseId:(NSNumber*)course;
@end


@interface WKTeacherScreenViewController : WKBaseViewController
@property(strong,nonatomic)UICollectionView *GradeCollectionView;
@property(strong,nonatomic)UICollectionView *CourseCollectionView;
@property(strong,nonatomic)id<TeacherScreenDelegate>delegate;
@end
