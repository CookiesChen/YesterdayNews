//
//  TimeUtils.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "TimeUtils.h"

@implementation TimeUtils

+ (NSString *)getTimeDifference: (NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|
                          NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:date toDate:[NSDate date] options:0];
    if(cmps.year != 0){
        return [[NSString alloc] initWithFormat:@"%ld年前", (long)cmps.year];
    } else if(cmps.month != 0){
        return [[NSString alloc] initWithFormat:@"%ld个月前", (long)cmps.month];
    } else if(cmps.day != 0){
        return [[NSString alloc] initWithFormat:@"%ld天前", (long)cmps.day];
    } else if(cmps.hour != 0){
        return [[NSString alloc] initWithFormat:@"%ld小时前", (long)cmps.hour];
    } else if(cmps.minute != 0) {
        return [[NSString alloc] initWithFormat:@"%ld分钟前", (long)cmps.minute];
    } else{
        return [[NSString alloc] initWithFormat:@"%ld秒前", (long)cmps.second];
    }
}

@end
