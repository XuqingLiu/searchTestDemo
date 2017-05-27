//
//  MXListTableViewCell.m
//  SearchDemo
//
//  Created by Christopher on 17/5/27.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import "MXListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SearchStrCheck.h"

@implementation MXListTableViewCell
{
    __weak IBOutlet UIImageView *_avatarIV;
    __weak IBOutlet UILabel *_loginLa;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cellUserList";
    MXListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MXListTableViewCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  // 行选中效果
    }
    return cell;
}

- (void)setAvatarIV:(NSString *)imageUrl userName:(NSString*)loginStr userType:(NSString *)typeStr {
    
    if ([SearchStrCheck isLegalString:_loginLa.text]) {
        
        [_avatarIV sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                     placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
        _loginLa.text = loginStr;
    }
}

@end
