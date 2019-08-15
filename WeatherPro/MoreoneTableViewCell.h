//
//  MoreoneTableViewCell.h
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MoreoneTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *lableLocat;
@property (nonatomic,strong)UILabel *lableWeath;
@property (nonatomic,strong)UILabel *lableTem;
@property (nonatomic,strong)UILabel *lableData;
@property (nonatomic,strong)UILabel *lableMaxTem;
@property (nonatomic,strong)UILabel *lableMinTem;
@end

NS_ASSUME_NONNULL_END
