//
//  DateFormatter.m
//  ProkrutObjc
//
//  Created by Savushkin Maksim on 28/01/16.
//  Copyright © 2016 DevAlloy. All rights reserved.
//

#import "DateFormatter.h"

BOOL isSameDay(NSDate *date1, NSDate *date2) {
    if (date1 == nil || date2 == nil) {
        return NO;
    }
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}