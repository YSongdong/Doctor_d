//
//  MYTOrderDetailsViewController.h
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTOrderDetailsViewController : UIViewController



@property (strong, nonatomic) NSString *demandIdStr;

@property (nonatomic,strong)  NSString *current_docter_signed; //判断是否和自己签约的单

@property (nonatomic,assign) BOOL isState; //完成状态


@end
