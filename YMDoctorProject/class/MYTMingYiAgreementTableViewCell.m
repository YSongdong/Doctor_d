//
//  MYTMingYiAgreementTableViewCell1.m
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTMingYiAgreementTableViewCell.h"

@implementation MYTMingYiAgreementTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];

    self.secondTimeBtn.clipsToBounds = YES;
    self.secondTimeBtn.layer.cornerRadius = 5;

//    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
//    [self.webView setScalesPageToFit:YES];
}

-(NSString *)flattenHTML:(NSString *)html {
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    return html;
}

- (void)setDetailsWithDictionary:(NSDictionary *)dic{
    
    self.explainLab.text = [NSString stringWithFormat:@"合同说明: %@",dic[@"explain"]];
    self.tipsLab.text = [NSString stringWithFormat:@"温馨提示: %@",dic[@"tips"]];
    
    self.contentLab.text = [self flattenHTML:dic[@"content"]];
    
//    [self.webView loadHTMLString:dic[@"content"]  baseURL:nil];
    
    self.partB_nameLab.text = dic[@"partB_name"];
    self.partB_timeLab.text = dic[@"partB_time"];
    
   // self.noteLab.text = dic[@"note"];
    self.noteLab.text = @"";
    
//    NSString *doctor_is_signStr = dic[@"doctor_is_sign"];
    NSString *demand_typeStr = dic[@"demand_type"];

//    if ([doctor_is_signStr isEqualToString:@"0"]) {
//        
//        if ([demand_typeStr isEqualToString:@"1"]) {
//            
//            [self.service_end_timeBtn setTitle:@"开始时间: 年 月  日  00:00" forState:UIControlStateNormal];
//            
//        }else{
//            
//            [self.service_start_timeBtn setTitle:@"开始时间: 年 月  日  00:00" forState:UIControlStateNormal];
//            [self.service_end_timeBtn setTitle:@"结束时间: 年 月  日  00:00" forState:UIControlStateNormal];
//        }
//        
//    }else{
        if ([demand_typeStr isEqualToString:@"1"] ||[demand_typeStr isEqualToString:@"0"]) {
            
            self.service_start_timeBtn.hidden = YES;
            
            [self.service_end_timeBtn setTitle:[NSString stringWithFormat:@"开始时间: %@",dic[@"service_end_time"]] forState:UIControlStateNormal];
            
        }else{
            
            [self.service_start_timeBtn setTitle:[NSString stringWithFormat:@"开始时间: %@",dic[@"service_start_time"]] forState:UIControlStateNormal];
            [self.service_end_timeBtn setTitle:[NSString stringWithFormat:@"结束时间: %@",dic[@"service_end_time"]] forState:UIControlStateNormal];
        }
        
        self.other_tipsTF.text = dic[@"other_tips"];        
//    }
    
    self.partA_nameLab.text = dic[@"partA_name"];
    self.partA_timeLab.text = dic[@"partA_time"];

}

-(NSArray * )ZYTXArray{
    
    return @[@"空腹",@"医保卡",@"身份证",@"病历本",@"近期检查报告"];
}



-(NSInteger)getIndexWithStr:(NSString *)str{
    NSArray * arr = [self ZYTXArray];
    
  return   [arr indexOfObject:str];
}

-(NSArray<UIButton * >*)getBtnArray{
    
    
    return @[self.btn1,self.btn2,self.btn3,self.btn4,self.btn5
             ];
    
}

-(void)setTipArr:(NSMutableArray *)tipArr{
    if (tipArr) {
        _tipArr = tipArr;
        if (_tipArr.count==0) {
            return;
        }
        NSArray * btnArr = [self getBtnArray];
        for (NSString * str in tipArr) {
            NSInteger tag = [self getIndexWithStr:str];
            
            UIButton  * btn = btnArr[tag];
            btn.selected = YES;
        }
    }else{
        _tipArr= [NSMutableArray new];
    }
}





- (IBAction)btnClick:(UIButton*)sender {
    sender.selected = ! sender.selected;
    NSArray * strArr = [self ZYTXArray];
    NSString * str = strArr[sender.tag];

    if (self.tipArr) {
        if (sender.selected) {
            
            [self.tipArr addObject:str];
        }else{
            [self.tipArr  removeObject:str];
        }
    }
    
    if (self.selectedTipBlock) {
        self.selectedTipBlock(self.tipArr);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
