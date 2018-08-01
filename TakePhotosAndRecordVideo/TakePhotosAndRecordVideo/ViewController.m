//
//  ViewController.m
//  TakePhotosAndRecordVideo
//
//  Created by zhouwei on 2018/7/30.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/UTCoreTypes.h>

#import "RecordVideoManager.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong, nonatomic) UIImagePickerController * picker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.backgroundColor = [UIColor blueColor];
    [cameraBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [cameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    photoBtn.backgroundColor = [UIColor orangeColor];
    [photoBtn setTitle:@"选择照片" forState:UIControlStateNormal];
    [photoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    videoBtn.backgroundColor = [UIColor grayColor];
    [videoBtn setTitle:@"录像" forState:UIControlStateNormal];
    [videoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:cameraBtn];
    [self.view addSubview:photoBtn];
    [self.view addSubview:videoBtn];
    
    //layout
    [photoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    [cameraBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.equalTo(photoBtn);
        make.bottom.equalTo(photoBtn.top);
    }];
    
    [videoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.centerX.equalTo(photoBtn);
        make.top.equalTo(photoBtn.bottom);
    }];
    
    WeakObj(self)
    [photoBtn bk_whenTapped:^{
        StrongObj(selfWeak)
        [selfWeakStrong openPhotoLibrary];
    }];
    
    [cameraBtn bk_whenTapped:^{
        StrongObj(selfWeak)
        [selfWeakStrong openCamera];
    }];
    
    [videoBtn bk_whenTapped:^{
        StrongObj(selfWeak)
        [selfWeakStrong recordVideo];
    }];
    
}

#pragma ---
#pragma --- 录像 ---
- (void)recordVideo{
    WeakObj(self);
    [RecordVideoManager determineMicrophonePermissionsWithDenied:^
    {
        [Utils alertViewpresentViewController:self
                                        title:@"提示"
                                      message:@"麦克风授权未开启\n请在系统设置中开启麦克风权限"
                                    cancleStr:@"暂不"
                                        okStr:@"去设置"
                                  cancleBlock:^{
                                      
                                  } okBlock:^{
                                      [Utils openApplicationSettings];
                                  }];
    } successful:^{
        [RecordVideoManager judgeCameraPermissionsWithDenied:^{
            [Utils alertViewpresentViewController:self
                                            title:@"提示"
                                          message:@"相机授权未开启\n请在系统设置中开启相机权限"
                                        cancleStr:@"暂不"
                                            okStr:@"去设置"
                                      cancleBlock:^{
                                          
                                      } okBlock:^{
                                          [Utils openApplicationSettings];
                                      }];
        } successful:^(UIImagePickerControllerSourceType sourceType) {
            StrongObj(selfWeak)
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = selfWeakStrong;
            picker.sourceType = sourceType;
            // 设置图像选取控制器的类型为动态图像
            picker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
            // 设置摄像图像品质
            picker.videoQuality = UIImagePickerControllerQualityTypeMedium;
            // 设置最长摄像时间
            picker.videoMaximumDuration = 30;
            // 允许用户进行编辑
            picker.allowsEditing = YES;
            [selfWeakStrong presentViewController:picker animated:YES completion:nil];
            
        }];
    }];
}

#pragma mark ---
#pragma mark --- 打开相机 ---
- (void)openCamera{
    //获取摄像设备
    WeakObj(self)
    [RecordVideoManager judgeCameraPermissionsWithDenied:^{
        [Utils alertViewpresentViewController:self
                                        title:@"提示"
                                      message:@"相机授权未开启\n请在系统设置中开启相机权限"
                                    cancleStr:@"暂不"
                                        okStr:@"去设置"
                                  cancleBlock:^{
                                      
                                  } okBlock:^{
                                      [Utils openApplicationSettings];
                                  }];
    } successful:^(UIImagePickerControllerSourceType sourceType) {
        StrongObj(selfWeak)
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = selfWeakStrong;
        picker.sourceType = sourceType;
        [selfWeakStrong presentViewController:picker animated:YES completion:nil];
    }];
}

#pragma mark ---
#pragma mark --- 打开相册 ---
- (void)openPhotoLibrary{
    // 判断授权状态
    WeakObj(self)
    [RecordVideoManager judgeAlbumPermissionsWithDenied:^{
        [Utils alertViewpresentViewController:self
                                        title:@"提示"
                                      message:@"相册授权未开启\n请在系统设置中开启相册权限"
                                    cancleStr:@"暂不"
                                        okStr:@"去设置"
                                  cancleBlock:^
         {
             
         } okBlock:^{
             [Utils openApplicationSettings];
         }];
    } successful:^(UIImagePickerControllerSourceType sourceType) {
        StrongObj(selfWeak)
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = selfWeakStrong;
        picker.sourceType = sourceType;
        [selfWeakStrong presentViewController:picker animated:YES completion:nil];
    }];
}


#pragma mark- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    WeakObj(self)
    [self dismissViewControllerAnimated:YES completion:^{
        StrongObj(selfWeak)
        //获取媒体类型
        NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) { //图片
            UIImage * originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            NSLog(@"-----originalImage:%@-----",originalImage);
        }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){ //视频
            // 获取视频文件的url
            NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
            NSLog(@"-----videoUrl:%@-----",videoUrl);
            AVURLAsset *urlAsset = [[AVURLAsset alloc] initWithURL:videoUrl options:nil];
            double duration = urlAsset.duration.value / urlAsset.duration.timescale;
            if (duration > 5) { //判断时间是否大于5秒
                [RecordVideoManager changeMovToMp4:videoUrl complete:^(NSURL *videoUrl, UIImage *movieImage) {
                    NSLog(@"----mp4:%@-----movieImage:%@-----",videoUrl,movieImage);
                }];
            } else {
                [YICProgressHUD showInfoWithStatus:@"视频太短，请重新录制"];
                [selfWeakStrong presentViewController:picker animated:YES completion:nil];
            }
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
