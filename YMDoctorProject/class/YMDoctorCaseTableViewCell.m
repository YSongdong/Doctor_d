//
//  YMDoctorCaseTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorCaseTableViewCell.h"
#import "YMCaseTopView.h"
#import "YMDoctorServerInformationCollectionViewCell.h"

#import "YMDoctorDetailsHonorTableViewCell.h"
#import "YMDoctorDetailsEvaluationTableViewCell.h"
#import "YMDoctorCaseViewCollectCell.h"

#import <UIView+YYAdd.h>


static NSString *const treatmentCollectionViewCell =@"treatmentCollectionViewCell";
static NSString *const caseCollectionViewCell = @"caseCollectionViewCell";


static NSString *const honorViewCell = @"honorViewCell";
static NSString *const evaluationViewCell = @"evaluationViewCell";

static CGFloat const topHeight = 60;


@interface YMDoctorCaseTableViewCell()<YMCaseTopViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)YMCaseTopView *caseTopView;

@property (nonatomic ,strong)UICollectionView *collect;

@property(nonatomic,strong)UICollectionViewFlowLayout * layout;

@property(nonatomic,strong)UITableView *doctorCellTabelView;

@end


@implementation YMDoctorCaseTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    _caseTopView = [[YMCaseTopView alloc]init];
    _caseTopView.delegate = self;
    [self addSubview:_caseTopView];
    [_caseTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(30);
        make.right.mas_offset(-10);
    }];
    
    
    _layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.footerReferenceSize =CGSizeMake([UIScreen mainScreen].bounds.size.width-20,44);
    //设置布局方向为垂直流布局
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGFloat itemFloat = ([UIScreen mainScreen].bounds.size.width - 10*3)/2.f;
    _layout.itemSize = CGSizeMake(itemFloat-20, itemFloat+20);
    
    _collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:_layout];
    _collect.scrollEnabled = NO;
    _collect.backgroundColor = [UIColor clearColor];
    _collect.delegate = self;
    _collect.dataSource = self;
    [_collect registerClass:[YMDoctorServerInformationCollectionViewCell class] forCellWithReuseIdentifier:treatmentCollectionViewCell];
    
    [_collect registerClass:[YMDoctorCaseViewCollectCell class] forCellWithReuseIdentifier:caseCollectionViewCell];

    _collect.scrollEnabled = NO;
    
    [self addSubview:_collect];
    [_collect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_offset(-10);
        make.top.equalTo(_caseTopView.mas_bottom).offset(10);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    _doctorCellTabelView = [[UITableView alloc]init];
    _doctorCellTabelView.delegate = self;
    _doctorCellTabelView.dataSource = self;
    _doctorCellTabelView.separatorStyle = UITableViewCellSelectionStyleNone;
    _doctorCellTabelView.hidden = YES;
    
    [_doctorCellTabelView registerClass:[YMDoctorDetailsHonorTableViewCell class] forCellReuseIdentifier:honorViewCell];
     [_doctorCellTabelView registerClass:[YMDoctorDetailsEvaluationTableViewCell class] forCellReuseIdentifier:evaluationViewCell];
    _doctorCellTabelView.scrollEnabled = NO;
    
    [self addSubview:_doctorCellTabelView];
    [_doctorCellTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_caseTopView.mas_bottom).offset(10);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}



#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.f;
}
#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UITableView *)collectionView numberOfItemsInSection:(NSInteger)sectio{
    switch (_selectCaseNumber) {
        case CaseCaseNumber:
            return _doctorCaseArry.count;
            break;
        case CaseTreatmentNumber:
        default:
            return 0;
            break;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (_selectCaseNumber == CaseCaseNumber) {
        YMDoctorCaseViewCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:caseCollectionViewCell forIndexPath:indexPath];
        cell.model = _doctorCaseArry[indexPath.row];
        return cell;
    }else{
        YMDoctorServerInformationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:treatmentCollectionViewCell forIndexPath:indexPath];
        return cell;
    }
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_selectCaseNumber == CaseCaseNumber) {
    YMDoctorDetailsCaseModel *model = _doctorCaseArry[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(DoctorCaseViewCell:caseModel:)]) {
            [self.delegate DoctorCaseViewCell:self caseModel:model];
        }
    }else{
    
    }

}

#pragma mark -  UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (_selectCaseNumber) {
        case CaseHonorNumber:
            return _doctorHonorArry.count;
            break;
        case CaseServerNumber:
            return _doctorEvaluationArry.count;
            break;
        default:
            return 0;
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectCaseNumber == CaseHonorNumber) {
        YMDoctorDetailsHonorModel *model = _doctorHonorArry[indexPath.row];
        if (![NSString isEmpty:model.honor_image]) {
            return 160;
        }else{
            return 45;
        }
    }else{
        return 80;
    }
}


#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectCaseNumber == CaseHonorNumber) {
        YMDoctorDetailsHonorTableViewCell *cell = [[YMDoctorDetailsHonorTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:honorViewCell];
         cell.model= _doctorHonorArry[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (indexPath.row%2==0) {
//            cell.backgroundColor = RGBCOLOR(239, 239, 246);
//        }
        return cell;
    }else{
        YMDoctorDetailsEvaluationTableViewCell *cell = [[YMDoctorDetailsEvaluationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:evaluationViewCell];
        cell.model= _doctorEvaluationArry[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma makr - YMCaseTopViewDelegate
-(void)CaseTopView:(YMCaseTopView *)CaseTopView CaseNumber:(CaseNumber)CaseNumber{
    
    if([self.delegate respondsToSelector:@selector(DoctorCaseViewCell:clickTopNumber:)]){
        [self.delegate DoctorCaseViewCell:self clickTopNumber:CaseNumber];
    }
}


#pragma mark - setter
-(void)setSelectCaseNumber:(CaseNumber)selectCaseNumber{
    _selectCaseNumber = selectCaseNumber;
    switch (selectCaseNumber) {
        case CaseTreatmentNumber:
        case CaseCaseNumber:{
            _collect.hidden = NO;
            _doctorCellTabelView.hidden = YES;
            if (_doctorCaseArry.count == 0) {
                _layout.footerReferenceSize =CGSizeMake([UIScreen mainScreen].bounds.size.width-20,0);
            }else{
                _layout.footerReferenceSize =CGSizeMake([UIScreen mainScreen].bounds.size.width-20,44);
            }
            
           // [_doctorCellTabelView removeAllSubviews];
            [_collect reloadData];
        }
            break;
        case CaseHonorNumber:
        case CaseServerNumber:{
            _collect.hidden = YES;
            _doctorCellTabelView.hidden = NO;
            
            [_doctorCellTabelView reloadData];
           // [_collect removeAllSubviews];
        }
        default:
            break;
    }
    [_caseTopView selectCaseNumber:selectCaseNumber];
}

+(CGFloat)cellCaseHeight:(NSMutableArray<YMDoctorDetailsCaseModel *> *) doctorCaseArry{
    if (doctorCaseArry.count%2 ==0) {
        return ([UIScreen mainScreen].bounds.size.width - 10*3)/2.f * (doctorCaseArry.count/2) +(doctorCaseArry.count/2*5) + 125;
        
    }else{
        
        return ([UIScreen mainScreen].bounds.size.width - 10*3)/2.f * ((doctorCaseArry.count+1)/2) +((doctorCaseArry.count+1)/2*5) + 145;
    }
}

+(CGFloat)cellHonorHeight:(NSMutableArray<YMDoctorDetailsHonorModel *> *) doctorHonorArry{
    
    CGFloat honorHeight=0.f;
    for (YMDoctorDetailsHonorModel *model in doctorHonorArry) {
        if ([NSString isEmpty:model.honor_image]) {
            honorHeight+=45;
        }else{
            honorHeight+=160;
        }
    }
    return honorHeight+topHeight;
}

+(CGFloat)cellEvaluationHeight:(NSMutableArray<YMDoctorDetailsEvaluationModel *> *) doctorEvaluationArry{
    return 80*doctorEvaluationArry.count+topHeight;
}


@end
