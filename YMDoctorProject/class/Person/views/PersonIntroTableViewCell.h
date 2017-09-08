//
//  PersonIntroTableViewCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    beGoodAt,
    ProfileIntroduce
} CellType;


typedef void(^TextChangeBlock)(NSString *key,NSString *value);

@interface PersonIntroTableViewCell : UITableViewCell<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *personTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (nonnull,nonatomic,strong)NSString *title;
@property (nonnull,nonatomic,strong)NSString *placeHolder ;
@property (nonnull,nonatomic,strong)NSString *content ;
@property (nonatomic,assign)CellType type ;
@property (nonatomic,copy)TextChangeBlock textBlock ;



@end
