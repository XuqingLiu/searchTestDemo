//
//  UserInfoModel.h
//  SearchDemo
//
//  Created by Christopher on 17/5/27.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property (nonatomic, copy) NSString *language;          /**< 个人详细信息*/
@property (nonatomic, copy) NSMutableArray *dataArr;     /**< 数据*/

- (void)requestDataWithUrl:(NSString*)url;
@end
