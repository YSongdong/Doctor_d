//
//  CommonTextField.h
//  FenYouShopping
//
//  Created by fenyounet on 16/8/16.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTextField : UITextField
{
    
    NSString *_content ;
    
}
@property (nonatomic,strong)NSString *title ;

@property (nonatomic,strong)NSString *placeHolder;
@property (nonatomic,strong)UIFont *titleFont ;

@property (nonatomic,assign)UIKeyboardType keyType ;

@property (nonatomic,strong)UIFont *textFont ;



- (instancetype)initWithPosition_Y:(CGFloat)position_Y
                         andHeight:(CGFloat)height ;

- (NSString *)getContent ;

- (void)addLine ;
- (void)setContent:(NSString *)content ;
@end
