//
//  MYTOfficialDetailsViewController.h
//  MYTDoctor
//
//  Created by kupurui on 2017/5/20.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTOfficialDetailsViewController : UIViewController


@property (nonatomic, strong)NSString *activity_id;

- (void)requestListDataWithView:(UIView *)view;

@end
