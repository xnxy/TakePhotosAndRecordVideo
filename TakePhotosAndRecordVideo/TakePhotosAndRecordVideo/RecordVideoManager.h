//
//  RecordVideoManager.h
//  TakePhotosAndRecordVideo
//
//  Created by zhouwei on 2018/7/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordVideoManager : NSObject

//将mov文件转为MP4文件
+ (void)changeMovToMp4:(NSURL *)mediaURL complete:(void (^)(NSURL *videoUrl,UIImage *movieImage))complete;

//判断相机权限 denied用户拒绝  sucessful 成功
+ (void)judgeCameraPermissionsWithDenied:(void(^)(void))denied successful:(void(^)(UIImagePickerControllerSourceType sourceType))successful;
//判断相册权限
+ (void)judgeAlbumPermissionsWithDenied:(void(^)(void))denied successful:(void(^)(UIImagePickerControllerSourceType sourceType))successful;
//判断麦克风权限
+ (void)determineMicrophonePermissionsWithDenied:(void(^)(void))denied successful:(void(^)(void))successful;

@end
