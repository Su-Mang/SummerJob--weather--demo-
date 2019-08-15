//
//  MoreViewController.h
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoreViewController : UIViewController
@property NSInteger *number;
@property NSInteger *numberCount;
@property (nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)UIScrollView* scrollView;
@property NSMutableArray *dicty;
@property NSMutableArray *dictHour;
@end

NS_ASSUME_NONNULL_END
