//
//  SDPatientDetailTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SDPatientDetailTableViewCell.h"
#import "YMPhotoViewCollectionViewCell.h"
static NSString *const photoViewCollectionViewCell = @"photoViewCollectionViewCell";

static NSInteger const imageHeight = 70;
static NSInteger const collectInterval = 5;
@interface SDPatientDetailTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *circleView; //圆view


@property (weak, nonatomic) IBOutlet UILabel *yearAndMothLabel; //年和月

@property (weak, nonatomic) IBOutlet UILabel *dayLabel; //多少号
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; //标题

@property (weak, nonatomic) IBOutlet UIView *photoVIew; //照片视图
@property (weak, nonatomic) IBOutlet UITextView *governancePlanTextView; //治疗方案

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoViewHeight;
@property (nonatomic ,strong)UICollectionView *collect;
@property(nonatomic,strong)UICollectionViewFlowLayout * layout;

@property(nonatomic,strong)NSMutableArray *imageArray;
@end



@implementation SDPatientDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    
    _imageArray = [NSMutableArray array];
//    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
//    [self addSubview:_view];
//    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
//    }];
    [self initCollectView];
    
   // self.showYearAndMonth = NO;
    self.circleView.layer.cornerRadius = CGRectGetWidth(self.circleView.frame)/2;
    self.circleView.layer.masksToBounds = YES;
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
    
    [_photoVIew addSubview:_collect];
    [_collect mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(_photoVIew);

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

-(void)setModel:(Health_historyModel *)model{
    _model = model;
  //  _yearAndMothLabel.text = [NSString stringWithFormat:@"%@年%@月",[model year],[model month]];
   // _governancePlanTextView.text = model.d_con;
    _dayLabel.text = [NSString stringWithFormat:@"%@日",[model day]];
    
    self.titleStr = [model valueForKey:@"title"];
    
    CGFloat collectHeight = imageHeight;
    NSMutableArray *imgArr  = [NSMutableArray array];
    NSString *imae= [model valueForKey:@"history_image"];
    
    if([imae containsString:@","]){
        
        imgArr = [NSMutableArray arrayWithArray:[imae componentsSeparatedByString:@","]];
    }else{
        
        [imgArr addObject:imae];
    }
    _imageArray =imgArr;
    
    NSArray *imgs = [imgArr copy];
    
    if (imgs.count>2) {
        if (imgs.count%2==1) {
            collectHeight = (imgs.count+1)/2*(imageHeight +collectInterval) +collectInterval;
        }else{
            collectHeight = imgs.count/2*(imageHeight +collectInterval) +collectInterval;
        }
    }
    _photoViewHeight.constant =collectHeight;
}

-(void)setShowYearAndMonth:(BOOL)showYearAndMonth{
    _yearAndMothLabel.hidden = !showYearAndMonth;
}

-(void)setShowTitleLabel:(BOOL)showTitleLabel{
    _titleLabel.hidden = !showTitleLabel;
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleLabel.text = titleStr;
}

#pragma  mark - 计算文字高度
+(CGFloat)caseDetailViewHeight:(Health_historyModel *)model{
    UITextView *textView = [[UITextView alloc]init];
   // textView.font = [UIFont systemFontOfSize:13];
  //  textView.text = model.d_con;
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(SCREEN_WIDTH - 140, MAXFLOAT)];
    CGFloat collectHeight = imageHeight;
    
    NSMutableArray *imgArr  = [NSMutableArray array];
    NSString *imae= [model valueForKey:@"history_image"];
    
    if([imae containsString:@","]){
        
       imgArr = [NSMutableArray arrayWithArray:[imae componentsSeparatedByString:@","]];
        
    }else{
        
       [imgArr addObject:imae];
    }
    NSArray *imgs = [imgArr copy];
   
    if (imgs.count>2) {
        if (imgs.count%2==1) {
            collectHeight = (imgs.count+1)/2*(imageHeight +collectInterval) +collectInterval;
        }else{
            collectHeight = imgs.count/2*(imageHeight +collectInterval) +collectInterval;
        }
    }
    return sizeToFit.height+35+collectHeight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
