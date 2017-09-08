//
//  YMGuidePageViewController.h
//  doctor_user
//
//  Created by 黄军 on 17/5/31.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMGuidePageViewController;

@protocol YMGuidePageViewControllerDelegate <NSObject>

-(void)GuidePageController:(YMGuidePageViewController *)GuidePageController IKnow:(BOOL)IKnow;

-(void)GuidePageController:(YMGuidePageViewController *)GuidePageController inputPerson:(BOOL)inputPerson;

@end

@interface YMGuidePageViewController : UIViewController

@property(nonatomic,weak)id<YMGuidePageViewControllerDelegate> delegate;

@end
