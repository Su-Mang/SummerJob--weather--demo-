//
//  MoreViewController.m
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreoneTableViewCell.h"
#import "HourlyModel.h"
#import "TableViewtwoCell.h"
#import "TimeModel.h"
@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
#define WIDRH self.view.frame.size.width
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _numberCount = _dicty.count;
    NSLog(@"%d",_dicty.count);
   
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,20, self.view.frame.size.width, 600)];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*(int)_numberCount, 600) ;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 600) style:UITableViewStyleGrouped];
   // [_scrollView addSubview:_tableView];
  //  [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width*(int)(_numberCount-1), 0)];
    for (int i=0; i<(int)_numberCount; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDRH*i, 0, WIDRH, 600) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tag = i;
        if (i%2==0) {
            UIImageView* imageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDRH, 600)];
            imageVIew.image =[UIImage imageNamed:@"61565781836_.pic.jpg"];
            tableView.backgroundView =imageVIew;
        }
        else{   UIImageView* imageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDRH, 600)];
            imageVIew.image =[UIImage imageNamed:@"41565781834_.pic.jpg"];
            tableView.backgroundView = imageVIew;
        }
        
        [_scrollView addSubview:tableView];
        }
    
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
    _pageControl = [[UIPageControl alloc]init];
    [_pageControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    _pageControl.numberOfPages = _numberCount;
    _pageControl.currentPage =_number;
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    _pageControl.frame = CGRectMake((self.view.frame.size.width/2-10*_pageControl.numberOfPages), 635, 12*_pageControl.numberOfPages, 10);
    [self.view addSubview:_pageControl];
    UIButton *buttonBack  = [[UIButton alloc]initWithFrame:CGRectMake(300, 615, 50, 50)];
    [self.view addSubview:buttonBack];
    [buttonBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [buttonBack setImage:[UIImage imageNamed:@"fanhui-2.png"] forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor grayColor];
    self.scrollView.contentOffset = CGPointMake((int)_number*WIDRH, 0);
    
}
-(void)back
{   NSLog(@"123");
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _scrollView.contentOffset.x/WIDRH ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    for(int i =0;i<_dicty.count;i++) {
    if(i==tableView.tag) {
        TimeModel *timeModel = [[TimeModel alloc]init];
        timeModel =  _dicty[i];
        HourlyModel *hourlyModel = [[HourlyModel alloc]init];
        hourlyModel = _dictHour[i];
        if (indexPath.section == 0) {
            static NSString* id = @"0";
            MoreoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
            if (cell == nil) {
                cell = [[MoreoneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
            }
            cell.lableLocat.text = timeModel.placeStr;
            cell.lableWeath.text = timeModel.qingStr;
            cell.lableWeath.font = cell.lableLocat.font = [UIFont fontWithName:@" CourierNewPSMT" size:15];
            cell.lableTem.font = [UIFont systemFontOfSize:40];
            cell.lableLocat.font = [UIFont systemFontOfSize:30];
            //NSLog(@"%@",timeModel.placeStr);
            NSLog(@"%@",timeModel.minStr);
            NSString * str = [NSString stringWithFormat:@"%@℃",timeModel.temStr ];
            cell.lableTem.text = str;
         cell.lableLocat.font = [UIFont fontWithName:@" CourierNewPSMT" size:30];
            cell.lableData.text = timeModel.timeStr;
            cell.lableData.font = cell.lableLocat.font = [UIFont fontWithName:@" CourierNewPSMT" size:15];
              NSString * strMax = [NSString stringWithFormat:@"%@℃",timeModel.maxTStr ];
              NSString * strMin = [NSString stringWithFormat:@"%@℃",timeModel.minStr ];
            cell.lableMaxTem.text =strMax;
            cell.lableMinTem.text =strMin;
             cell.backgroundColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
            return cell;
        }
        else  if (indexPath.section==1) {
            static NSString* id = @"1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
            
            NSMutableArray *timeData = [[NSMutableArray alloc]initWithObjects:hourlyModel.timStr1,hourlyModel.timStr2,hourlyModel.timStr3,hourlyModel.timStr4,hourlyModel.timStr5,hourlyModel.timStr6,hourlyModel.timStr7,hourlyModel.timStr8,hourlyModel.timStr9,hourlyModel.timStr10,hourlyModel.timStr11,hourlyModel.timStr12,hourlyModel.timStr13,hourlyModel.timStr14,hourlyModel.timStr15,hourlyModel.timStr16,hourlyModel.timStr17,hourlyModel.timStr18,hourlyModel.timStr19,hourlyModel.timStr20,hourlyModel.timStr21,hourlyModel.timStr22,hourlyModel.timStr23, nil];
            NSLog(@"123%@",timeData[9]);
              NSLog(@"%@",timeData[10]);
              NSMutableArray *temData = [[NSMutableArray alloc]initWithObjects:hourlyModel.temStr1,hourlyModel.temStr2,hourlyModel.temStr3,hourlyModel.temStr4,hourlyModel.temStr5,hourlyModel.temStr6,hourlyModel.temStr7,hourlyModel.temStr8,hourlyModel.temStr9,hourlyModel.temStr10,hourlyModel.temStr11,hourlyModel.temStr12,hourlyModel.temStr13,hourlyModel.temStr14,hourlyModel.temStr15,hourlyModel.temStr16,hourlyModel.temStr17,hourlyModel.temStr18,hourlyModel.temStr19,hourlyModel.temStr20,hourlyModel.temStr21,hourlyModel.temStr22,hourlyModel.temStr23, nil];
              NSMutableArray *picData = [[NSMutableArray alloc]initWithObjects:hourlyModel.picStr1,hourlyModel.picStr2,hourlyModel.picStr3,hourlyModel.picStr4,hourlyModel.picStr5,hourlyModel.picStr6,hourlyModel.picStr7,hourlyModel.picStr8,hourlyModel.picStr9,hourlyModel.picStr10,hourlyModel.picStr11,hourlyModel.picStr12,hourlyModel.picStr13,hourlyModel.picStr14,hourlyModel.picStr15,hourlyModel.picStr16,hourlyModel.picStr17,hourlyModel.picStr18,hourlyModel.picStr19,hourlyModel.picStr20,hourlyModel.picStr21,hourlyModel.picStr22,hourlyModel.picStr23, nil];
              NSMutableArray *timewData = [[NSMutableArray alloc]initWithObjects:hourlyModel.timWStr1,hourlyModel.timWStr2,hourlyModel.timWStr3,hourlyModel.timWStr4,hourlyModel.timWStr5,hourlyModel.timWStr6, nil];
              NSMutableArray *temwData = [[NSMutableArray alloc]initWithObjects:hourlyModel.temWStr1,hourlyModel.temWStr2,hourlyModel.temWStr3,hourlyModel.temWStr4,hourlyModel.temWStr5,hourlyModel.temWStr6, nil];
              NSMutableArray *picwData = [[NSMutableArray alloc]initWithObjects:hourlyModel.picWStr1,hourlyModel.picWStr2,hourlyModel.picWStr3,hourlyModel.picWStr4,hourlyModel.picWStr5,hourlyModel.picWStr6, nil];
            for (NSString*str in timeData) {
                NSLog(@"%@",str);
            }
            UIScrollView *scrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDRH, 130)];
            scrollView.contentSize = CGSizeMake(22*90, 0);
            for(int i = 0;i<23;i++)
            {
                UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10+i*85, 10, 50, 10)];
                NSString *str1 =timeData[i];
             str1 = [str1 substringToIndex:16];
                str1 = [str1 substringFromIndex:11];
                timeLabel.text = str1;
               // NSLog(@"%@",timeData[i]);
                timeLabel.font = [UIFont systemFontOfSize:13];
                [scrollView addSubview:timeLabel];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*85, 40, 50, 50)];
                NSString *pStr = [NSString stringWithFormat:@"%@.png",picData[i] ];
                imageView.image  = [UIImage imageNamed:pStr];
                
                [scrollView addSubview:imageView];
                UILabel *temLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+i*85, 100, 50, 30)];
                  NSString * strMax = [NSString stringWithFormat:@"%@℃",temData[i] ];
                temLabel.text = strMax;
                //NSLog(@"%@",temData[i]);
                [scrollView addSubview:temLabel];
            }
            
            [cell.contentView addSubview:scrollView];
            for (int j = 0; j<6; j++) {
                UILabel*dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 150+j*40, 130, 30)];
                dataLabel.text = timewData[j];
                [cell.contentView addSubview:dataLabel];
                UIImageView *picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(180, 150+j*40, 30, 30)];
                NSString *pStr = [NSString stringWithFormat:@"%@.png",picwData[j] ];
              
               picImageView.image  = [UIImage imageNamed:pStr];
                [cell.contentView addSubview:picImageView];
                UILabel *temLabel = [[UILabel alloc]initWithFrame:CGRectMake(275, 150+j*40, 100, 30)];
                NSString * strMax = [NSString stringWithFormat:@"%@℃",temwData[j] ];
                temLabel.text = strMax;
                [cell.contentView addSubview:temLabel];
            }
            }
            cell.backgroundColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
            return cell;
        }
        else  if(indexPath.section==2){
            static NSString* id = @"2";
            UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:id];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
            
            NSString *strdatMax = [NSString stringWithFormat:@"最高温度：%@℃",timeModel.forstomStrmax ];
             NSString *strdatMin = [NSString stringWithFormat:@"最低温度：%@℃",timeModel.forstomStrmin ];
            UILabel *lableTomdata = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200,  20)];
            lableTomdata.text = @"明天";
            UILabel *lablemax =[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 100,  20)];
            lablemax.font = [UIFont systemFontOfSize:13];
            lablemax.text = strdatMax;
              UILabel *lablemin =[[UILabel alloc]initWithFrame:CGRectMake(130, 40, 100,  20)];
            lablemin.font =  [UIFont systemFontOfSize:13];
            lablemin.text = strdatMin;
            [cell.contentView addSubview:lablemin];
            [cell.contentView addSubview:lablemax];
            [cell.contentView addSubview:lableTomdata];
            }
            cell.backgroundColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
            return cell;
            
        }
          else  if(indexPath.section==3){
              static NSString* id = @"2";
              UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:id];
              if (cell == nil) {
             
                  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
              
              NSString *strdatMax = [NSString stringWithFormat:@"最高温度：%@℃",timeModel.forthemaxStr ];
              NSString *strdatMin = [NSString stringWithFormat:@"最低温度：%@℃",timeModel.fortheminStr ];
              UILabel *lableTomdata = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200,  20)];
              lableTomdata.text = @"后天";
              UILabel *lablemax =[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 100,  20)];
               lablemax.font = [UIFont systemFontOfSize:13];
              lablemax.text = strdatMax;
              UILabel *lablemin =[[UILabel alloc]initWithFrame:CGRectMake(130, 40, 100,  20)];
                 lablemin.font = [UIFont systemFontOfSize:13];
              lablemin.text = strdatMin;
              [cell.contentView addSubview:lablemin];
                 [cell.contentView addSubview:lablemax];
                 [cell.contentView addSubview:lableTomdata];
              }
              cell.alpha = 0.6;
              cell.backgroundColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
              return cell;
          }
        else
        {
            static NSString* id = @"4";
            NSArray* arry =@[@"",@"",@"",@"日出",@"日落",@"降雨概率",@"湿度",@"风速",@"相对湿度",@"降雨量",@"气压",@"能见度",@"紫外线指数",@"空气质量",@"生活指数"];
            NSString *str1 = [NSString stringWithFormat:@"%@%%",timeModel.jiangyuStr];
              NSString *str2 = [NSString stringWithFormat:@"%@%%",timeModel.shiduStr];
            NSString *str3 = [NSString stringWithFormat:@"%@m/s",timeModel.fengsuStr];
              NSString *str4 = [NSString stringWithFormat:@"%@m/s",timeModel.fengsuStr];
             NSString *str5 = [NSString stringWithFormat:@"%@%%",timeModel.tiganStr];
             NSString *str6 = [NSString stringWithFormat:@"%@mm",timeModel.jiangshuiStr];
             NSString *str7 = [NSString stringWithFormat:@"%@   百帕",timeModel.qiyaStr];
             NSString *str8 = [NSString stringWithFormat:@"%@   能见度",timeModel.nengjianduStr];
            NSMutableArray * arry1 =[[NSMutableArray alloc]initWithObjects:timeModel.richuStr,timeModel.richuStr,timeModel.richuStr,timeModel.richuStr,timeModel.riluoStr ,str1,str2,str3,str5,str6,str7,str8,timeModel.ziwaixianStr,timeModel.kongqizhiliangStr,timeModel.shenghuoStr,nil];
            TableViewtwoCell *cell = [tableView dequeueReusableCellWithIdentifier:id];;
            if (cell == nil) {
                cell = [[TableViewtwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
            }
            if(indexPath.section == 14)
            {
                cell.lableDes.font = [UIFont systemFontOfSize:13];
                cell.lableDes.numberOfLines = 0;
            }
            cell.lableData.text = arry[indexPath.section];
            cell.lableDes.text = arry1[indexPath.section];
            cell.backgroundColor  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
            return cell;
        }
    }
}
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}



   
-(void)change:(UIPageControl*)pageControl
{
    [_scrollView setContentOffset:CGPointMake(WIDRH*(pageControl.currentPage-1), 0) animated:YES];
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
    if (indexPath.section == 0) {
        return 245;
    }
    else if (indexPath.section == 1) {
        return 400;
    }
    else if (indexPath.section==2) {
        return 60;
    }
    else
    {
        return 70;
    }
}


@end
