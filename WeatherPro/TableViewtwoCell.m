//
//  TableViewtwoCell.m
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import "TableViewtwoCell.h"

@implementation TableViewtwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lableDes = [[UILabel alloc]init];
        [self.contentView addSubview:_lableDes];
        _lableData =[[UILabel alloc]init];
        [self.contentView addSubview:_lableData];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _lableData.frame = CGRectMake(15, 5, 100, 20) ;
    _lableDes.frame = CGRectMake(15, 33, 375, 32) ;
}
@end
