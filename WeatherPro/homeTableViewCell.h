//
//  homeTableViewCell.h
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel*labelTime;
@property(nonatomic,strong)UILabel*labelPlace;
@property(nonatomic,strong)UILabel*labelTemp;

@end

NS_ASSUME_NONNULL_END
