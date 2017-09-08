//
//  HomeTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeTableViewCell.h"

#import "FoodButton.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *needsOrder;
//@property (weak, nonatomic) IBOutlet FoodButton *employerOrder;
@property (weak, nonatomic) IBOutlet UIButton *needHall;
//@property (weak, nonatomic) IBOutlet FoodButton *complicatedOrder;

@property (weak, nonatomic) IBOutlet UIButton *official;

@property (weak, nonatomic) IBOutlet UIButton *honour;

@property (weak, nonatomic) IBOutlet UIButton *casa;

@property (weak, nonatomic) IBOutlet UIButton *homePage;

@end

@implementation HomeTableViewCell

+ (HomeTableViewCell *)cellWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier{
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    [cell.needsOrder setText:@"需求订单"];
//    cell.needsOrder.imageName = @"home_03";
//    cell.employerOrder.text = @"预约订单";
//    cell.employerOrder.imageName = @"home_05";
//    cell.needHall.text = @"需求大厅";
//    cell.needHall.imageName = @"home_09";
//    cell.complicatedOrder.text = @"疑难杂症订单";
//    cell.complicatedOrder.imageName = @"home_07";
    
    return cell ;
}




@end
