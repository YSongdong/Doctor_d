//
//  SetTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SetTableViewCell.h"


@interface SetTableViewCell ()



@end

@implementation SetTableViewCell


+ (SetTableViewCell *)setCelltableViewWithTableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexPath{
    
    SetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetCellIdentifier"];
                if (indexPath.section == 0){
                cell.type = nextType ;
                    
                    
            }
            if (indexPath.section == 2 || indexPath.section == 3) {
                cell.type = labelType ;
                [cell addLabel];
            }
            if (indexPath.section == 1) {
                cell.type = switchType ;
                [cell addSwitch];
            }
    return cell ;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (_type == labelType) {
      //  [self addLabel];
    }
    else if (_type == switchType) {
        // [self addSwitch];
    }
    else {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    }


}

- (void)updateConstraints{
    
    [super updateConstraints];
   
    
}


- (void)setType:(rightViewType)type {
    
    _type = type ;
    
}


- (void)addLabel {
    
    
    if (_detailLabel) {
        return ;
    }
    _detailLabel = [UILabel new];
    
    [self.contentView addSubview:_detailLabel];
    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO ;
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_detailLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-20]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_detailLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [_detailLabel sizeToFit];

}

- (void)addSwitch {
    
    
    if (_switchIndicator) {
        return ;
    }
    _switchIndicator = [UISwitch new];
    [self.contentView addSubview:_switchIndicator];

    _switchIndicator.translatesAutoresizingMaskIntoConstraints = NO ;
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_switchIndicator attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant: -20]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_switchIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}


@end
