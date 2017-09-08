//
//  HomeFunctionTableViewCell.h
//  YMDoctorProject
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeFunctionTableViewCellDelegate <NSObject>

-(void) selectdCellBtnIndex:(NSInteger)index;

-(void) selectdHospotUrl:(NSString *)url andTitle:(NSString *)title;

@end

@interface HomeFunctionTableViewCell : UITableViewCell

@property (nonatomic,weak) id <HomeFunctionTableViewCellDelegate> delegate;

@end
