//
//  WKUploadImage.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/17.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol upImageDelegate <NSObject>
-(void)selctedImage:(NSDictionary*)Imgestring;
@optional
-(void)sendImagesource:(NSString *)sourceName;
@end
@interface WKUploadImage : NSObject
@property(strong,nonatomic)NSString *url;
@property(strong,nonatomic)NSDictionary *diction;
@property (weak, nonatomic) id<upImageDelegate >delegate;
+ (WKUploadImage *)shareManager;
- (void)selectUserpicSourceWithViewController:(UIViewController *)viewController;

@end
