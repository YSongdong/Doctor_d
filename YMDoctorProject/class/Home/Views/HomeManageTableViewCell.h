//
//  HomeManageTableViewCell.h
//  YMDoctorProject
//
//  Created by dong on 2017/7/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HomeManageTableViewCellDelegate <NSObject>

-(void) selectdManageBtnIndex:(NSInteger) manageIndex;

@end

@interface HomeManageTableViewCell : UITableViewCell

@property (weak,nonatomic) id <HomeManageTableViewCellDelegate> delegate;

@end
