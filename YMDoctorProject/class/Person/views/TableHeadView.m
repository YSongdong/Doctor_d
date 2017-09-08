//
//  TableHeadView.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TableHeadView.h"
#import "PersonDescriptViewController.h"

@interface TableHeadView ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIView *certificationView;//认证View
@property (weak, nonatomic) IBOutlet UIImageView *headBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *aptitudeLab;

@property (weak, nonatomic) IBOutlet UILabel *occupationLab;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;

@property (weak, nonatomic) IBOutlet UILabel *successDealLabel;//成交量
@property (weak, nonatomic) IBOutlet UILabel *scanLabel;//浏览
@property (weak, nonatomic) IBOutlet UILabel *valuatePercentLabel; //好评率
@property (weak, nonatomic) IBOutlet UILabel *authenLabel;
//@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;

@property (weak, nonatomic) IBOutlet UILabel *redPoint;

@property (weak, nonatomic) IBOutlet UILabel *improveLab;



@end

@implementation TableHeadView

+ (instancetype)tableHeadView {
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"TableHeadView"
        owner:self options:nil];
    
    return [array firstObject];
}

-(void)setStyleByIndex:(NSInteger )index{
    
    _currentIndex = index;
    
    UIColor *blueColor  = [UIColor colorWithRed:53.0/255.0 green:120.0/255.0 blue:184.0/255.0 alpha:1];
    
    if (index==0) {
        
    }else if (index==1){
        self.img_2.image = [UIImage imageNamed:@"手机验证"];
        self.line_2.backgroundColor = blueColor;
        
        self.img_3.image =[UIImage imageNamed:@"实名认证"];
        self.label_3.textColor = blueColor;
        
    }else if (index==2){
        self.img_2.image = [UIImage imageNamed:@"手机验证"];
        self.line_2.backgroundColor = blueColor;
        
        self.img_3.image =[UIImage imageNamed:@"实名认证"];
        self.label_3.textColor = blueColor;
//        -----
        self.img_3.image = [UIImage imageNamed:@"手机验证"];
        self.line_3.backgroundColor = blueColor;
        
        self.img_4.image =[UIImage imageNamed:@"实名认证"];
        self.label_4.textColor = blueColor;
        
    }else if (index==3){
        self.img_2.image = [UIImage imageNamed:@"手机验证"];
        self.line_2.backgroundColor = blueColor;
        
        self.img_3.image =[UIImage imageNamed:@"实名认证"];
        self.label_3.textColor = blueColor;
        //        -----
        self.img_3.image = [UIImage imageNamed:@"手机验证"];
        self.line_3.backgroundColor = blueColor;
        
        self.img_4.image =[UIImage imageNamed:@"实名认证"];
        self.label_4.textColor = blueColor;
        //        ---*********-
        self.img_4.image =[UIImage imageNamed:@"手机验证"];
        
        self.improveLab.text = @"您可使用鸣医接取订单啦!";
        self.improveBtn.hidden = YES;
        _certificationView.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didclickUploadHead)];
    _headBtn.userInteractionEnabled = YES ;
    [_headBtn addGestureRecognizer:gesture];
}

- (void)drawRect:(CGRect)rect {
    
    _headBtn.layer.cornerRadius = _headBtn.width/2;
    _headBtn.layer.masksToBounds = YES ;
    _authenLabel.layer.cornerRadius = 3 ;
    _authenLabel.layer.masksToBounds = YES ;
    _redPoint.layer.cornerRadius = 4 ;
    _redPoint.layer.masksToBounds = YES ;
    _redPoint.hidden = YES ;
}

- (void)setPersonValue:(id)person {
    
    if ([person isKindOfClass:[NSDictionary class]]) {
        if (person[@"store_id"] &&
            ![person[@"store_id"]isEqual:[NSNull null]]
            ) {
            if (![person[@"store_id"]isEqualToString:@""]) {
                [self setStore_id:person[@"store_id"]];
                self.authenLabel.text = @" 已认证 ";
            }
            else {
                self.authenLabel.text = @" 未认证 ";
                [self removeStore_id];
            }
        }
        else {
            [self removeStore_id];
            self.authenLabel.text = @"未认证";
        }
        if ([person[@"message_count"]isEqualToString:@"0"]) {
            
            self.redPoint.hidden = YES ;
        }else{
            
            self.redPoint.hidden =NO ;
        }
        if (![person[@"member_avatar"] isEqual:[NSNull null]]){
            
            [_headBtn sd_setImageWithURL:[NSURL URLWithString:person[@"member_avatar"] ] placeholderImage:[UIImage imageNamed:@"default_head"]];
            
        }else {
            
            [_headBtn sd_setImageWithURL:[NSURL URLWithString:[self getAvatar] ] placeholderImage:[UIImage imageNamed:@"default_head"]];
        }
    }
    
    if (person[@"member_names"] &&
        ![person[@"member_names"] isEqual:[NSNull null]]) {
        _nameLabel.text = person[@"member_names"];
    }
    else {
        _nameLabel.text = [self getUserName];
    }
    
    if (person[@"grade_id"]) {
        _levelLabel.text = [NSString stringWithFormat:@"LV%@",person[@"grade_id"]];
    }
    else{
        _levelLabel.text = @"LV1";
    }
    _aptitudeLab.text = person[@"member_aptitude"];
    _hospitalLabel.text = [NSString stringWithFormat:@"%@   %@",person[@"member_bm"],person[@"member_ks"]];
    
    _occupationLab.text = person[@"member_occupation"];
    
    
    //stringByAppendingFormat:@"    %@",person[@"member_aptitude"]
    
    if (![person[@"avg_score"]isEqual:[NSNull null]]) {
         _valuatePercentLabel.text = [NSString stringWithFormat:@"好评率:%@",person[@"avg_score"]] ;
    }else {
        _valuatePercentLabel.text = @"好评率: %0";
    }
    NSString *str = @"0";
    //加判断
    if (person[@"store_sales"]) {
        str = person[@"store_sales"];
    }
    _successDealLabel.text =[NSString stringWithFormat:@"总成交量:%@",str];
    NSString *scan = @"0";
    if (person[@"stoer_browse"]
        && ![person[@"stoer_browse"] isEqualToString:@""]) {
        
        scan = person[@"stoer_browse"] ;
    }
    _scanLabel.text =[NSString stringWithFormat:@"浏览量:%@",scan];
}

- (void)didclickUploadHead {
    if (self.block) {
        self.block(_headBtn);
    }
}

- (IBAction)messageBtnClicked:(id)sender {
    if (self.messageBlock) {
            self.messageBlock(nil) ;
        }
}


@end
