//
//  OpenViewController.m
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/14.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import "OpenViewController.h"
#import "HomeViewController.h"
@interface OpenViewController ()

@end

@implementation OpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *iamgeView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    iamgeView.image = [UIImage imageNamed:@"31565781833_.pic.jpg"];
    [self.view addSubview:iamgeView];
    [self performSelector:@selector(press) withObject:self afterDelay:2];
   
}
-(void)press
{
    HomeViewController *homeViewControlle = [[HomeViewController alloc]init];
    [self presentViewController:homeViewControlle animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
