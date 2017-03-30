//
//  GetSelectStartTimeMaintenance.h
//  获取年月日时分秒星期
//
//  Created by cyf on 2017/3/29.
//  Copyright © 2017年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetSelectStartTimeMaintenance : NSObject
/**
 获取选择的日期
 
 @return 日期数组
 */
- (NSArray *)getSelectDate;


/**
 获取选择的时间

 @return 时间数组
 */
- (NSArray *)getSelectTime:(NSInteger)pickerViewRow;

@end
