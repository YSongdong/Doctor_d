//
//  HomeHeadTableViewCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ImageClickBlock)(NSString *url);

@interface HomeHeadTableViewCell : UITableViewCell

@property (nonatomic,strong)NSArray *pictures ;

@property (nonatomic,copy)ImageClickBlock block ;


@end
