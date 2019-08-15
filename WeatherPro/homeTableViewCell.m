//
//  homeTableViewCell.m
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import "homeTableViewCell.h"

@implementation homeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.labelTemp = [[UILabel alloc]init];
        self.labelTime = [[UILabel alloc]init];
        self.labelPlace = [[UILabel alloc]init];
        [self.contentView addSubview:_labelPlace];
        [self .contentView addSubview:_labelTemp];
        [self.contentView addSubview:_labelTime];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _labelTemp.frame = CGRectMake(260, 20, 120, 55);
    _labelTime.frame = CGRectMake(10, 10, 200, 30);
    _labelPlace.frame = CGRectMake(10, 40, 95, 35);
}

@end
