//
//  YMAddAccountTableViewCell.h
//  doctor_user
//   公用CELL
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMAddAccountTableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL lastOne;//最后一个Cell

@property(nonatomic,assign) BOOL lineInterval;//间隔

@property(nonatomic,copy)NSString *titleName;


/***
 *注意：帐户选择不传
 **/
@property(nonatomic,copy)NSString *subTitlename;//不传值的时是隐藏状态

@end
