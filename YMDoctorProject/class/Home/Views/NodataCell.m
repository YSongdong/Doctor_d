//
//  NodataCell.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NodataCell.h"

@interface NodataCell ()
@property (weak, nonatomic) IBOutlet UIButton *loadBtn;
@property (weak, nonatomic) IBOutlet UILabel *nodataLabel;
@end

@implementation NodataCell



- (void)awakeFromNib {
    [super awakeFromNib];
    [self juadge];
}


- (void)drawRect:(CGRect)rect {
    
    _loadBtn.layer.cornerRadius = 3 ;
    _loadBtn.layer.masksToBounds = YES ;
    _loadBtn.layer.borderColor = _loadBtn.titleLabel.textColor.CGColor ;
    _loadBtn.layer.borderWidth = 0.5 ;
}

- (void)juadge {
    
    self.loadBtn.hidden  = NO ;

    if (![self getStore_id]) {
   [_loadBtn setTitle:@"去认证" forState:UIControlStateNormal];
        _nodataLabel.text = @"您还没有实名认证，先去认证吧";
    }
    else {
        self.loadBtn.hidden = YES ;
        if (self.type == NoSystemOrder) {
//            [_loadBtn setTitle:@"暂无派单" forState:UIControlStateNormal];
//            _nodataLabel.text = @"暂时没有系统派单";

        }
        else if (self.type == DemandOrder) {
//            [_loadBtn setTitle:@"暂无订单" forState:UIControlStateNormal];
            _nodataLabel.text = @"您还没有接标的订单，去需求大厅接单吧";
        }
       
    }
}
- (IBAction)click_loadBtn:(id)sender {
    if (self.block) {
        self.block();
    }
}

@end
