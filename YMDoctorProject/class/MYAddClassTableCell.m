//
//  MYAddClassTableCell.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/20.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIButton+WebCache.h>
#import "CaseImgButton.h"
#import "MYAddClassTableCell.h"

@interface MYAddClassTableCell ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet CaseImgButton *firstbtn;
@property (weak, nonatomic) IBOutlet CaseImgButton *twoBtn;
@property (weak, nonatomic) IBOutlet CaseImgButton *threeBtn;
@property (weak, nonatomic) IBOutlet CaseImgButton *fourBtn;

@property (nonatomic,strong) CaseImgButton * jieshouBtn;

@property (nonatomic,strong) NSMutableArray * btnArray;

@end


@implementation MYAddClassTableCell

-(NSMutableArray *)btnArray{
    
    if (_btnArray==nil) {
        
        _btnArray = [NSMutableArray new];
    }
    return _btnArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.firstbtn.index = 0;
    self.twoBtn.index = 1;
    self.threeBtn.index = 2;
    self.fourBtn.index = 3;
    
    self.twoBtn.hidden = YES;
    self.threeBtn.hidden = YES;
    self.fourBtn.hidden = YES;
    
    if (self.firstbtn == nil || self.twoBtn == nil || self.threeBtn == nil || self.fourBtn == nil) {
        return;
    }
    
    [self.btnArray addObject:self.firstbtn];
    [self.btnArray addObject:self.twoBtn];
    [self.btnArray addObject:self.threeBtn];
    [self.btnArray addObject:self.fourBtn];
    
}

- (IBAction)btnClick:(CaseImgButton*)sender {
    
    [self imageChooseBtnClick:sender];
}

-(void)setNextImgBtnXS{
    
    for (CaseImgButton * btn in self.btnArray) {
        
        if (self.jieshouBtn.index == btn.index-1) {
            
            btn.hidden = NO;
        }
    }
}

-(void)setD_imgs:(NSArray *)d_imgs{
    
    if (d_imgs) {
        for (CaseImgButton * btn in self.btnArray) {
            btn.hidden = YES;
        }
        if (d_imgs.count==0) {
            CaseImgButton * btn1  = self.btnArray[0];
            btn1.hidden = NO;
        }
        
        for (int i =0; i<d_imgs.count; i++) {
            
            CaseImgButton * btn  = self.btnArray[i];
            
            if ( i + 1 < self.btnArray.count) {
                
                CaseImgButton * btn1  = self.btnArray[i+1];
                btn1.hidden = NO;
            }
            
            btn.hidden = NO;
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:d_imgs[i]] forState:UIControlStateNormal];
        }
    }
}

//上传头像
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.03);
    
    NSString *timeString =[self.vc getImgName];
    NSDictionary * imgDict = @{
                               @"data":data,
                               @"name":timeString
                               };
    
    [self.vc.fileImgArr addObject: imgDict];
    NSMutableDictionary * dict = self.modelDict;

    if (!dict[@"d_imgs"]) {
        NSMutableArray * tempArr = [NSMutableArray new];
        dict[@"d_imgs"] = tempArr;
    }
   
    NSMutableArray *  d_imgs= dict[@"d_imgs"];
    
    NSInteger index = self.jieshouBtn.index;
    
    if (index<d_imgs.count) {
        
        d_imgs[index] = timeString;
        
    }else{
        
        [d_imgs addObject:timeString];
    }
    
    [self.jieshouBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    [self setNextImgBtnXS];
    //    self.detailImageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imageChooseBtnClick:(CaseImgButton *)sender{
    self.jieshouBtn = sender;
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            pickerController.allowsEditing = YES;
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.vc presentViewController:pickerController animated:YES completion:nil];
        }
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相册
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.allowsEditing = YES;
        [self.vc presentViewController:pickerController animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }];
    [controller addAction:action];
    [controller addAction:action1];
    [controller addAction:action2];
    [self.vc.navigationController presentViewController:controller animated:YES completion:nil];
}


- (IBAction)anliBiaoTI:(UITextField *)sender {
    if (sender.tag == 0) {
        
        self.vc.params[@"case_title"] = sender.text;

    }
    if (sender.tag == 2) {
        self.vc.params[@"case_desc"] = sender.text;
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (IBAction)returnClick:(UITextField *)sender {
    
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if (self.modelDict) {
        self.modelDict[@"d_con"] = textView.text;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        self.placeHolderLab.hidden = NO ;
    }
    
    if (self.modelDict) {
        self.modelDict[@"d_con"] = textView.text;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.placeHolderLab.hidden = YES ;
    
    return YES ;
}


@end

