//
//  UserInfoModel.m
//  SearchDemo
//
//  Created by Christopher on 17/5/27.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import "UserInfoModel.h"
#import "UrlRequest.h"

@implementation UserInfoModel

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
    [UrlRequest getRequestWithURL:url success:^(id resultDic) {
        [weakSelf jsonData:resultDic];
    } failure:^(NSError *error) {
        NSLog(@"");
    }];
}

- (void)jsonData:(NSMutableArray *)resultDic {
    //NSLog(@"%@", resultDic);
//    NSMutableDictionary *dicLan = [[NSMutableDictionary alloc] initWithCapacity:10];
//    NSString *language = @"";
    if (resultDic.count > 0 && [resultDic isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dataDict in resultDic) {
            UserInfoModel *model = [[UserInfoModel alloc] init];
            model.language = [dataDict objectForKey:@"language"];
            if (model.language != NULL || ![model.language isEqualToString:@""]) {
                [self.dataArr addObject:model.language];
            }
            
            
        }
        NSLog(@"languageArr == %@", self.dataArr);
    }
    
    // 统计数组中出现频率最高的language，并传值(待完成)
    
    NSString *passLan = self.dataArr.firstObject;
    
    NSNotification *notice = [NSNotification notificationWithName:@"reposList" object:passLan];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

@end
