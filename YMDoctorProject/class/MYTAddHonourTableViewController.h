//
//  MYTAddHonourTableViewController.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTAddHonourTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *honorNameTF;

@property (weak, nonatomic) IBOutlet UIButton *honorTimeBtn;

@property (weak, nonatomic) IBOutlet UIImageView *honorImageView;

@property (nonatomic, strong)NSMutableDictionary *params;

@property (nonatomic,strong) NSDictionary * pushDict;


-(NSString *)getImgName;

@end
