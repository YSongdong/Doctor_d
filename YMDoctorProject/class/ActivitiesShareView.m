//
//  ActivitiesShareView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/6/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ActivitiesShareView.h"

@implementation ActivitiesShareView

+ (ActivitiesShareView *)sharePlatViewWithAnimation {
    ActivitiesShareView *view =  [[[NSBundle mainBundle]
                             loadNibNamed:@"ActivitiesShareView" owner:self options:nil]firstObject] ;
    view.frame = CGRectMake(0, HEIGHT, WIDTH, 300);
    
    return view ;
}

@end
