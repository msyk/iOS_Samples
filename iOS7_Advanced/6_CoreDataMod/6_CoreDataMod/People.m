//
//  People.m
//  6_CoreDataMod
//
//  Created by Masayuki Nii on 2014/02/21.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "People.h"
#import "Company.h"


@implementation People

@dynamic birthday;
@dynamic mail;
@dynamic name;
@dynamic phone;
@dynamic prefecture;
@dynamic phonetic;
@dynamic company;

- (NSString *)group {
    if ( self.phonetic.length < 1 ) {
        return @"";
    }
    NSArray *c = @[@"A", @"あ", @"か", @"さ", @"た", @"な", @"は", @"ま", @"や", @"ら", @"わ"];
    __block NSInteger selected = -1;
    [c enumerateObjectsUsingBlock: ^(NSString *letter, NSUInteger idx, BOOL *stop){
        if ( [self.phonetic compare: letter] == NSOrderedAscending )   {
            selected = idx;
            *stop = YES;
        }
    }];
    return selected >= 0 ? c[selected - 1] : c[c.count - 1];
}

- (NSNumber *)age   {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSCalendarUnit reqUnits = NSYearCalendarUnit;
    NSDateComponents *period = [cal components: reqUnits
                                        fromDate: self.birthday
                                          toDate: [NSDate date]
                                         options: 0];
    return [NSNumber numberWithInt: period.year];
}

@end
