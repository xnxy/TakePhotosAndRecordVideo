//
//  YICProgressHUD.m
//  OneCar
//
//  Created by renxinwei on 2018/7/7.
//  Copyright © 2018年 51yryc. All rights reserved.
//

#import "YICProgressHUD.h"
#import <SVProgressHUD/SVProgressHUD.h>

NSTimeInterval const HUDMinDismissTimeInterval = 1.0;
NSTimeInterval const HUDMaxDismissTimeInterval = 5.0;

@implementation YICProgressHUD

+ (void)showInfoWithStatus:(NSString *)status {
    [self showInfoWithStatus:status maskType:YICProgressHUDMaskTypeClear];
}

+ (void)showInfoWithStatus:(NSString *)status maskType:(YICProgressHUDMaskType)maskType {
    [self showInfoWithStatus:status maskType:maskType completion:nil];
}

+ (void)showInfoWithStatus:(NSString *)status maskType:(YICProgressHUDMaskType)maskType completion:(void (^)(void))completion {
    [self resetHUDBehavior];
    SVProgressHUDMaskType type = maskType == YICProgressHUDMaskTypeClear ? SVProgressHUDMaskTypeClear : SVProgressHUDMaskTypeNone;
    [SVProgressHUD setDefaultMaskType:type];
    [SVProgressHUD showInfoWithStatus:status];
    NSTimeInterval delay = [self displayDurationForString:status];
    [SVProgressHUD dismissWithDelay:delay completion:completion];
}

+ (void)showSuccessWithStatus:(NSString *)status {
    [self resetHUDBehavior];
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)showErrorWithStatus:(NSString*)status {
    [self resetHUDBehavior];
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)show {
    [self showWithMaskType:YICProgressHUDMaskTypeClear];
}

+ (void)showWithMaskType:(YICProgressHUDMaskType)maskType {
    [self resetHUDBehavior];
    SVProgressHUDMaskType type = maskType == YICProgressHUDMaskTypeClear ? SVProgressHUDMaskTypeClear : SVProgressHUDMaskTypeNone;
    [SVProgressHUD setDefaultMaskType:type];
    [SVProgressHUD show];
}

+ (void)showWithStatus:(NSString *)status {
    [self showWithStatus:status maskType:YICProgressHUDMaskTypeClear];
}

+ (void)showWithStatus:(NSString *)status maskType:(YICProgressHUDMaskType)maskType {
    [self resetHUDBehavior];
    SVProgressHUDMaskType type = maskType == YICProgressHUDMaskTypeClear ? SVProgressHUDMaskTypeClear : SVProgressHUDMaskTypeNone;
    [SVProgressHUD setDefaultMaskType:type];
    [SVProgressHUD showWithStatus:status];
}

+ (void)dismiss {
    [self dismissWithDelay:0];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay {
    [self dismissWithDelay:delay completion:nil];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(void (^)(void))completion {
    [SVProgressHUD dismissWithDelay:delay completion:completion];
}

+ (BOOL)isVisible {
    return [SVProgressHUD isVisible];
}

+ (void)customHUD {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:HUDMinDismissTimeInterval];
    [SVProgressHUD setMaximumDismissTimeInterval:HUDMaxDismissTimeInterval];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [SVProgressHUD setInfoImage:nil];
#pragma clang diagnostic pop
}

+ (void)resetHUDBehavior {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}

+ (NSTimeInterval)displayDurationForString:(NSString *)string {
    CGFloat minimum = MAX((CGFloat)string.length * 0.06 + 0.5, HUDMinDismissTimeInterval);
    return MIN(minimum, HUDMaxDismissTimeInterval);
}

@end

