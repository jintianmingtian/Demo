//
//  TimePickerView.m
//  获取年月日时分秒星期
//
//  Created by cyf on 2017/3/29.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "TimePickerView.h"

#import "GetSelectStartTimeMaintenance.h"
#define SIZE [UIScreen mainScreen].bounds.size
#define kMenuTag 20170329

@interface TimePickerView () <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIView * _bgView;
    UIButton * _canceBut;
    UIPickerView * _reasonPV;
    UIView * _canceView;
}


@property (nonatomic, strong) GetSelectStartTimeMaintenance  * getSelectStartTimeMaintenance;
@property (nonatomic, strong) NSArray * dateArray;
@property (nonatomic, strong) NSArray * timeArray;

@end

@implementation TimePickerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.getSelectStartTimeMaintenance = [[GetSelectStartTimeMaintenance alloc] init];
        self.dateArray = [self.getSelectStartTimeMaintenance getSelectDate];
        self.timeArray = [self.getSelectStartTimeMaintenance getSelectTime:0];
        [self setSubViews];
        
    }
    
    return self;
}
- (void)setSubViews{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height)];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.5;
    _bgView.userInteractionEnabled = YES;
    [self addSubview:_bgView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackView)];
    [_bgView addGestureRecognizer:tap];
    
    _reasonPV = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SIZE.height - SIZE.width / 2, SIZE.width , SIZE.width / 2)];
    _reasonPV.showsSelectionIndicator=YES;
    _reasonPV.delegate = self;
    _reasonPV.dataSource = self;
    _reasonPV.backgroundColor = [UIColor whiteColor];
    [self addSubview:_reasonPV];
    
    _canceView = [[UIView alloc] initWithFrame:CGRectMake(0, SIZE.height - 30 - SIZE.width / 2, SIZE.width, 30)];
    _canceView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_canceView];
    
    _canceBut = [UIButton buttonWithType:UIButtonTypeSystem];
    _canceBut.frame = CGRectMake(SIZE.width - 70, 0, 60, 30);
    [_canceBut setTitle:@"完成" forState:UIControlStateNormal];
    [_canceBut addTarget:self action:@selector(cancelO:) forControlEvents:UIControlEventTouchUpInside];
    [_canceView addSubview:_canceBut];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

- (void)tapBackView {
    [_canceView removeFromSuperview];
    [_reasonPV removeFromSuperview];
    [_bgView removeFromSuperview];
    [_canceBut removeFromSuperview];
    [self removeFromSuperview];
    
}

#pragma mark ---- 按钮响应事件
- (void)cancelO:(UIButton *)sender {
    [_canceView removeFromSuperview];
    [_canceBut removeFromSuperview];
    [_bgView removeFromSuperview];
    [_reasonPV removeFromSuperview];
    [self removeFromSuperview];
    
    NSString * stringDay  = [self.dateArray objectAtIndex:[_reasonPV selectedRowInComponent:0]];
    NSString * stringTime = [self.timeArray objectAtIndex:[_reasonPV selectedRowInComponent:1]];
    
    NSString * str = [NSString stringWithFormat:@"%@  %@", stringDay, stringTime];
    if (self.itemsClickBlock) {
        self.itemsClickBlock(str);
    }
    
    
}


#pragma mark --- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.dateArray.count;
    }else {
        return self.timeArray.count;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return (component == 0) ? self.dateArray[row] : self.timeArray[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.timeArray = [self.getSelectStartTimeMaintenance getSelectTime:row];
        //接受数据
        //更新第二个滚轮的信息
        [pickerView reloadComponent:1];
        //每次滚动第一个滚轮的时候,第二个滚轮自动刷新回到第一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, [pickerView rowSizeForComponent:component].height)];
    label.backgroundColor = [UIColor clearColor];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.text = (component == 0) ? self.dateArray[row] : self.timeArray[row];
    return label;
}


#pragma mark --- 类方法封装
+ (TimePickerView *)createMenuWithTarget:(UIViewController *)target itemsClickBlock:(void(^)(NSString *str))itemsClickBlock {
    
    TimePickerView *menuView = [[TimePickerView alloc] initWithFrame:target.view.bounds];
    menuView.itemsClickBlock = itemsClickBlock;
    menuView.tag = kMenuTag;
    return menuView;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

