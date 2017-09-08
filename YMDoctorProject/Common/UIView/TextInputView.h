//
//  TextInputView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextInputViewDelegate <NSObject>


- (void)didClickSureBtn:(NSString *)content ;

@end

@interface TextInputView : UIView

@property (nonatomic,strong)NSString *content ;

@property (nonatomic,assign)id <TextInputViewDelegate>delegate ;


+ (TextInputView *)textViewLoadFromXibWithTitleString:(NSString *)title  ;


- (void)inputViewShow ;


@end
