//
//  HomeViewController.m
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import "HomeViewController.h"
#import "homeTableViewCell.h"
#import "SearchViewController.h"
#import "TimeModel.h"
#import "HourlyModel.h"
#import "MoreViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,passLocatDelegate>
@property(nonatomic,strong)UITableView* TableView;
@property(nonatomic,copy)NSString * cityStr;
@property (nonatomic)NSMutableArray *ditarry;
@property (nonatomic)NSMutableArray *dictarryHour;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *iamgeView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 620)];
    iamgeView.image = [UIImage imageNamed:@"51565781835_.pic.jpg"];
    [self.view addSubview:iamgeView];
    _TableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 620) style:UITableViewStyleGrouped];
    _TableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_TableView];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    UIButton *addButton  = [[UIButton alloc]initWithFrame:CGRectMake(335, 625, 40, 40)];
    [self.view addSubview:addButton];
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [addButton setImage:[UIImage imageNamed:@"add_icon.png"] forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor whiteColor];
    _ditarry = [[NSMutableArray alloc]init];
    _dictarryHour = [[NSMutableArray alloc ]init];
    _TableView.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
 
    
}
-(void)reloat
{
    [_TableView reloadData];
}
-(void)add
{
    NSLog(@"123");
 SearchViewController  * searchTableviewController = [[SearchViewController alloc]init];
    searchTableviewController.delegate = self;
    searchTableviewController.arryCc = _ditarry;
    [self presentViewController:searchTableviewController animated:YES completion:nil];
    
}
- (void)passDelegate:(NSString *)str
{
    _cityStr = str;
    [self lodaTestData];
    [self lodaTestDataTwo];
    NSLog(@"%@",_ditarry);
    [_TableView reloadData];
}

-(void)lodaTestData
{
    //设置请求地址
    
    NSString *str = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=d046363859344a96bfe52b83415dd17b",_cityStr ];
    NSURL *url = [NSURL URLWithString:str];
    //封装一个请求类
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //创建Session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil)        {
            NSDictionary* objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            TimeModel *timeModel = [[TimeModel alloc]init];
      timeModel.timeStr = objc[@"HeWeather6"][0][@"update"][@"loc"];
    timeModel.placeStr =objc[@"HeWeather6"][0][@"basic"][@"location"];
            timeModel.temStr =objc[@"HeWeather6"][0][@"now"][@"fl"];
           
            timeModel.maxTStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_max"];
            timeModel.minStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_min"];
               timeModel.qingStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"cond_txt_d"];
            timeModel.forstomStrdata =objc[@"HeWeather6"][0][@"daily_forecast"][1][@"cond_txt"];
              timeModel.forstomStrmin =objc[@"HeWeather6"][0][@"daily_forecast"][1][@"tmp_min"];
               timeModel.forstomStrmax =objc[@"HeWeather6"][0][@"daily_forecast"][1][@"tmp_max"];
               timeModel.fordesStr =objc[@"HeWeather6"][0][@"daily_forecast"][1][@"cond_txt_n"];
                timeModel.forthedataStr =objc[@"HeWeather6"][0][@"daily_forecast"][2][@"cond_txt_n"];
            timeModel.fortheminStr =objc[@"HeWeather6"][0][@"daily_forecast"][2][@"tmp_min"];
            timeModel.forthemaxStr =objc[@"HeWeather6"][0][@"daily_forecast"][2][@"tmp_max"];
            timeModel.forthedesStr =objc[@"HeWeather6"][0][@"daily_forecast"][2][@"cond_txt_n"];
              timeModel.richuStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"sr"];
              timeModel.riluoStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"ss"];
             timeModel.jiangyuStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"pop"];
              timeModel.shiduStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"hum"];
          timeModel.fengsuStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_spd"];
                timeModel.tiganStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"hum"];
                timeModel.jiangshuiStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"pcpn"];
                timeModel.qiyaStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"pres"];
                timeModel.nengjianduStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"vis"];
                timeModel.ziwaixianStr =objc[@"HeWeather6"][0][@"daily_forecast"][0][@"uv_index"];
            timeModel.kongqizhiliangStr =objc[@"HeWeather6"][0][@"lifestyle"][0][@"brf"];
             timeModel.shenghuoStr =  objc[@"HeWeather6"][0][@"lifestyle"][0][@"txt"];
            NSLog(@"%@",objc);
             [_ditarry addObject:timeModel];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //需要在主线程执行的代码
                [_TableView reloadData];
            }];
        }
    }];
    [dataTask resume];
    
   
}
-(void)lodaTestDataTwo
{
    //设置请求地址
    NSString *str = [NSString stringWithFormat:@"http://api.k780.com/?app=weather.realtime&weaid=%@&ag=today,futureDay,lifeIndex,futureHour&appkey=44512&sign=973c58aeb3278b082b5f33da5e4ac84c&format=json",_cityStr ];
    NSURL *url = [NSURL URLWithString:str];
    //封装一个请求类
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //创建Session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil)        {
            NSDictionary* objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            HourlyModel *hourlyModel =[[HourlyModel alloc]init];
            NSLog(@"%@",objc);
            hourlyModel.picStr1 = objc[@"result"][@"futureHour"][0][@"wtNm"];
                hourlyModel.picStr2 =objc[@"result"][@"futureHour"][1][@"wtNm"];
             hourlyModel.picStr3 =objc[@"result"][@"futureHour"][2][@"wtNm"];
             hourlyModel.picStr4 = objc[@"result"][@"futureHour"][3][@"wtNm"];
             hourlyModel.picStr5 = objc[@"result"][@"futureHour"][4][@"wtNm"];
             hourlyModel.picStr6 = objc[@"result"][@"futureHour"][5][@"wtNm"];
             hourlyModel.picStr7 = objc[@"result"][@"futureHour"][6][@"wtNm"];
             hourlyModel.picStr8 =objc[@"result"][@"futureHour"][7][@"wtNm"];
             hourlyModel.picStr9 = objc[@"result"][@"futureHour"][8][@"wtNm"];
             hourlyModel.picStr10 = objc[@"result"][@"futureHour"][9][@"wtNm"];
             hourlyModel.picStr11 = objc[@"result"][@"futureHour"][10][@"wtNm"];
             hourlyModel.picStr12 =objc[@"result"][@"futureHour"][11][@"wtNm"];
             hourlyModel.picStr13 =objc[@"result"][@"futureHour"][12][@"wtNm"];
             hourlyModel.picStr14 =objc[@"result"][@"futureHour"][13][@"wtNm"];
             hourlyModel.picStr15 =objc[@"result"][@"futureHour"][14][@"wtNm"];
             hourlyModel.picStr16 =objc[@"result"][@"futureHour"][15][@"wtNm"];
             hourlyModel.picStr17 =objc[@"result"][@"futureHour"][16][@"wtNm"];
             hourlyModel.picStr18 = objc[@"result"][@"futureHour"][17][@"wtNm"];
             hourlyModel.picStr19 = objc[@"result"][@"futureHour"][18][@"wtNm"];
             hourlyModel.picStr20 = objc[@"result"][@"futureHour"][19][@"wtNm"];
             hourlyModel.picStr21 =objc[@"result"][@"futureHour"][20][@"wtNm"];
             hourlyModel.picStr22 =objc[@"result"][@"futureHour"][21][@"wtNm"];
             hourlyModel.picStr23 =objc[@"result"][@"futureHour"][22][@"wtNm"];
             hourlyModel.picStr24 =objc[@"result"][@"futureHour"][23][@"wtNm"];
            hourlyModel.timStr1 = objc[@"result"][@"futureHour"][0][@"dateYmdh"];
            hourlyModel.timStr2 =objc[@"result"][@"futureHour"][1][@"dateYmdh"];
            hourlyModel.timStr3 =objc[@"result"][@"futureHour"][2][@"dateYmdh"];
            hourlyModel.timStr4 = objc[@"result"][@"futureHour"][3][@"dateYmdh"];
            hourlyModel.timStr5 = objc[@"result"][@"futureHour"][4][@"dateYmdh"];
            hourlyModel.timStr6 = objc[@"result"][@"futureHour"][5][@"dateYmdh"];
            hourlyModel.timStr7 = objc[@"result"][@"futureHour"][6][@"dateYmdh"];
            hourlyModel.timStr8 =objc[@"result"][@"futureHour"][7][@"dateYmdh"];
            hourlyModel.timStr9 = objc[@"result"][@"futureHour"][8][@"dateYmdh"];
            hourlyModel.timStr10 = objc[@"result"][@"futureHour"][9][@"dateYmdh"];
            hourlyModel.timStr11 = objc[@"result"][@"futureHour"][10][@"dateYmdh"];
            hourlyModel.timStr12 =objc[@"result"][@"futureHour"][11][@"dateYmdh"];
            hourlyModel.timStr13 =objc[@"result"][@"futureHour"][12][@"dateYmdh"];
            hourlyModel.timStr14 =objc[@"result"][@"futureHour"][13][@"dateYmdh"];
            hourlyModel.timStr15 =objc[@"result"][@"futureHour"][14][@"dateYmdh"];
            hourlyModel.timStr16 =objc[@"result"][@"futureHour"][15][@"dateYmdh"];
            hourlyModel.timStr17 =objc[@"result"][@"futureHour"][16][@"dateYmdh"];
            hourlyModel.timStr18 = objc[@"result"][@"futureHour"][17][@"dateYmdh"];
            hourlyModel.timStr19 = objc[@"result"][@"futureHour"][18][@"dateYmdh"];
            hourlyModel.timStr20 = objc[@"result"][@"futureHour"][19][@"dateYmdh"];
            hourlyModel.timStr21 =objc[@"result"][@"futureHour"][20][@"dateYmdh"];
            hourlyModel.timStr22 =objc[@"result"][@"futureHour"][21][@"dateYmdh"];
            hourlyModel.timStr23 =objc[@"result"][@"futureHour"][22][@"dateYmdh"];
            hourlyModel.timStr24 =objc[@"result"][@"futureHour"][23][@"dateYmdh"];
            hourlyModel.temStr1 = objc[@"result"][@"futureHour"][0][@"wtTemp"];
            hourlyModel.temStr2 =objc[@"result"][@"futureHour"][1][@"wtTemp"];
            hourlyModel.temStr3 =objc[@"result"][@"futureHour"][2][@"wtTemp"];
            hourlyModel.temStr4 = objc[@"result"][@"futureHour"][3][@"wtTemp"];
            hourlyModel.temStr5 = objc[@"result"][@"futureHour"][4][@"wtTemp"];
            hourlyModel.temStr6 = objc[@"result"][@"futureHour"][5][@"wtTemp"];
            hourlyModel.temStr7 = objc[@"result"][@"futureHour"][6][@"wtTemp"];
            hourlyModel.temStr8 =objc[@"result"][@"futureHour"][7][@"wtTemp"];
            hourlyModel.temStr9 = objc[@"result"][@"futureHour"][8][@"wtTemp"];
            hourlyModel.temStr10 = objc[@"result"][@"futureHour"][9][@"wtTemp"];
            hourlyModel.temStr11 = objc[@"result"][@"futureHour"][10][@"wtTemp"];
            hourlyModel.temStr12 =objc[@"result"][@"futureHour"][11][@"wtTemp"];
            hourlyModel.temStr13 =objc[@"result"][@"futureHour"][12][@"wtTemp"];
            hourlyModel.temStr14 =objc[@"result"][@"futureHour"][13][@"wtTemp"];
            hourlyModel.temStr15 =objc[@"result"][@"futureHour"][14][@"wtTemp"];
            hourlyModel.temStr16 =objc[@"result"][@"futureHour"][15][@"wtTemp"];
            hourlyModel.temStr17 =objc[@"result"][@"futureHour"][16][@"wtTemp"];
            hourlyModel.temStr18 = objc[@"result"][@"futureHour"][17][@"wtTemp"];
            hourlyModel.temStr19 = objc[@"result"][@"futureHour"][18][@"wtTemp"];
            hourlyModel.temStr20 = objc[@"result"][@"futureHour"][19][@"wtTemp"];
            hourlyModel.temStr21 =objc[@"result"][@"futureHour"][20][@"wtTemp"];
            hourlyModel.temStr22 =objc[@"result"][@"futureHour"][21][@"wtTemp"];
            hourlyModel.temStr23 =objc[@"result"][@"futureHour"][22][@"wtTemp"];
            hourlyModel.timStr24 =objc[@"result"][@"futureHour"][23][@"wtTemp"];
            hourlyModel.timWStr1= objc[@"result"][@"futureDay"][0][@"dateYmd"];
            hourlyModel.timWStr2 =objc[@"result"][@"futureDay"][1][@"dateYmd"];
            hourlyModel.timWStr3 =objc[@"result"][@"futureDay"][2][@"dateYmd"];
            hourlyModel.timWStr4 = objc[@"result"][@"futureDay"][3][@"dateYmd"];
            hourlyModel.timWStr5 = objc[@"result"][@"futureDay"][4][@"dateYmd"];
            hourlyModel.timWStr6 = objc[@"result"][@"futureDay"][5][@"dateYmd"];
           // hourlyModel.timWStr7 = objc[@"result"][@"futureDay"][6][@"dateYmd"];
            hourlyModel.temWStr1= objc[@"result"][@"futureDay"][0][@"wtTemp1"];
            hourlyModel.temWStr2 =objc[@"result"][@"futureDay"][1][@"wtTemp1"];
            hourlyModel.temWStr3 =objc[@"result"][@"futureDay"][2][@"wtTemp1"];
            hourlyModel.temWStr4 = objc[@"result"][@"futureDay"][3][@"wtTemp1"];
            hourlyModel.temWStr5 = objc[@"result"][@"futureDay"][4][@"wtTemp1"];
            hourlyModel.temWStr6 = objc[@"result"][@"futureDay"][5][@"wtTemp1"];
         //   hourlyModel.temWStr7 = objc[@"result"][@"futureDay"][6][@"wtTemp"];
            hourlyModel.picWStr1 = objc[@"result"][@"futureDay"][0][@"wtNm1"];
            hourlyModel.picWStr2 =objc[@"result"][@"futureDay"][1][@"wtNm1"];
            hourlyModel.picWStr3 =objc[@"result"][@"futureDay"][2][@"wtNm1"];
            hourlyModel.picWStr4 = objc[@"result"][@"futureDay"][3][@"wtNm1"];
            hourlyModel.picWStr5 = objc[@"result"][@"futureDay"][4][@"wtNm1"];
            hourlyModel.picWStr6 = objc[@"result"][@"futureDay"][5][@"wtNm1"];
          //  hourlyModel.picWStr7 = objc[@"result"][@"futureDay"][6][@"wtNm"];
            
            NSLog(@"%@",hourlyModel.timStr13);
            NSLog(@"%@",hourlyModel.timStr11);
            [_dictarryHour addObject:hourlyModel];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //需要在主线程执行的代码
                [_TableView reloadData];
            }];
        }
    }];
    [dataTask resume];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    return _ditarry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* id = @"123";
    homeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (cell == nil) {
        cell = [[homeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    TimeModel *timeModel = [[TimeModel alloc]init];
    timeModel = _ditarry[indexPath.section];
        cell.labelPlace.text = timeModel.placeStr;
    cell.labelPlace.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:17];
        cell.labelTime.text =timeModel.timeStr;
    NSString * str = [NSString stringWithFormat:@"%@℃",timeModel.temStr ];
        cell.labelTemp.text = str ;
    cell.labelTemp.font = [UIFont systemFontOfSize:25];
    cell.labelTime.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:17];
    cell.tag = indexPath.section;
    cell.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.6];
    return cell;
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self clickToMore:indexPath and:_ditarry];
}
-(void)clickToMore:(NSIndexPath*)indexPath and:(NSMutableArray*)dict
{
    MoreViewController * moreViewController = [[MoreViewController alloc]init];
    moreViewController.dicty = [[NSMutableArray alloc]init];
    moreViewController.number =  indexPath.section;
    moreViewController.dicty = _ditarry;
    moreViewController.dictHour = _dictarryHour;
    [self presentViewController:moreViewController animated:YES completion:nil];
}
@end
