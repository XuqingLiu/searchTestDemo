//
//  ListModel.h
//  SearchDemo
//
//  Created by Christopher on 17/5/27.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject
@property (nonatomic, copy) NSString *login;         /**< 用户名*/
@property (nonatomic, copy) NSString *avatar_url;    /**< 头像*/
@property (nonatomic, copy) NSString *url;           /**< 个人详细信息*/
@property (nonatomic, copy) NSString *html_url;      /**< git主页*/
@property (nonatomic, copy) NSString *type;          /**< 类型*/
@property (nonatomic, copy) NSString *repos_url;     /**< repos情况*/
@property (nonatomic, copy) NSString *total_count;   /**< 总共多少人*/
@property (nonatomic, copy) NSMutableArray *dataArr; /**< 数据数据*/

- (void)requestDataWithUrl:(NSString*)url;
@end
