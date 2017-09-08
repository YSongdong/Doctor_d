//
//  MYTScannerView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/5/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MYTScannerView.h"

@interface MYTScannerView ()

- (IBAction)tscannerSaveBtnAction:(UIButton *)sender;

@end



@implementation MYTScannerView

-(void)awakeFromNib{
    [super awakeFromNib];

    self.saveScannerView.layer.cornerRadius = 5;
    self.cancelBtn.layer.cornerRadius = 5;
}

+ (instancetype)initWithXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
}

- (IBAction)cancelBtnClick:(UIButton *)sender {
    
    [self miss];
}


//展示
-(void)show{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
}

//消失
-(void)miss{
    
    [self removeFromSuperview];
    
}

- (IBAction)tscannerSaveBtnAction:(UIButton *)sender {
    NSLog(@"保存图片");
    
    UIImage *codeImage = [self screenShot: _imgView]; //截图_code.layer.cornerRadius = 10;
    
    // codeImage = [codeImage imageByRoundCornerRadius:5]; //使它保存图片后为正方形
    
    if (codeImage) {
        UIImageWriteToSavedPhotosAlbum(codeImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error) {
        message = @"保存成功";
    } else {
        message = @"图片保存失败";
    }
    
    [self setAlertViewWithTitle:message withCount:2];
}
-(UIImage *)screenShot:(UIView *)view
{
    CGSize size = view.frame.size;
    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
    [view drawViewHierarchyInRect:rect  afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

@end
