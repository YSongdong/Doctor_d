//
//  MessageView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MessageViewDelegate <NSObject>

- (void)callNumber:(NSString *)number ;

- (void)sendMessageOperator:(id)value ;

@end


@interface MessageView : UIView

@property (nonatomic,strong,nonnull)NSString *phone ;


@property (nonatomic,weak)id <MessageViewDelegate>delegate ;

+ (MessageView *)messageWithXib  ;

- (void)messageShow ;
@end
