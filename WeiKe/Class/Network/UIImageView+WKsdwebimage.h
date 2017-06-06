//
//  UIImageView+WKsdwebimage.h
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/6.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DownloadSuccessBlock)(SDImageCacheType CacheType ,UIImage *image);
typedef void (^DownloadFailureBlock) (NSError *error);
typedef void (^DownloadProgressBlock) (CGFloat progress);
@interface UIImageView (WKsdwebimage)
// 加载图片
-(void)downloadImage:(NSString *)url place:(UIImage*)place_image;
//下载图片
-(void)downloadImage:(NSString *)url place:(UIImage *)place_image success:(DownloadSuccessBlock)success failure:(DownloadFailureBlock)failure progress:(DownloadProgressBlock)progress;

@end
