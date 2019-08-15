//
//  SearchViewController.h
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol passLocatDelegate <NSObject>

-(void)passDelegate:(NSString*)str;

@end
@interface SearchViewController : UIViewController
@property(nonatomic,strong) UITextField*textField;
@property id<passLocatDelegate>delegate;
@property NSMutableArray *arryCc;
@end

NS_ASSUME_NONNULL_END
