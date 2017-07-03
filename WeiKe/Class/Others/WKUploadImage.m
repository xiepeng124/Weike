//
//  WKUploadImage.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/17.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUploadImage.h"
#import <Photos/Photos.h>
@interface WKUploadImage ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UIViewController *viewcontro;
@property (nonatomic,strong)MBProgressHUD *hud;
@end

@implementation WKUploadImage
+ (WKUploadImage *)shareManager
{
    static WKUploadImage *managerInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        managerInstance = [[self alloc] init];
    });
    return managerInstance;
}
- (void)selectUserpicSourceWithViewController:(UIViewController *)viewController{
    
    if (viewController) {
        self.viewcontro = viewController;
        self.hud = [[MBProgressHUD alloc]init];
        self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        self.hud.label.text = @"正在上传";
        self.hud.mode =MBProgressHUDModeAnnularDeterminate;
        [self.viewcontro.view addSubview:self.hud];
    }
    
    UIAlertController *alertCol = [UIAlertController alertControllerWithTitle:@"请选择头像来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])///<检测该设备是否支持拍摄
        {
            //                    [Tools showAlertView:@"sorry, 该设备不支持拍摄"];///<显示提示不支持
            
            return;
        }
        UIImagePickerController* picker = [[UIImagePickerController alloc]init];///<图片选择控制器创建
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;///<设置数据来源为拍照
        picker.allowsEditing = YES;
        picker.delegate = self;///<代理设置

        
        [self.viewcontro presentViewController:picker animated:YES completion:nil];///<推出视图控制器
        
        
    }];
    [alertCol addAction:action];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController* picker = [[UIImagePickerController alloc]init];///<图片选择控制器创建
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;///<设置数据来源为相册
        
        //允许选择照片之后可编辑
        picker.allowsEditing = YES;
        picker.delegate = self;///<代理设置
        
        [viewController presentViewController:picker animated:YES completion:nil];///<推出视图控制器
        
    }];
    [alertCol addAction:action2];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    [alertCol addAction:cancelAction];
    
    [viewController presentViewController:alertCol animated:YES completion:^{
        
        
    }];
    
}
#pragma mark - 相册/相机回调  显示所有的照片，或者拍照选取的照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = nil;
    NSString *imageUrl;
    //获取编辑之后的图片
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSLog(@"imageurl =%@",imageUrl);
    if (!imageUrl) {
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
           NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [self.delegate sendImagesource:fileName];
    }
    else{
    PHAsset *asset;
    PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageUrl] options:nil];
    asset = [result firstObject];
     PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    NSString *imageName = resource.originalFilename;
   // NSLog(@"<<<%@",imageName);
    [self.delegate sendImagesource:imageName];
}
    [self.hud showAnimated:YES];
    
  //  __weak typeof(self) weakself = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        <#code#>
//    })
    [WKHttpTool uploadWithURLString:self.url parameters:self.diction images:image success:^(id responseObject) {
       // NSLog(@"res = %@",responseObject);
        if ([[responseObject objectForKey:@"flag"]intValue]) {
            [self.delegate selctedImage:responseObject];
            self.hud.label.text = @"上传成功";
            [self.hud hideAnimated:YES afterDelay:1];
        }
        else{
            self.hud.label.text = @"上传失败";
            [self.hud hideAnimated:YES afterDelay:1];

        }
        


    } failure:^(NSError *error) {
          NSLog(@"error= %@",error);
        [self.hud hideAnimated:YES];

    } upload:^(NSProgress *progress) {
        
        [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
    }];
//    [WKHttpTool uploadWithURLString:self.url parameters:self.diction images:image success:^(id responseObject) {
//        NSLog(@"resp = %@",responseObject);
//        if ([responseObject objectForKey:@"flag"]) {
//            [self.delegate selctedImage:responseObject];
//            
//        }
//    } failure:^(NSError *error) {
//        NSLog(@"error= %@",error);
//    }];
   [self.viewcontro dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"fractionCompleted"]&&[object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress*)object;
        self.hud.progress = progress.fractionCompleted;
    }
}
-(NSData *)getDataWithString:(NSString *)string{
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
@end
