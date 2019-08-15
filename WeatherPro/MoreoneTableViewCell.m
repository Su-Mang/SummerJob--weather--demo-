//
//  MoreoneTableViewCell.m
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import "MoreoneTableViewCell.h"

@implementation MoreoneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lableData = [[UILabel alloc]init];
        [self.contentView addSubview:_lableData];
        _lableTem = [[UILabel alloc]init];
        [self.contentView addSubview:_lableTem];
        _lableLocat = [[UILabel alloc]init];
        [self.contentView addSubview:_lableLocat];
        _lableWeath = [[UILabel alloc]init];
        [self.contentView addSubview:_lableWeath];
        _lableMaxTem = [[UILabel alloc]init];
        [self.contentView addSubview:_lableMaxTem];
        _lableMinTem = [[UILabel alloc]init];
        [self.contentView addSubview:_lableMinTem];
       
    }
    return self;
}
- (void)layoutSubviews
{
    _lableLocat.frame = CGRectMake(155, 20, 70, 40);
    _lableWeath.frame =CGRectMake(155, 70, 40, 30);
    _lableTem.frame = CGRectMake(130, 100, 170, 80);
    _lableData.frame = CGRectMake(30, 220, 200, 25);
     _lableMaxTem.frame = CGRectMake(260, 220, 50, 25);
     _lableMinTem.frame = CGRectMake(330, 220, 45, 25);
   
}

@end
