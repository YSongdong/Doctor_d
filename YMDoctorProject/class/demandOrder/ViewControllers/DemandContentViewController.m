//
//  DemandContentViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandContentViewController.h"
#import "DemandContentCell.h"
@interface DemandContentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableDictionary *dic;
@property (nonatomic,strong)NSMutableArray *keys ;


//singleLineIdentifier
//multiplyContentIdentifier
//cotentImageViewIdentifier

@end

@implementation DemandContentViewController
{
    CGFloat cellHight;
    BOOL isLoadEnd ;
    
}

- (void)dealloc {
    
    NSLog(@"%@",self);
    
}

- (NSMutableArray *)keys {
    if (!_keys) {
        
        _keys = [NSMutableArray array];
    }
    return _keys ;
}
- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
        
    }
    return _dic ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.sectionFooterHeight = 10 ;
    cellHight = 100 ;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getImageContentWithImages:self.model.img commplete:^(CGFloat h) {
        isLoadEnd = YES ;
        cellHight = h ;
        [self.tableView reloadData];
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {    
    return 1 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = 0 ;
    if (self.model.seniority) {
        [self.dic setObject:@(count) forKey:@"医师资格"];
        [self.keys addObject:@"医师资格"];
        count ++ ;
    }
    if (self.model.ktimes) {
        self.dic[@"就诊时间"] = @(count);
        [self.keys addObject:@"就诊时间"];

        count ++ ;
    }
    if (self.model.area) {
        self.dic[@"区域就诊"] = @(count);
        [self.keys addObject:@"就诊区域"];

        count ++ ;
    }
    if (self.model.demand_needs) {
        self.dic[ @"需求描述"] =@(count);
        [self.keys addObject:@"需求描述"];
      count ++ ;
    }
    if ([self.model.img count] > 0) {
        self.dic[@"图片"] = @(count);
        [self.keys addObject:@"图片"];
        count++ ;
    }
    return count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemandContentCell *cell ;
    
    if (self.model.seniority) {

        NSInteger count = [self.dic[@"医师资格"] integerValue];
        if (indexPath.section == count) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"singleLineIdentifier"];

            cell.ttitleLabel.text = self.model.seniority ;
        }
    }
    
    if (self.model.ktimes) {

        NSInteger count = [self.dic[@"就诊时间"] integerValue];
        if (indexPath.section == count) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"singleLineIdentifier"];

            cell.ttitleLabel.text = [NSString stringWithFormat:@"%@ - %@",self.model.ktimes,self.model.jtimes];
        }
    }
    if (self.model.area) {

        NSInteger count = [self.dic[@"就诊区域"] integerValue];
        if (indexPath.section == count) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"singleLineIdentifier"];
            cell.ttitleLabel.text = self.model.area ;
        }
    }
    if (self.model.demand_needs) {
        NSInteger count = [self.dic[@"需求描述"] integerValue];
        if (indexPath.section == count) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"multiplyContentIdentifier"];
            cell.contentLabel.text = self.model.demand_needs ;

        }
    }
    if ([self.model.img count] > 0) {
        NSInteger count = [self.dic[@"图片"]integerValue];
        if (indexPath.section == count) {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cotentImageViewIdentifier"];
            cell.isLoadEnd = isLoadEnd ;
            cell.images = self.model.img;
        }
    }
    return cell ;
}
- (UIView *)tableView:(UITableView *)tableView
     viewForHeaderInSection:(NSInteger)section {
    
    return nil ;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.model.img count] > 0) {
        NSInteger count = [self.dic[@"图片"]integerValue];
        if (indexPath.section == count) {
            return cellHight;
        }
    }
    if (self.model.demand_needs) {
        NSInteger count = [self.dic[@"需求描述"] integerValue];
        if (indexPath.section == count) {
            return [DemandContentCell getContentHeightWithContent:self.model.demand_needs];
        }
    }
    return 44 ;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    
    return _keys[section];
}
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 30 ;
    }
    if (section == 4) {
        return 0.0001f ;
    }
    return 20 ;
    
}
- (void)getImageContentWithImages:(NSArray *)images
                        commplete:(void (^)(CGFloat))commpleteBlock {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        __block  CGFloat height = 0 ;
        for (NSString  *imageUrl in images) {
            
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl] options:NSDataReadingMappedIfSafe error:nil]];
            
            if (image) {
                CGSize size = image.size ;
                CGFloat pictureWidth = WIDTH - 20 ;
                CGFloat ratio = size.width / pictureWidth;
                CGFloat imageHeight = size.height / ratio ;
                height += imageHeight ;
            }else {
                height += 0 ;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (height == 0) {
                height = 100 ;
            }
            commpleteBlock(height);
            
        });
    });
}

@end
