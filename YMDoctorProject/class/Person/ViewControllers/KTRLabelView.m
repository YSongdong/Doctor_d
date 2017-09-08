//  标签视图
//  KTRLabelView.m
//  kartor3
//
//  Created by huangjun on 16/5/11.
//  Copyright © 2016年 CST. All rights reserved.
//

#import "KTRLabelView.h"

@interface KTRLabelView ()

@property (nonatomic , assign)   CGFloat labelFontSize;//标签字体大小
@property (nonatomic , assign)   CGFloat labelHeight;//标签的高度
@property (nonatomic , assign)   CGFloat labelViewWidth;//当前视图的宽度
@property (nonatomic , assign)   CGFloat buttonTop;//button 上边距
@property (nonatomic , assign)   CGFloat buttonBottom;//button下边距
@property (nonatomic , assign)   BOOL buttonEnable;//button是否可以点击
@property (nonatomic , assign)    CGFloat buttonRight;//button右边距
@property (nonatomic , assign)     CGFloat spacedFontWidth;//字体到标签两边的宽度
@property (nonatomic , strong)      UIColor *hlightedColoc;

@end

@implementation KTRLabelView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initVar];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self _initVar];
}

-(void)_initVar{
    self.borderClock = RGBCOLOR(234, 234, 234);
    self.labelClock = RGBCOLOR(153, 153, 153);
    self.borderalpha= 1.0;
    self.labelFontSize = 14;
    self.borderWidth = 1.0;
    self.labelHeight = 24;
    _buttonEnable = NO;
}

#pragma mark - setter
-(void)setLabelData:(NSArray *)labelData{
    _labelData = labelData;
    //    [self remove];
    labelData = labelData;
    //    CGFloat  inforWidth = 0.0;
    //    NSInteger lineNumber = 0;
    CGFloat inforleft= 0.f;
    NSInteger goodAtNum =  1;
    //    NSInteger lineLeft= 0;
    for (NSDictionary *info in labelData) {
        CGFloat  inforWidth = 0.0;
        NSInteger index = [labelData indexOfObject:info];//拿到对应数据的索引
        KTRLabeViewButton *labelButton = [[KTRLabeViewButton alloc]init];
        labelButton.tag = index;
        labelButton.layer.borderColor= _borderClock.CGColor;
        labelButton.layer.borderWidth = _borderWidth;
        [labelButton setTitleColor:_labelClock forState:UIControlStateNormal];
        labelButton.titleLabel.font = [UIFont systemFontOfSize:_labelFontSize];
        labelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        labelButton.titleLabel.textColor = _labelClock;
        labelButton.backgroundColor = _labelBackClock;
        if (_roundAngle) {
            labelButton.layer.masksToBounds = YES;
            labelButton.layer.cornerRadius = _roundNumber;
        }
        if (_buttonEnable) {
            
            if (info && [info[@"image_n"] isKindOfClass:[UIImage class]]) {
                [labelButton setImage:info[@"image_n"] forState:UIControlStateNormal];
            }
            
            if (info && [info[@"image_p"] isKindOfClass:[UIImage class]]) {
                if(![NSString isEmpty:info[@"image_p"]]){
                    [labelButton setImage:info[@"image_p"] forState:UIControlStateNormal];
                }
            }
            
            if (info && [info[@"labelBackcolor_n"] isKindOfClass:[UIColor class]]) {
                labelButton.NormalColor = info[@"labelBackcolor_n"];
            }
            
            if (info && [info[@"labelBackcolor_p"]isKindOfClass:[UIColor class]]) {
                labelButton.hlightedColor = info[@"labelBackcolor_p"];
            }
            
            if (info &&[info[@"text"] isKindOfClass:[NSString class]]) {
                if (![NSString isEmpty:info[@"text"]]) {
                    [labelButton setTitle:[NSString stringWithFormat:@" %@", info[@"text"]] forState:UIControlStateNormal];
                    [labelButton setTitle:[NSString stringWithFormat:@" %@", info[@"text"]] forState:UIControlStateHighlighted];
                }else{
                    [labelButton setTitle:@"" forState:UIControlStateNormal];
                }
            }else if(info && [info[@"text"] isKindOfClass:[NSNumber class]]){
                
                [labelButton setTitle:[NSString stringWithFormat:@" %@", info[@"text"]] forState:UIControlStateNormal];
                [labelButton setTitle:[NSString stringWithFormat:@" %@", info[@"text"]] forState:UIControlStateHighlighted];
            }
            
            labelButton.userInteractionEnabled = YES;
            [labelButton addTarget:self action:@selector(labelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            
            if (info && [info[@"image_n"] isKindOfClass:[UIImage class]]) {
                [labelButton setImage:info[@"image_n"] forState:UIControlStateNormal];
            }
            
            if (info &&[info[@"text"] isKindOfClass:[NSString class]]) {
                if (![NSString isEmpty:info[@"text"]]) {
                    [labelButton setTitle:[NSString stringWithFormat:@"%@", info[@"text"]] forState:UIControlStateNormal];
                    [labelButton setTitle:[NSString stringWithFormat:@"%@", info[@"text"]] forState:UIControlStateHighlighted];
                }else{
                    [labelButton setTitle:@"" forState:UIControlStateNormal];
                }
            }else if(info && [info[@"text"] isKindOfClass:[NSNumber class]]){
                [labelButton setTitle:[NSString stringWithFormat:@"%@", info[@"text"]] forState:UIControlStateNormal];
                [labelButton setTitle:[NSString stringWithFormat:@"%@", info[@"text"]] forState:UIControlStateHighlighted];
            }
            labelButton.userInteractionEnabled = NO;
        }
        
        CGSize inforSize = [labelButton intrinsicContentSize];
        inforWidth += inforSize.width+(10 + 10*2);
        
        if (inforleft+inforWidth > _labelViewWidth ) {
            inforleft = 0;
            goodAtNum ++;
        }
        [self addSubview:labelButton];
        
        
        
        
        [labelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(inforSize.width+10*2));//文字居中对其后左右的间距为5
            
            make.top.mas_equalTo((goodAtNum-1)*(_labelHeight+5)+5);
            make.height.mas_equalTo(_labelHeight);
            
            make.left.equalTo(@(inforleft));
        }];
        if (_showCancelImage) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = [UIImage imageNamed:@"cancel"];
            [self addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(labelButton.mas_right).offset(3);
                make.top.equalTo(labelButton.mas_top).offset(-3);
                make.height.width.equalTo(@12);
            }];
            
        }
        inforleft = inforleft+inforWidth;
        
        //        lineLeft++;
        //        CGSize inforSize = [labelButton intrinsicContentSize];
        //
        //        NSLog(@"inforSize === %f",inforSize.width);
        //
        //        inforWidth += inforSize.width+(_buttonRight + _spacedFontWidth*2)*(lineLeft -1);
        //        [self addSubview:labelButton];
        //        if (_labelViewWidth<=0) {
        //            _labelViewWidth = self.width;
        //        }
        //        if (inforWidth > _labelViewWidth) {
        //            lineNumber ++;
        //            lineLeft = 1;
        //            inforWidth = inforSize.width;//重新算的原因是因为lineLeft会改变
        //        }
        //        CGFloat inforleft = 0.0;
        //        if (inforWidth != inforSize.width) {
        //            NSInteger i=0;
        //            if (lineLeft>3) {
        //                i =lineLeft-1;
        //            }else{
        //                i= lineLeft-2;
        //            }
        //            inforleft = inforWidth - inforSize.width - (_buttonRight + _spacedFontWidth*2)*(i) ;
        //        }
        //        [labelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.width.equalTo(@(inforSize.width+_spacedFontWidth*2));//文字居中对其后左右的间距为5
        //            make.height.mas_equalTo(_labelHeight);
        //            make.top.equalTo(@(_buttonTop+_labelHeight*lineNumber + lineNumber*10));
        //            make.left.equalTo(@(inforleft));
        //        }];
    }
    
    NSLog(@"goodAtNum === %ld",(long)goodAtNum);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"ooooo===%f",self.height);
    });
    //    NSLog(@"adaafa ====%ld",(long)lineNumber);
}

-(void)setLabelProperty:(NSDictionary *)labelProperty{
    _labelProperty = labelProperty;
    
    NSString *labelFontSize=@"14";
    if (labelProperty && [labelProperty[@"labelFontSize"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"labelFontSize"]]) {
            labelFontSize = labelProperty[@"labelFontSize"];
        }
    }else if(labelProperty && [labelProperty[@"labelFontSize"] isKindOfClass:[NSNumber class ]]){
        labelFontSize = labelProperty[@"labelFontSize"];
    }
    
    NSString *labelHeight=@"29";
    if (labelProperty && [labelProperty[@"labelHeight"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"labelHeight"]]) {
            labelHeight = labelProperty[@"labelHeight"];
        }
    }else if(labelProperty && [labelProperty[@"labelHeight"] isKindOfClass:[NSNumber class ]]){
        labelHeight = labelProperty[@"labelHeight"];
    }
    
    
    NSString *labelViewWidth =@"0";
    if (labelProperty && [labelProperty[@"labelViewWidth"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"labelViewWidth"]]) {
            labelViewWidth = labelProperty[@"labelViewWidth"];
        }
    }else if(labelProperty && [labelProperty[@"labelViewWidth"] isKindOfClass:[NSNumber class ]]){
        labelViewWidth = labelProperty[@"labelViewWidth"];
    }
    
    
    NSString *buttonEnable =@"0";
    if (labelProperty && [labelProperty[@"buttonEnable"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"buttonEnable"]]) {
            buttonEnable = labelProperty[@"buttonEnable"];
        }
    }else if(labelProperty && [labelProperty[@"buttonEnable"] isKindOfClass:[NSNumber class ]]){
        buttonEnable = labelProperty[@"buttonEnable"];
    }
    
    NSString *buttonTop =@"10";
    if (labelProperty && [labelProperty[@"buttonTop"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"buttonTop"]]) {
            buttonTop = labelProperty[@"buttonTop"];
        }
    }else if(labelProperty && [labelProperty[@"buttonTop"] isKindOfClass:[NSNumber class ]]){
        buttonTop = labelProperty[@"buttonTop"];
    }
    
    NSString *buttonBottom =@"10";
    if (labelProperty && [labelProperty[@"buttonBottom"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"buttonBottom"]]) {
            buttonBottom = labelProperty[@"buttonBottom"];
        }
    }else if(labelProperty && [labelProperty[@"buttonBottom"] isKindOfClass:[NSNumber class ]]){
        buttonBottom = labelProperty[@"buttonBottom"];
    }
    
    NSString *buttonRight =@"10";
    if (labelProperty && [labelProperty[@"buttonRight"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"buttonRight"]]) {
            buttonRight = labelProperty[@"buttonRight"];
        }
    }else if(labelProperty && [labelProperty[@"buttonRight"] isKindOfClass:[NSNumber class ]]){
        buttonRight = labelProperty[@"buttonRight"];
    }
    
    NSString *spacedFontWidth =@"5";
    if (labelProperty && [labelProperty[@"spacedFontWidth"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"spacedFontWidth"]]) {
            spacedFontWidth = labelProperty[@"spacedFontWidth"];
        }
    }else if(labelProperty && [labelProperty[@"spacedFontWidth"] isKindOfClass:[NSNumber class ]]){
        spacedFontWidth = labelProperty[@"spacedFontWidth"];
    }
    
    NSString *borderWidth =@"1.0";
    if (labelProperty && [labelProperty[@"borderWidth"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"borderWidth"]]) {
            borderWidth = labelProperty[@"borderWidth"];
        }
    }else if(labelProperty && [labelProperty[@"borderWidth"] isKindOfClass:[NSNumber class ]]){
        borderWidth = labelProperty[@"borderWidth"];
    }
    
    
    if ([buttonEnable integerValue]==0) {
        _buttonEnable = NO;
    }else{
        _buttonEnable = YES;
    }
    _borderWidth = [borderWidth floatValue];
    _labelFontSize = [labelFontSize floatValue];
    _labelHeight = [labelHeight floatValue];
    _labelViewWidth = [labelViewWidth floatValue];
    _buttonTop = [buttonTop floatValue];
    _buttonBottom = [buttonBottom floatValue];
    _buttonRight = [buttonRight floatValue];
    _spacedFontWidth = [spacedFontWidth floatValue];
}

-(void)setLabelClock:(UIColor *)labelClock{
    _labelClock = labelClock;
}

-(void)setBorderClock:(UIColor *)borderClock{
    _borderClock = borderClock;
}

-(void)setLabelBackClock:(UIColor *)labelBackClock
{
    _labelBackClock = labelBackClock;
}

-(void)setBorderalpha:(CGFloat)borderalpha
{
    _borderalpha = borderalpha;
}


-(void)labelButtonClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(labeView:clickNumber:)]) {
        [self.delegate labeView:self clickNumber:btn.tag];
    }
}

#pragma mark - 计算高度
+(CGFloat)labelViewHeight :(NSDictionary *)labelProperty labelData:(NSArray *)labelData{
    
    NSString *labelFontSize=@"14";
    if (labelProperty && [labelProperty[@"labelFontSize"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"labelFontSize"]]) {
            labelFontSize = labelProperty[@"labelFontSize"];
        }
    }else if(labelProperty && [labelProperty[@"labelFontSize"] isKindOfClass:[NSNumber class ]]){
        labelFontSize = labelProperty[@"labelFontSize"];
    }
    
    NSString *labelHeight=@"29";
    if (labelProperty && [labelProperty[@"labelHeight"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"labelHeight"]]) {
            labelHeight = labelProperty[@"labelHeight"];
        }
    }else if(labelProperty && [labelProperty[@"labelHeight"] isKindOfClass:[NSNumber class ]]){
        labelHeight = labelProperty[@"labelHeight"];
    }
    
    NSString *labelViewWidth =@"0";
    if (labelProperty && [labelProperty[@"labelViewWidth"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"labelViewWidth"]]) {
            labelViewWidth = labelProperty[@"labelViewWidth"];
        }
    }else if(labelProperty && [labelProperty[@"labelViewWidth"] isKindOfClass:[NSNumber class ]]){
        labelViewWidth = labelProperty[@"labelViewWidth"];
    }
    
    NSString *buttonEnable =@"0";
    if (labelProperty && [labelProperty[@"buttonEnable"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"buttonEnable"]]) {
            buttonEnable = labelProperty[@"buttonEnable"];
        }
    }else if(labelProperty && [labelProperty[@"buttonEnable"] isKindOfClass:[NSNumber class ]]){
        buttonEnable = labelProperty[@"buttonEnable"];
    }
    
    NSString *buttonTop =@"10";
    if (labelProperty && [labelProperty[@"buttonTop"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"buttonTop"]]) {
            buttonTop = labelProperty[@"buttonTop"];
        }
    }else if(labelProperty && [labelProperty[@"buttonTop"] isKindOfClass:[NSNumber class ]]){
        buttonTop = labelProperty[@"buttonTop"];
    }
    
    NSString *buttonBottom =@"10";
    if (labelProperty && [labelProperty[@"buttonBottom"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"buttonBottom"]]) {
            buttonBottom = labelProperty[@"buttonBottom"];
        }
    }else if(labelProperty && [labelProperty[@"buttonBottom"] isKindOfClass:[NSNumber class ]]){
        buttonBottom = labelProperty[@"buttonBottom"];
    }
    
    NSString *buttonRight =@"10";
    if (labelProperty && [labelProperty[@"buttonRight"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"buttonRight"]]) {
            buttonRight = labelProperty[@"buttonRight"];
        }
    }else if(labelProperty && [labelProperty[@"buttonRight"] isKindOfClass:[NSNumber class ]]){
        buttonRight = labelProperty[@"buttonRight"];
    }
    
    NSString *spacedFontWidth =@"5";
    if (labelProperty && [labelProperty[@"spacedFontWidth"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"spacedFontWidth"]]) {
            spacedFontWidth = labelProperty[@"spacedFontWidth"];
        }
    }else if(labelProperty && [labelProperty[@"spacedFontWidth"] isKindOfClass:[NSNumber class ]]){
        spacedFontWidth = labelProperty[@"spacedFontWidth"];
    }
    
    NSString *borderWidth =@"1.0";
    if (labelProperty && [labelProperty[@"borderWidth"] isKindOfClass:[NSString class]]) {
        if (![NSString isEmpty:labelProperty[@"borderWidth"]]) {
            borderWidth = labelProperty[@"borderWidth"];
        }
    }else if(labelProperty && [labelProperty[@"borderWidth"] isKindOfClass:[NSNumber class ]]){
        borderWidth = labelProperty[@"borderWidth"];
    }
    
    BOOL buttonEnableBool = NO;
    if ([buttonEnable integerValue] !=0) {
        buttonEnableBool = YES;
    }
    //    CGFloat  inforWidth = 0.f;
    //    NSInteger lineNumber = 0;
    //    NSInteger lineLeft= 0;
    CGFloat goodAtHeight = [labelHeight floatValue];
    CGFloat inforleft= 0.f;
    NSInteger goodAtNum =  1;
    
    for (NSDictionary *info in labelData) {
        KTRLabeViewButton *labelButton = [[KTRLabeViewButton alloc]init];
        CGFloat  inforWidth = 0.0;
        labelButton.layer.borderWidth = [borderWidth floatValue];
        
        labelButton.titleLabel.font = [UIFont systemFontOfSize:[labelFontSize integerValue]];
        labelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        if (buttonEnableBool) {
            [labelButton setTitle:[NSString stringWithFormat:@" %@", info[@"text"]?:@""]forState:UIControlStateNormal];
            [labelButton setTitle:[NSString stringWithFormat:@" %@", info[@"text"]?:@""] forState:UIControlStateHighlighted];
            if(info[@"image_n"]){
                [labelButton setImage:info[@"image_n"] forState:UIControlStateNormal];
            }
            if(info[@"image_p"]){
                [labelButton setImage:info[@"image_p"] forState:UIControlStateHighlighted];
            }
        }else{
            [labelButton setTitle:[NSString stringWithFormat:@" %@", info[@"text"]?:@""]forState:UIControlStateNormal];
            if(info[@"image_n"]){
                [labelButton setImage:info[@"image_n"] forState:UIControlStateNormal];
            }
        }
        
        
        CGSize inforSize = [labelButton intrinsicContentSize];
        inforWidth += inforSize.width+(10 + 10*2);
        
        
        if (inforleft+inforWidth > [labelViewWidth floatValue]) {
            inforleft = 0;
            goodAtNum ++;
            
        }
        inforleft = inforleft+inforWidth;
    }
    
    NSLog(@"goodAtNum === %ld",(long)goodAtNum);
    goodAtHeight = goodAtNum *([labelHeight floatValue] +5)+5;
    
    NSLog(@"=======%f",goodAtHeight);
    return goodAtHeight;
    
    
}

@end

@implementation KTRLabeViewButton

-(void)setHighlighted:(BOOL)highlighted{
    
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = _hlightedColor;
    }else{
        self.backgroundColor = _NormalColor;
    }
}


@end
