//
//  UIButton+CommonButton.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UIButton+CommonButton.h"

@implementation UIButton (CommonButton)
- (void)selected:(BOOL)selected
andBackgroundColor:(UIColor *)color {
    self.selected = selected ;
    self.backgroundColor = color ;
}
- (void)setTitle:(CGFloat )fontSize {
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}


- (void)vertificationButtonClickedAnimationWithTimeStart:(NSInteger )startTime beginString:(NSString *)title block:(buttonUnEnableBlock)unableBlock{
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        //时间为0的时候
//        i -- ;
//        NSInteger i = [[NSDate date] timeIntervalSinceDate:<#(nonnull NSDate *)#>];
//        label.text = str;
//       //    [timer invalidate];
    
    __block NSInteger timeout = startTime ;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {
            
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitleColor:[UIColor colorWithRGBHex:0x0091FF] forState:UIControlStateNormal];
                self.enabled =YES;
                [self setTitle:title forState:UIControlStateNormal];
            });
        }
        else {            
            int allTime = (int)startTime  + 1 ;
            int seconds = timeout % allTime;
             dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:[NSString stringWithFormat:@"%ds后重发",seconds] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                self.enabled = NO ;
                timeout -- ;
            });
        }
        
    });
    dispatch_resume(timer);
}



@end
