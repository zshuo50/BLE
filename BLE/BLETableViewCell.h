//
//  BLETableViewCell.h
//  SMBLE
//
//  Created by user on 16/9/1.
//  Copyright © 2016年 zshuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLETableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *namelabel;
@property(nonatomic,strong)UILabel *uuidlabel;
@property(nonatomic,strong)UILabel *rssilabel;
@property(nonatomic,strong)UILabel *isconnectlabel;
@end
