//
//  AppDelegate.h
//  ubercam
//
//  Created by FangYiXiong on 14-4-25.
//  Copyright (c) 2014年 Fang YiXiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseLoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,PFLogInViewControllerDelegate,NSURLConnectionDataDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSMutableData *profilePictureData;
@end
