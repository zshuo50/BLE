//
//  BLETableViewCell.m
//  SMBLE
//
//  Created by user on 16/9/1.
//  Copyright © 2016年 zshuo. All rights reserved.
//

#import "BLETableViewCell.h"
#define WID ([[UIScreen mainScreen] bounds].size.width<[[UIScreen mainScreen] bounds].size.height?[[UIScreen mainScreen] bounds].size.width:[[UIScreen mainScreen] bounds].size.height)
#define  HEI ([[UIScreen mainScreen] bounds].size.width>[[UIScreen mainScreen] bounds].size.height?[[UIScreen mainScreen] bounds].size.width:[[UIScreen mainScreen] bounds].size.height)
@implementation BLETableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _namelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 200, 25)];
        [self.contentView addSubview:_namelabel];
        
        _uuidlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 550, 20)];
        _uuidlabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_uuidlabel];
        
        _rssilabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 100, 20)];
        _rssilabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_rssilabel];
        
        _isconnectlabel = [[UILabel alloc]initWithFrame:CGRectMake(WID-100, 20, 80, 30)];
        _isconnectlabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_isconnectlabel];
    }
    return self;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
