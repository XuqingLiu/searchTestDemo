//
//  MXListTableViewCell.h
//  SearchDemo
//
//  Created by Christopher on 17/5/27.
//  Copyright © 2017年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *languagePre;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setAvatarIV:(NSString *)imageUrl userName:(NSString*)loginStr userType:(NSString *)typeStr;

@end
