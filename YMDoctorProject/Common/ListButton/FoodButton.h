//
//  FoodButton.h
//  FenYouShopping
//
//  Created by fenyou on 15/12/7.
//  Copyright © 2015年 fenyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodButton:UIButton

@property (nonatomic,strong)UILabel *textLabel ;
@property (nonatomic,strong)UIImageView *headImageView ;

@property (nonatomic,strong)NSString *text;

@property (nonatomic,strong)NSString *imageName ;


- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image andTitle:(NSString *)titleName andImageRation:(CGFloat)ratio ;
@end
