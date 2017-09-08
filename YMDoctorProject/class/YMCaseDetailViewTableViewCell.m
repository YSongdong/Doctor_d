//
//  YMCaseDetailTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseDetailViewTableViewCell.h"
#import "YMPhotoViewCollectionViewCell.h"

static NSString *const photoViewCollectionViewCell = @"photoViewCollectionViewCell";

static NSInteger const imageHeight = 70;
static NSInteger const collectInterval = 5;

@interface YMCaseDetailViewTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *yearAndMothLabel;//年和月

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;//多少号
@property (weak, nonatomic) IBOutlet UILabel *titleLabe;//标题

@property (weak, nonatomic) IBOutlet UIView *photoView;//照片视图
@property (weak, nonatomic) IBOutlet UITextView *governancePlanTextView;//治疗方案

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeight;
@property (nonatomic ,strong)UICollectionView *collect;
@property(nonatomic,strong)UICollectionViewFlowLayout * layout;

@property(nonatomic,strong)NSMutableArray *imageArray;


@end

@implementation YMCaseDetailViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)initView{
    
    _imageArray = [NSMutableArray array];
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self initCollectView];
    
    self.showYearAndMonth = NO;
}

-(void)initCollectView{
    _layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.minimumLineSpacing = 1;
    _layout.minimumInteritemSpacing = 1;
    _layout.itemSize = CGSizeMake(80, imageHeight);
    
    _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:_layout];
    _collect.scrollEnabled = NO;
    _collect.backgroundColor = [UIColor clearColor];
    _collect.delegate = self;
    _collect.dataSource = self;
    [_collect registerClass:[YMPhotoViewCollectionViewCell class] forCellWithReuseIdentifier:photoViewCollectionViewCell];
    
    [_photoView addSubview:_collect];
    [_collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_photoView);
    }];
}


-(void)setText:(NSString *)text{
    _governancePlanTextView.text =text;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10.f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10.f;
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UITableView *)collectionView numberOfItemsInSection:(NSInteger)sectio{
    return _imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YMPhotoViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:photoViewCollectionViewCell forIndexPath:indexPath ];
    cell.imageUrl = _imageArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - setter

-(void)setModel:(YMCaseDetailsDayInformationModel *)model{
    _model = model;
    _yearAndMothLabel.text = [NSString stringWithFormat:@"%@%@",[model year],[model month]];
    _governancePlanTextView.text = model.d_con;
    _dayLabel.text = [model day];
    _imageArray = [_model.d_imgs copy];
    [_collect reloadData];
    CGFloat collectHeight = imageHeight;

    if (model.d_imgs.count>3) {
        if (model.d_imgs.count%2==1) {
            collectHeight = (model.d_imgs.count+1)/2*(imageHeight +collectInterval) +collectInterval;
        }else{
            collectHeight = model.d_imgs.count/2*(imageHeight +collectInterval) +collectInterval;
        }
    }
    _photoViewHeight.constant =collectHeight;
}

-(void)setShowYearAndMonth:(BOOL)showYearAndMonth{
    _yearAndMothLabel.hidden = !showYearAndMonth;
}

-(void)setShowTitleLabel:(BOOL)showTitleLabel{
    _titleLabe.hidden = !showTitleLabel;
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleLabe.text = titleStr;
}

#pragma  mark - 计算文字高度
+(CGFloat)caseDetailViewHeight:(YMCaseDetailsDayInformationModel *)model{
    UITextView *textView = [[UITextView alloc]init];
    textView.font = [UIFont systemFontOfSize:13];
    textView.text = model.d_con;
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(SCREEN_WIDTH - 140, MAXFLOAT)];
    CGFloat collectHeight = imageHeight;

    if (model.d_imgs.count>3) {
        if (model.d_imgs.count%2==1) {
            collectHeight = (model.d_imgs.count+1)/2*(imageHeight +collectInterval) +collectInterval;
        }else{
            collectHeight = model.d_imgs.count/2*(imageHeight +collectInterval) +collectInterval;
        }
    }
    
    return sizeToFit.height+35+collectHeight;
}

@end
