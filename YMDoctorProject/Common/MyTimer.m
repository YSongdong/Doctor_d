//
//  MyTimer.m
//  FenYouShopping
//
//  Created by fenyou on 16/2/3.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import "MyTimer.h"

@implementation MyTimer

+(instancetype)myTimer
{
    MyTimer *myTimer = [[MyTimer alloc]init];
    
    
    return myTimer ;
}

- (void)startTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval
                                                  target:self
                                                selector:@selector(handleTimer:)
                                                userInfo:self repeats:YES];
    }
}
- (void)setTimeInterval:(NSInteger)timeInterval {
    _timeInterval = timeInterval ;
}


- (void)handleTimer:(NSTimer *)timer
{
    if (_timer)
    {
        if (_delegate && [_delegate respondsToSelector:@selector
                          (changePageWhentimerStart)]) {
            [_delegate changePageWhentimerStart];
        }
    }
}
- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil ;
}
- (void) pauseTimer {
    _timer.fireDate = [NSDate distantFuture];
    _timer = nil ;
}

@end
