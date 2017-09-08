//
//  DemandContentCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandContentCell.h"
#import "SDPhotoBrowser.h"

@interface DemandContentCell ()<SDPhotoBrowserDelegate>

@property (nonatomic,strong)NSMutableArray *imageViews ;


@end
@implementation DemandContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (CGFloat)getContentHeightWithContent:(NSString *)content {
    
    CGSize size = [content sizeWithBoundingSize:CGSizeMake(WIDTH - 15 - 15, 0) font:[UIFont systemFontOfSize:14]];
    return size.height + 15 + 15 ;
}




- (void)setFrames {
    
    int i = 0 ;
    CGFloat f = 20;
    for (UIImageView *imageView in _imageViews ) {
        UIImage *image =imageView.image ;
        if (!image) {
            return ;
        }
        CGSize size = image.size ;
        CGFloat pictureWidth = WIDTH - 20 ;
        CGFloat ratio = size.width / pictureWidth;
        CGFloat imageHeight = size.height / ratio ;
        imageView.userInteractionEnabled = YES;
        imageView.tag = [_imageViews indexOfObject:imageView];
        UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
        [imageView addGestureRecognizer:tap];
        [tap addTarget:self action:@selector(imagetap:)];
        imageView.bounds = CGRectMake(0, 0, pictureWidth, imageHeight);
        imageView.x = 10;
        imageView.y = f ;
        f += imageHeight+10;
        i ++ ;
    }
    [self.contentView bringSubviewToFront:_indicator];
}
- (void)imagetap:(UITapGestureRecognizer *)sender {
    UIView *imageView = sender.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
        browser.sourceImagesContainerView = self.contentView;

    browser.imageCount = _images.count;
    browser.delegate = self;
    [browser show];
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    
    NSString *imageName = _images[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *sub in self.contentView.subviews) {
        if ([sub isKindOfClass:[UIImageView class]]) {
            [array addObject:sub];
        }
    }
    UIImageView *imageView = array[index];
    return imageView.image;
}
- (void)setImages:(NSArray *)images {
    
    _imageViews  = [NSMutableArray array];
    _images = images ;
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    [self.indicator startAnimating];
    if (self.isLoadEnd) {
        [self.indicator stopAnimating];
        self.indicator.hidden = YES ;
    }
    for (int i = 0; i < [images count]; i ++ ) {
        UIImageView *imageView  = [UIImageView new];
        [imageView sd_setImageWithURL:[NSURL URLWithString:images[i]]];
        [_imageViews addObject:imageView];
        [self.contentView addSubview:imageView];
    }
    [self setFrames];
    
}



@end
