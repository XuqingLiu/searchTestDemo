//
//  UrlRequest.h
//  SearchDemo
//
//  Created by Christopher on 17/5/27.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlRequest : NSObject
/**
 *  GET请求//HTTPs
 *
 *  @param url        用来创建请求URL的URL string(基本URL)
 *  @param success    请求成功时回调
 *  @param failure    请求失败时回调
 */
+ (void)getRequestWithURL:(NSString *)url success:(void (^)(id resultDic))success failure:(void (^)(NSError * error))failure;

@end
