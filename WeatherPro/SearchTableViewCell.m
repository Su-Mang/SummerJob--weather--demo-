//
//  SearchTableViewCell.m
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/13.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        _lableLocat = [[UILabel alloc]init];
        [self.contentView addSubview:_lableLocat];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _lableLocat.frame = CGRectMake(10, 0, 295, 45);
}

@end
