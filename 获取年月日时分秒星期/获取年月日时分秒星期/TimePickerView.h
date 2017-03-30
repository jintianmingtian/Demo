//
//  TimePickerView.h
//  获取年月日时分秒星期
//
//  Created by cyf on 2017/3/29.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemsClickBlock)(NSString *str);

@interface TimePickerView : UIView
@property (nonatomic,copy) ItemsClickBlock itemsClickBlock;
+ (TimePickerView *)createMenuWithTarget:(UIViewController *)target itemsClickBlock:(void(^)(NSString *str))itemsClickBlock;
@end
