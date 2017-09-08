//
//  FoodButton.m
//  FenYouShopping
//
//  Created by fenyou on 15/12/7.
//  Copyright © 2015年 fenyou. All rights reserved.
//

#import "FoodButton.h"

@implementation FoodButton




- (instancetype)initWithFrame:(CGRect)frame
                        Image:(UIImage *)image
                     andTitle:(NSString *)titleName andImageRation:(CGFloat)ratio{
    
    self = [super initWithFrame: frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectMake(0, 0, self.frame.size.width * ratio, self.frame.size.width * ratio);
        imageView.contentMode = UIViewContentModeScaleAspectFit ;
        imageView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(imageView.frame));
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.frame.size.height, self.frame.size.width, 17)];
        
        label.textAlignment = NSTextAlignmentCenter ;
        label.adjustsFontSizeToFitWidth = YES;
        label.text = titleName ;
        label.font = [UIFont systemFontOfSize:13];
        [self addSubview:imageView];
        [self addSubview:label];
        [self setTitle:label.text forState:UIControlStateNormal];
        [self setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
    return self ;
}


- (void)setText:(NSString *)text{
    
    _text = text ;
    self.textLabel.text = text ;
}
- (void)layoutSubviews {    
    _headImageView.bounds = CGRectMake(0, 0, 25, 25);
    _headImageView.center = CGPointMake(self.width/2, self.height/2 - 10 *VerticalRatio());
    CGSize size = [_text sizeWithBoundingSize:CGSizeMake(self.width, 0) font:[UIFont systemFontOfSize:14 *VerticalRatio()]];
    _textLabel.bounds = CGRectMake(0, 0, size.width, size.height);
    _textLabel.center = CGPointMake(self.width/2,CGRectGetMaxY(_headImageView.frame) + size.height/2 + 10);
}
- (void)setImageName:(NSString *)imageName{
    _imageName = imageName ;
    self.headImageView.image = [UIImage imageNamed:imageName];
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel labelWithFont:14 *VerticalRatio()];
        [self addSubview:_textLabel];
        _textLabel.textColor = [UIColor hightBlackClor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _textLabel ;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]init];
        [self addSubview:_headImageView];
       
    }
    
    return _headImageView ;
}


@end

