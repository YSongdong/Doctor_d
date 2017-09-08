//
//  YMPhotoViewCollectionViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMPhotoViewCollectionViewCell.h"
#import "XWScanImage.h"

@interface YMPhotoViewCollectionViewCell()

@property(nonatomic,strong)UIImageView *photoImageView;

@end

@implementation YMPhotoViewCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

-(void)initView{
    _photoImageView = [[UIImageView alloc]init];
    [_photoImageView setContentMode:UIViewContentModeScaleAspectFill];
    _photoImageView.image = [UIImage imageNamed:@"computer-picture"];
    _photoImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_photoImageView];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    [_photoImageView addGestureRecognizer:tapGestureRecognizer];
    [_photoImageView setUserInteractionEnabled:YES];
}

-(void)setImageUrl:(NSString *)imageUrl{
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"computer-picture"]];
}

#pragma mark - 浏览大图点击事件
-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

@end
