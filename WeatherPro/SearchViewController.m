//
//  SearchViewController.m
//  WeatherPro
//
//  Created by 岳靖翔 on 2019/8/12.
//  Copyright © 2019 岳靖翔. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "TimeModel.h"
@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)NSString *searchStr;
@property (nonatomic,strong)UITableView *tableView;
@property NSMutableArray *arryCity;
@property (nonatomic,copy)  NSString *temp;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *iamgeView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    iamgeView.image = [UIImage imageNamed:@"71565781838_.pic.jpg"];
    [self.view addSubview:iamgeView];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    imageView.backgroundColor = [UIColor blackColor];
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, 295, 40)];
    _textField.placeholder = @"请输入省市区";
    UIButton *cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(324, 30, 25, 25)];
    UIImageView *imageViewLeft = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 20, 20)];
    imageViewLeft.image = [UIImage imageNamed:@"sousuo-3.png"];
    _textField.leftView = imageViewLeft;
    _textField.leftViewMode = UITextFieldViewModeAlways ;
    _textField.backgroundColor = [UIColor grayColor];
    imageView.backgroundColor = [UIColor whiteColor];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:imageView];
    [self.view addSubview:_textField];
    [self.view addSubview:cancleButton];
    [cancleButton setImage:[UIImage imageNamed:@"quxiao.png"] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeySearch;
    [self.textField addTarget:self action:@selector(search) forControlEvents:UIControlEventEditingDidEnd];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 500) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_textField addTarget:self action:@selector(change) forControlEvents:UIControlEventEditingChanged];
    _tableView.alpha = 0.5;
    
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return _arryCity.count;
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* id = @"123";
   SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id];
    if (cell == nil) {
        cell = [[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:id];
    }
    cell.lableLocat.text = _arryCity[indexPath.section];
    cell.alpha = 0.6;
    cell.lableLocat.font = [UIFont fontWithName:@" CourierNewPSMT" size:17];
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
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{ _textField.text =_arryCity[indexPath.section];    
    NSMutableString *mutableString = [NSMutableString stringWithString:_textField.text];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    NSString *str = [mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""];
    _temp = nil;
   _temp= [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",_temp);
   
    if( [self searchCc:(_textField.text)]){
        
        NSLog(@"%@",_temp);
    [self.delegate passDelegate:_temp];
    }
    else{
        
    }
  
   
}
-(void)change
{
    
    [self lodaTestData];

}
-(void)lodaTestData
{
    //设置请求地址
    NSMutableString *mutableString = [NSMutableString stringWithString:_textField.text];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    NSString *str = [mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""];
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *str1 = [NSString stringWithFormat:@"https://search.heweather.net/find?location=%@&key=d046363859344a96bfe52b83415dd17b",temp ];
    NSURL *url = [NSURL URLWithString:str1];
    //封装一个请求类
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    //创建Session
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil)        {
            NSDictionary* objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
          //  NSLog(@"%@",objc);
             _arryCity = [[NSMutableArray alloc]init];
            for (id str in objc[@"HeWeather6"][0][@"basic"]) {
               NSString *str1 = str[@"location"];
                [_arryCity addObject:str1];
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                //需要在主线程执行的代码
                [_tableView reloadData];
            }];
        }
    }];
    [dataTask resume];
}
-(BOOL)searchCc:(NSString*)str
{
    int t=0;
    for (int i =0; i<_arryCc.count; i++) {
        TimeModel *timeMode = [[TimeModel alloc]init];
       timeMode = _arryCc[i];
        if([timeMode.placeStr isEqualToString:str] )
            {
                t=1;
            }
    }
    if(t==0)
    {
    [self dismissViewControllerAnimated:YES completion:nil];
        return YES;
    }
    else{
        // _temp = nil;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"老哥衷心提示" message:@"该城市已经添加" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"你凶凶" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            _textField.text =@"";
           
        }];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:nil];
        return false;
    }
    }
    

-(void)search
{
  
    [_textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{       if(string!=nil){
    [self lodaTestData];
}
    return YES;
}
-(void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}

@end
