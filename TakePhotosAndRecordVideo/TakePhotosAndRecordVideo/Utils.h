//
//  Utils.h
//  TakePhotosAndRecordVideo
//
//  Created by zhouwei on 2018/7/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (void)openApplicationSettings;
+ (void)openApplicationSettingsWithUrlStr:(NSString *)urlStr;

+ (void)alertViewpresentViewController:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cancleStr:(NSString *)cancleStr okStr:(NSString *)okStr cancleBlock:(void(^)(void))cancleBlock okBlock:(void(^)(void))okBlock;

@end
