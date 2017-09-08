//
//  YMLabelButtonView.m
//  doctor_user
//
//  Created by 黄军 on 2017/6/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMLabelButtonView.h"

#import "UIButton+LZCategory.h"

@interface YMLabelButtonView()

//@property(nonatomic,strong)NSMutableArray *clckTageArry;

@end


@implementation YMLabelButtonView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

-(void)initVar{

}

-(void)initView{
    
}


-(void)setSelectTagArry:(NSMutableArray *)selectTagArry{
    _selectTagArry = selectTagArry;
}

-(void)setLabelArry:(NSArray *)labelArry{
    _labelArry = labelArry;
    NSInteger lineNumber = 0;
    NSInteger lineLeft= 5;
    for (NSInteger i=0; i<labelArry.count; i++) {
        UIButton *labelButton = [[UIButton alloc]init];
        labelButton.titleLabel.font = [UIFont systemFontOfSize:12];
        labelButton.tag = i;
        if (_type != LabelShowViewType) {
            [labelButton addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
            labelButton.userInteractionEnabled = YES;
        }else{
            labelButton.userInteractionEnabled = NO;
        }
        
        labelButton.layer.masksToBounds = YES;
//        labelButton.layer.cornerRadius = 5.f;
        labelButton.layer.borderWidth = 1.f;
        
        
        [labelButton setTitle:labelArry[i] forState:UIControlStateNormal];
        [labelButton setTitleColor:RGBCOLOR(130, 130, 130) forState:UIControlStateNormal];
        [self addSubview:labelButton];
        labelButton.layer.borderColor = RGBCOLOR(229, 229, 229).CGColor;
        for (NSString *str in _selectTagArry) {
            if ([str integerValue] == i) {
                labelButton.layer.borderColor = RGBCOLOR(145, 184, 235).CGColor;
                [labelButton setTitleColor:RGBCOLOR(145, 184, 235) forState:UIControlStateNormal];
            }
        }
        
        
        CGFloat buttonWidth = labelButton.intrinsicContentSize.width + 20;
        
        if (lineLeft+buttonWidth>self.width) {
            lineNumber ++;
            lineLeft = 5;
        }
        
        [labelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lineLeft);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(buttonWidth);
            make.top.mas_equalTo(lineNumber *30+10);
        }];
        
        lineLeft+=buttonWidth+5;
    
        if (i==labelArry.count-1&&_type != LabelShowViewType) {
            UIButton *replaceButton = [[UIButton alloc]init];
            replaceButton.titleLabel.font = labelButton.titleLabel.font;
            replaceButton.backgroundColor = [UIColor clearColor];
            [replaceButton setTitleColor:RGBCOLOR(130, 130, 130) forState:UIControlStateNormal];
            [replaceButton setTitle:@"换一换" forState:UIControlStateNormal];
            [replaceButton addTarget:self action:@selector(replaceClick:) forControlEvents:UIControlEventTouchUpInside];
            [replaceButton setImage:[UIImage imageNamed:@"change_label"] forState:UIControlStateNormal];
            dispatch_async(dispatch_get_main_queue(), ^{
                [replaceButton LZSetbuttonType:LZCategoryTypeLeft];
            });
            [self addSubview:replaceButton];
            
            CGFloat buttonWidth = replaceButton.intrinsicContentSize.width + 10;
            
            if (lineLeft+buttonWidth>self.width) {
                lineNumber ++;
                lineLeft = 5;
            }
            
            [replaceButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lineLeft);
                make.width.mas_equalTo(buttonWidth);
                make.height.mas_equalTo(20);
                make.top.mas_equalTo(lineNumber *30 +10);
            }];
        }
        
    }
}


-(void)labelClick:(UIButton *)sender{
    
    if (!_selectTagArry ||_selectTagArry.count ==0) {
        if (!_selectTagArry) {
            _selectTagArry = [NSMutableArray array];
        }
        
        sender.layer.borderColor = RGBCOLOR(145, 184, 235).CGColor;
        [sender setTitleColor:RGBCOLOR(145, 184, 235) forState:UIControlStateNormal];
        [_selectTagArry addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        
    }else{
        
        NSString *existStr=@"";
        BOOL exist = NO;
        for (NSString *str in _selectTagArry) {
            if ([str integerValue] == sender.tag) {
                exist = YES;
                existStr = str;
            }
        }
        
        if (exist) {
    
            sender.layer.borderColor = RGBCOLOR(229, 229, 229).CGColor;
            
            [sender setTitleColor:RGBCOLOR(130, 130, 130) forState:UIControlStateNormal];
            [_selectTagArry removeObject:existStr];
        }else{
            sender.layer.borderColor = RGBCOLOR(145, 184, 235).CGColor;
            [sender setTitleColor:RGBCOLOR(145, 184, 235) forState:UIControlStateNormal];
            [_selectTagArry addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        }
        
    }
    
    if ([self.delegate respondsToSelector:@selector(labelButtonView:slectLabelArr:)]) {
        [self.delegate labelButtonView:self slectLabelArr:[_selectTagArry mutableCopy]];
    }
}


-(void)replaceClick:(UIButton *)sender{
    [_selectTagArry removeAllObjects];
    if ([self.delegate respondsToSelector:@selector(labelButtonView:replaceClick:)]) {
        [self.delegate labelButtonView:self replaceClick:sender];
    }
}


//+(CGFloat)labelButtonHeight:(NSArray *)labelArry selfWidth:(CGFloat)width{
//    
//    NSInteger lineNumber = 1;
//    NSInteger lineLeft= 5;
//    for (NSInteger i=0; i<labelArry.count; i++) {
//        UIButton *labelButton = [[UIButton alloc]init];
//        labelButton.titleLabel.font = [UIFont systemFontOfSize:12];
//        labelButton.tag = i;
//        [labelButton addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
//        labelButton.layer.masksToBounds = YES;
//        labelButton.layer.cornerRadius = 5.f;
//        labelButton.layer.borderWidth = 1.f;
//    
//        [labelButton setTitle:labelArry[i] forState:UIControlStateNormal];
//        
//        CGFloat buttonWidth = labelButton.intrinsicContentSize.width + 20;
//        
//        if (lineLeft+buttonWidth>width) {
//            lineNumber ++;
//            lineLeft = 5;
//        }
//        
//        lineLeft+=buttonWidth;
//        
//        if (i==labelArry.count-1) {
//            UIButton *replaceButton = [[UIButton alloc]init];
//            replaceButton.backgroundColor = [UIColor clearColor];
//
//            replaceButton.titleLabel.font = labelButton.titleLabel.font;
//            [replaceButton setTitle:@"换一换" forState:UIControlStateNormal];
//            [replaceButton addTarget:self action:@selector(replaceClick:) forControlEvents:UIControlEventTouchUpInside];
//            [replaceButton setImage:[UIImage imageNamed:@"replace_icon"] forState:UIControlStateNormal];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [replaceButton LZSetbuttonType:LZCategoryTypeLeft];
//            });
//            
//            if (lineLeft+buttonWidth>width) {
//                lineNumber ++;
//                lineLeft = 5;
//            }
//        }
//    }
//    return lineNumber*30+10;
//}
+(CGFloat)labelButtonHeight:(NSArray *)labelArry selfWidth:(CGFloat)width labelViewType:(LabelViewType)type{
    NSInteger lineNumber = 1;
    NSInteger lineLeft= 5;
    for (NSInteger i=0; i<labelArry.count; i++) {
        UIButton *labelButton = [[UIButton alloc]init];
        labelButton.titleLabel.font = [UIFont systemFontOfSize:12];
        labelButton.tag = i;
        [labelButton addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
        labelButton.layer.masksToBounds = YES;
        labelButton.layer.cornerRadius = 5.f;
        labelButton.layer.borderWidth = 1.f;
        
        [labelButton setTitle:labelArry[i] forState:UIControlStateNormal];
        
        CGFloat buttonWidth = labelButton.intrinsicContentSize.width + 20;
        
        if (lineLeft+buttonWidth>width) {
            lineNumber ++;
            lineLeft = 5;
        }
        
        lineLeft+=buttonWidth;
        
        if (i==labelArry.count-1&&type !=LabelShowViewType) {
            UIButton *replaceButton = [[UIButton alloc]init];
            replaceButton.backgroundColor = [UIColor clearColor];
            
            replaceButton.titleLabel.font = labelButton.titleLabel.font;
            [replaceButton setTitle:@"换一换" forState:UIControlStateNormal];
            [replaceButton addTarget:self action:@selector(replaceClick:) forControlEvents:UIControlEventTouchUpInside];
            [replaceButton setImage:[UIImage imageNamed:@"replace_icon"] forState:UIControlStateNormal];
            dispatch_async(dispatch_get_main_queue(), ^{
                [replaceButton LZSetbuttonType:LZCategoryTypeLeft];
            });
            
            if (lineLeft+buttonWidth>width) {
                lineNumber ++;
                lineLeft = 5;
            }
        }
    }
 
    return lineNumber*30+10;
}
@end
