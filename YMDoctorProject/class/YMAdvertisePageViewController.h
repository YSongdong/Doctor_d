//
//  YMAdvertisePageViewController.h
//  YMDoctorProject
//
//  Created by 黄军 on 17/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMAdvertisePageViewController;
@protocol YMAdvertisePageViewControllerDelegate <NSObject>

-(void)advertisePageController:(YMAdvertisePageViewController *)advertisePageController;

-(void)advertisePageController:(YMAdvertisePageViewController *)advertisePageController  requrtUrl:(NSString *)reqrutUrl inputadvertising:(BOOL)inputadvertising;

@end

@interface YMAdvertisePageViewController : UIViewController

@property(nonatomic,weak)id<YMAdvertisePageViewControllerDelegate> delegate;




@end
