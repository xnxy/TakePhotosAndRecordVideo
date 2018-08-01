//
//  Utils.m
//  TakePhotosAndRecordVideo
//
//  Created by zhouwei on 2018/7/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import "Utils.h"

@implementation Utils

#pragma mark ---
#pragma mark --- 打开应用设置界面 ---
+ (void)openApplicationSettings{
    [self openApplicationSettingsWithUrlStr:UIApplicationOpenSettingsURLString];
}

+ (void)openApplicationSettingsWithUrlStr:(NSString *)urlStr{
    NSURL *privacyUrl = [NSURL URLWithString:urlStr];
    if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
        [[UIApplication sharedApplication] openURL:privacyUrl];
    }
}

#pragma mark -
#pragma mark --- alertView ---
+ (void)alertViewpresentViewController:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancleStr:(NSString *)cancleStr okStr:(NSString *)okStr cancleBlock:(void(^)(void))cancleBlock okBlock:(void(^)(void))okBlock{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title
                                                                     message:message
                                                              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancleStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancleBlock();
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okBlock();
    }];
    
    [alertVC addAction:okAction];
    [alertVC addAction:cancelAction];
    
    [vc presentViewController:alertVC animated:YES completion:nil];
    
}

@end
