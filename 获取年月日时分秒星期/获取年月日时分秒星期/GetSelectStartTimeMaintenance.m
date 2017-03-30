//
//  GetSelectStartTimeMaintenance.m
//  获取年月日时分秒星期
//
//  Created by cyf on 2017/3/29.
//  Copyright © 2017年 mc. All rights reserved.
//

#import "GetSelectStartTimeMaintenance.h"
@interface GetSelectStartTimeMaintenance (){
    NSInteger _year;
    NSInteger _week;
    NSInteger _month;
    NSInteger _day;
    NSInteger _hour;
    NSInteger _min;
}

@property (nonatomic, strong) NSArray * timeArray;

@end

@implementation GetSelectStartTimeMaintenance

- (NSArray *)timeArray{
    if (!_timeArray) {
        self.timeArray = @[@"09:00", @"09:30", @"10:00", @"10:30", @"11:00", @"11:30", @"12:00",@"12:30", @"13:00", @"13:30", @"14:00", @"14:30", @"15:00", @"15:30", @"16:00", @"16:30", @"17:00", @"17:30", @"18:00", @"18:30", @"19:00"];
    }
    return _timeArray;
}

- (NSArray *)getSelectDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour |
    NSCalendarUnitWeekday | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDate * now =[NSDate date];
    
    comps = [calendar components:unitFlags fromDate:now];
    _year=[comps year];
    _week = [comps weekday];
    _month = [comps month];
    _day = [comps day];
    _hour = [comps hour];
    _min = [comps minute];

    NSArray * array = [self getDateWithMonth:_month year:_year day:_day week:_week];
    return array;
}


/**
 设置可选择的日期

 @param month 月份
 @param year 年份
 @param day 几号
 @param week 周几
 @return 可选择的日期数组
 */
- (NSArray *)getDateWithMonth:(NSInteger)month year:(NSInteger)year day:(NSInteger)day week:(NSInteger)week{
    //创建存放日期的数组
    NSMutableArray * dateTimeArray = [NSMutableArray array];
    //获取本月天数
    NSInteger dayMax = [self getMaxDayInMonth:month year:year];
    //当天放入数组
    [dateTimeArray addObject:[NSString stringWithFormat:@"%ld月%ld日 %@", month, day ,[self stringWithWeek:week]]];
    
    for (int i = 0; i < 7; i++) {
        if (day < dayMax) {
            day ++;
        }else{
            day = 1;
            month ++;
        }
        
        if (week < 7) {
            week ++;
        }else{
            week = 1;
        }
        //日期后推依次放入数组
        [dateTimeArray addObject:[NSString stringWithFormat:@"%ld月%ld日 %@", month, day ,[self stringWithWeek:week]]];
    }
    
    if ((_hour == 17 && _min > 0) || _hour > 17) {
        [dateTimeArray removeObjectAtIndex:0];
    }else{
        [dateTimeArray removeLastObject];
    }
    
    return dateTimeArray;
}


/**
 获取当月天数

 @param month 月份
 @param year 年份
 @return 当月天数
 */
- (NSInteger)getMaxDayInMonth:(NSInteger)month year:(NSInteger)year{
    NSInteger dayMax;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        dayMax = 31;
    }else if (month == 4 || month == 6 || month == 9 || month == 11){
        dayMax = 31;
    }else if (month == 2 && [self bissextile:year]){
        dayMax = 29;
    }else{
        dayMax = 28;
    }
    return dayMax;
}


/**
 判断瑞年
 */
- (BOOL)bissextile:(NSInteger)year {
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}


- (NSArray *)getSelectTime:(NSInteger)pickerViewRow{
    // _hour < 7 是判断7：00 之前 用户可以当日从9：00 开始选择
    // (_hour == 7 && _min == 0) 是判断7：00 整的时候 用户可以当日从9：00 开始选择
    // (_hour == 17 && _min > 0) 是判断17：00 以后 用户可以次日从9：00 开始选择
    //_hour > 17 是判断17：00 以后 用户可以次日从9：00 开始选择
    
    if (pickerViewRow > 0 || _hour < 7 || _hour > 17 || (_hour == 7 && _min == 0) || (_hour == 17 && _min > 0)) {
        return self.timeArray;
    }else{
        NSInteger number = [self getStarTimeNumeber];
        return [self getTodayTimeArray:number];
    }
    return nil;
}


/**
 取出 数组中下标之后的时间

 @param number 下标
 @return 当天的数组
 */
- (NSArray *)getTodayTimeArray:(NSInteger)number{
    NSMutableArray * todayTimeArray = [NSMutableArray array];

    for (NSInteger i = number; i < self.timeArray.count; i++) {
        NSString * string = self.timeArray[i];
        [todayTimeArray addObject:string];
    }
    return todayTimeArray;
}

/**
 获取数组中开始时间的下标

 @return 下标
 */
- (NSInteger)getStarTimeNumeber{
    NSInteger number = (_hour - 9) * 2;
    if (_min > 30) {
        number ++;
    }
    number += 5;
    return number;
}

- (NSString *)stringWithWeek:(NSInteger)week{
    NSArray * weekArray = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    return weekArray[week - 1];
}

@end
