//
//  AddressPickerView.h
//  FenYouShopping
//
//  Created by fenyou on 15/12/22.
//  Copyright © 2015年 fenyou. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef enum : NSUInteger {
    pickerViewTypeDate,
    pickViewTypeNormal,
    pickViewTypeNormal1
} PickViewType;

typedef void(^ChoiceTimeBlock)(NSDictionary *hospital);

@protocol AddressPickerViewDelegate <NSObject>



- (void)getTime:(NSString *)time ;


@end
@interface AddressPickerView : UIView
@property (nonatomic,weak)id <AddressPickerViewDelegate>delegate ;
@property (nonatomic,strong)NSArray *dataList ;
@property (nonatomic,strong,readonly)NSMutableDictionary *addressInfo ;
@property (nonatomic,strong)NSDictionary *defaultSelectedAddress ;
@property (atomic,copy)ChoiceTimeBlock block ;
@property (nonatomic,strong)NSString *minDate ;
@property (nonatomic,assign)PickViewType type ;
@property (nonatomic,strong)NSDictionary *selectedHospital ;
@property (nonatomic,assign)NSInteger longType ;

@property (nonatomic,copy) NSString * selectedStr;

@property (nonatomic,copy) void (^selectedStrBlack)(NSString * selectedStr);





-(instancetype)initWithFrame:(CGRect)frame
                     andType:(PickViewType)type ;
- (void)open;
- (void)close;

@end
