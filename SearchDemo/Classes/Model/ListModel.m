//
//  ListModel.m
//  SearchDemo
//
//  Created by Christopher on 17/5/27.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import "ListModel.h"
#import "UrlRequest.h"
#import "SearchStrCheck.h"

NSString *const APIUrl = @"https://api.github.com/search/users?q=";

@implementation ListModel

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr){
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)requestDataWithUrl:(NSString*)url {
    __weak typeof(self) weakSelf = self;
    url = [NSString stringWithFormat:@"%@%@",APIUrl,url];
    [UrlRequest getRequestWithURL:url success:^(id resultDic) {
        [weakSelf jsonData:resultDic];
    } failure:^(NSError *error) {
    }];
}

- (void)jsonData:(NSDictionary *)resultDic {
    _total_count = [resultDic objectForKey:@"total_count"];
    NSMutableArray *dataArr = [resultDic objectForKey:@"items"];
    if (dataArr.count > 0 && [dataArr isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dataDict in dataArr) {
            ListModel *model = [[ListModel alloc] init];
            [model setValuesForKeysWithDictionary:dataDict];
            //NSLog(@"%@", model.login);
            [self.dataArr addObject:model];
        }
    }
    NSNotification *notice = [NSNotification notificationWithName:@"userList" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

@end
