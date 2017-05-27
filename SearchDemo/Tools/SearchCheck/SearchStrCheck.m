//
//  SearchStrCheck.m
//  SearchDemo
//
//  Created by Christopher on 17/5/27.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import "SearchStrCheck.h"

@implementation SearchStrCheck

+ (BOOL)isLegalString:(NSString *)string {
    if (string == nil || string ==NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

@end
