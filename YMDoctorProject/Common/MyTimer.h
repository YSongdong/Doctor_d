//
//  MyTimer.h
//  FenYouShopping
//
//  Created by fenyou on 16/2/3.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyTimerDelegate <NSObject>

- (void)changePageWhentimerStart ;

@end

@interface MyTimer : NSObject {
    
    NSTimer * _timer ;
    NSInteger _timeInterval ;
}
@property (nonatomic,weak)id <MyTimerDelegate>delegate ;

- (void)startTimer ;
- (void)handleTimer:(NSTimer *)timer ;
- (void)stopTimer ;
- (void) pauseTimer ;
+ (instancetype)myTimer ;

- (void)setTimeInterval:(NSInteger)timeInterval ;

@end
