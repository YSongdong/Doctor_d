//
//  SetTableViewCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum : NSUInteger {
        nextType,
    switchType,
    labelType,
} rightViewType;

@interface SetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleName;

@property (nonatomic,assign)rightViewType type ;

@property (nonatomic,strong)UILabel *detailLabel ;
@property (nonatomic,strong)UISwitch *switchIndicator ;

@property (nonatomic,assign)BOOL isClosed ;

+ (SetTableViewCell *)setCelltableViewWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath;

- (void)addLabel ;

- (void)addSwitch  ;

@end
