//
//  DetailDosageTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DetailDosageTableViewCell.h"

#import "MedicationDrugDetailModel.h"

@interface DetailDosageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *showLabel; //显示目前用药label

@property (nonatomic,strong) UIView *backgView; //背景view

@property (nonatomic,assign) CGFloat cellHeight; //cell的高度




@end

@implementation DetailDosageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}




-(void)initBackgViewArr:(NSArray *)arr
{
    for (int i=0; i<arr.count; i++) {
        
        self.backgView = [[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(_showLabel.frame)+(i+1)*10+i*74, SCREEN_WIDTH-24, 74)];
        [self addSubview:self.backgView];
        
        self.backgView.layer.masksToBounds = YES;
        self.backgView.layer.cornerRadius =5;
        
        self.backgView.layer.borderWidth = 1;
        self.backgView.layer.borderColor = [UIColor lineColor].CGColor;
        
        MedicationDrugDetailModel *model = arr[i];
        
        
        //药名字
        UILabel *medicineNameLabel = [[UILabel alloc]init];
        medicineNameLabel.textColor = [UIColor lableText99Color];
        medicineNameLabel.font = [UIFont systemFontOfSize:15];
        medicineNameLabel.text = [model valueForKey:@"drug"];
        medicineNameLabel.tag = 100+i;
        [self.backgView addSubview:medicineNameLabel];
        [medicineNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_backgView.mas_top).offset(0);
            make.left.equalTo(_backgView.mas_left).offset(5);
            make.right.equalTo(_backgView.mas_right).offset(-5);
        }];
        //时间次数
        UILabel *timeCountLabel = [[UILabel alloc]init];
        timeCountLabel.textColor = [UIColor lableText99Color];
        timeCountLabel.font = [UIFont systemFontOfSize:15];
        [self.backgView addSubview:timeCountLabel];
        timeCountLabel.text = [NSString stringWithFormat:@"时间次数:  %@",[model valueForKey:@"second"]];
        timeCountLabel.tag = 200+i;
        [timeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(medicineNameLabel.mas_bottom).offset(0);
            make.left.equalTo(medicineNameLabel.mas_left);
            make.bottom.equalTo(_backgView.mas_bottom).offset(-10);
        }];
        
        //用药天数
        UILabel *mediDayLabel = [[UILabel alloc]init];
        mediDayLabel.textColor = [UIColor lableText99Color];
        mediDayLabel.font = [UIFont systemFontOfSize:15];
        [self.backgView addSubview:mediDayLabel];
        mediDayLabel.text =[NSString stringWithFormat:@"用药天数:  %@天",[model valueForKey:@"day"]];
        mediDayLabel.tag =300+i;
        [mediDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_backgView.mas_right);
            make.left.equalTo(timeCountLabel.mas_right).offset(0);
            make.width.height.equalTo(timeCountLabel);
            make.centerY.equalTo(timeCountLabel.mas_centerY);
        }];
        
        self.cellHeight = CGRectGetMaxY(_showLabel.frame)+(i+1)*10+(i+1)*74+10;
    }
    
    if ([self.delegate respondsToSelector:@selector(dosageCellHeigh:)]) {
        [self.delegate dosageCellHeigh:self.cellHeight];
    }
}

-(void)setModel:(MedicationDurgModel *)model
{
    _model = model;
    
    NSArray *arr = model.detail;
   
    [self initBackgViewArr:arr];
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
