//
//  YICProgressHUD.h
//  OneCar
//
//  Created by renxinwei on 2018/7/7.
//  Copyright © 2018年 51yryc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YICProgressHUDMaskType) {
    YICProgressHUDMaskTypeClear = 0,       // don't allow user interactions
    YICProgressHUDMaskTypeInteraction,     // allow user interactions
};

@interface YICProgressHUD : NSObject

// show only message
+ (void)showInfoWithStatus:(NSString *)status;
+ (void)showInfoWithStatus:(NSString *)status maskType:(YICProgressHUDMaskType)maskType;
+ (void)showInfoWithStatus:(NSString *)status maskType:(YICProgressHUDMaskType)maskType completion:(void (^)(void))completion;
+ (void)showSuccessWithStatus:(NSString *)status;
+ (void)showErrorWithStatus:(NSString*)status;

// show indicator/message
+ (void)show;
+ (void)showWithMaskType:(YICProgressHUDMaskType)maskType;
+ (void)showWithStatus:(NSString *)status;
+ (void)showWithStatus:(NSString *)status maskType:(YICProgressHUDMaskType)maskType;

// dismiss hud
+ (void)dismiss;
+ (void)dismissWithDelay:(NSTimeInterval)delay;
+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(void (^)(void))completion;

+ (BOOL)isVisible;
+ (void)customHUD;

@end
