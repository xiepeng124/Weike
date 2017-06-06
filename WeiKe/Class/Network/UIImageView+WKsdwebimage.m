//
//  UIImageView+WKsdwebimage.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/6.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "UIImageView+WKsdwebimage.h"

@implementation UIImageView (WKsdwebimage)
-(void)downloadImage:(NSString *)url place:(UIImage*)place_image{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place_image options:SDWebImageLowPriority|SDWebImageRetryFailed];
}
-(void)downloadImage:(NSString *)url place:(UIImage *)place_image success:(DownloadSuccessBlock)success failure:(DownloadFailureBlock)failure progress:(DownloadProgressBlock)progress{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place_image options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        progress(receivedSize/expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            failure(error);
        }
        else{
            success(cacheType,image);
        }
    }];
}
@end
