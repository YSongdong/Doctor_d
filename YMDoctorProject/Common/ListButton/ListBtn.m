//
//  ListBtn.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ListBtn.h"
#define IMAGEVIEW_HEIGHT 15 *VerticalRatio()
@interface ListBtn ()

@property (nonatomic,strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView *iconImageView;
@property (nonatomic,assign)CGFloat offset ;
@end
@implementation ListBtn

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self ;
}

- (NSAttributedString *)attributeStringWithTitle:(NSString *)title {
    
    NSTextAttachment *attact = [[NSTextAttachment alloc]init];
    [attact setImage:[UIImage imageNamed:@"首页下拉"]];
    attact.bounds = CGRectMake(0, 0, 12, 8);
    NSAttributedString *atr = [NSAttributedString attributedStringWithAttachment:attact];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:title];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]
                          };
    [attri setAttributes:dic range:NSMakeRange(0, title.length)];
    [attri appendAttributedString:atr];
    [self setAttributedTitle:attri forState:UIControlStateNormal];
    self.contentMode = UIViewContentModeScaleAspectFit ;
    [self setNeedsLayout];
    return attri ;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setTitle:(NSString *)title {
    _title = title ;
    [self setTitle:title forState:UIControlStateNormal];
    
    [self layoutSubviews];
}
- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        
        //        _textLabel.font = [UIFont systemFontOfSize:14 *VerticalRatio()weight:1];
        //  _textLabel.textColor = [UIColor hightBlackClor];
    }
    return _textLabel ;
}
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@""];
    }return _iconImageView;
}
- (void)setHaveListFlag:(BOOL)haveListFlag {
    _haveListFlag = haveListFlag ;
    if (_haveListFlag) {
        [self addSubview:_iconImageView];
    }
}

- (void)setSelected:(BOOL)selected
           andColor:(UIColor *)color{
    [super setSelected:selected];
    self.textLabel.textColor = color ;
}
@end
