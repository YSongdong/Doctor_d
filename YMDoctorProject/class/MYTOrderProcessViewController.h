//
//  MYTOrderProcessViewController.h
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTOrderProcessViewController : BaseViewController


@property (strong, nonatomic) NSString *orderIdStr;
@property (strong, nonatomic) NSString *orderTypeStr;


@property (nonatomic,strong)NSString *userName ;

@property (nonatomic,strong)DemandModel *model ;


- (void)loadDataWithView:(UIView *)view;

@end
