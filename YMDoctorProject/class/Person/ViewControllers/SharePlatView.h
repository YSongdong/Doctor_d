//
//  SharePlatView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UShareUI/UShareUI.h>

typedef enum : NSUInteger {
    shareUser,
    shareDoctor,
} ShareType;

typedef void(^ShareOperateBlock)(UMSocialPlatformType plat,ShareType type);

@interface SharePlatView : UIView

@property (nonatomic,copy)ShareOperateBlock shareBlock ;

@property (nonatomic,assign)ShareType type ;

@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;



@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *shareBackView;


+ (SharePlatView *)sharePlatViewWithAnimation ;

- (void)showAnimation ;


@end
