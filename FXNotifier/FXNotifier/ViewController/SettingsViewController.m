//
//  SettingsViewController.m
//  FXNotifier
//
//  Created by RashOosh on 2/7/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "SettingsViewController.h"
#import  "SettingsCell.h"
#import "Setting.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingsCell" bundle:Nil] forCellReuseIdentifier:@"Cell"];
    
    [self initTableView];
    
}
-(void)initTableView
{
    dicKeys=[[NSMutableDictionary  alloc] init];

    Setting *setting1=[[Setting alloc] initSetting:1 title:@"لغة التطبيق" detailTitle:@"عربي" checked:NO];
    Setting *setting2=[[Setting alloc] initSetting:1 title:@"النطاق الزمني" detailTitle:@"GMT" checked:NO];
    Setting *setting3=[[Setting alloc] initSetting:1 title:@"أيقونة الحالة" detailTitle:@"أيقونة التطبيق لن تظهر في الشريط العلوي" checked:NO];
    Setting *setting4=[[Setting alloc] initSetting:1 title:@"إلغاء قفل الشاشة" detailTitle:@"" checked:NO];
    Setting *setting5=[[Setting alloc] initSetting:1 title:@"الإهتزاز" detailTitle:@"" checked:NO];
    NSMutableArray *List1=[[NSMutableArray alloc] initWithObjects:setting1,setting2,setting3,setting4,setting5, nil];
    
    Setting *setting6=[[Setting alloc] initSetting:1 title:@"تذكير" detailTitle:@"مفعل" checked:NO];
    Setting *setting7=[[Setting alloc] initSetting:1 title:@"التذكير قبل" detailTitle:@"1:00" checked:NO];
    Setting *setting8=[[Setting alloc] initSetting:1 title:@"التذكير بعد" detailTitle:@"2:30" checked:NO];
    Setting *setting9=[[Setting alloc] initSetting:1 title:@"التنبيه على الحدث" detailTitle:@"" checked:NO];
    Setting *setting10=[[Setting alloc] initSetting:1 title:@"تعطيل استقبال التنبهات" detailTitle:@"" checked:NO];
    
     NSMutableArray *List2=[[NSMutableArray alloc] initWithObjects:setting6,setting7,setting8,setting9,setting10, nil];
    
    Setting *setting11=[[Setting alloc] initSetting:1 title:@"التنبيبه عند استقبال خبر جديد" detailTitle:@"" checked:NO];
    Setting *setting12=[[Setting alloc] initSetting:1 title:@"نغمة تنبيه الخبر" detailTitle:@"" checked:NO];
    
     NSMutableArray *List3=[[NSMutableArray alloc] initWithObjects:setting11,setting12, nil];
    [dicKeys setObject:List1 forKey:@"إعدادات عامة" ];
    [dicKeys setObject:List2 forKey:@"إعدادات الأجندة" ];
    [dicKeys setObject:List3 forKey:@"إعدادات الأخبار" ];
    
    AllKeys=[dicKeys allKeys];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    NSString *Key=[AllKeys objectAtIndex:indexPath.section];
    
    NSMutableArray *list=[dicKeys objectForKey:Key];
     Setting *setting=[list objectAtIndex:indexPath.row];
    
    
    SettingsCell *cell = ( SettingsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[ SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.lbl_Title.text=setting.title;
    cell.lbl_Details.text=setting.detailTitle;
    if(setting.checked)
        cell.img_checked.image=[UIImage imageNamed:@"Checked.png"];
    else
         cell.img_checked.image=[UIImage imageNamed:@"unchecked.png"];
        
    
    return cell;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1;
//}
#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //If this is the selected index we need to return the height of the cell
    //in relation to the label height otherwise we just return the minimum label height with padding
    return 60;
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSDictionary *d=[historyDictionary objectAtIndex:section];
    NSString *Key=[AllKeys objectAtIndex:section];
    
    NSMutableArray *list=[dicKeys objectForKey:Key];
    return list.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //
    //    NewsViewController *newview=[[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
    //
    //    [self.view_News addSubview:[newview.view retain]];
    //    //The user is selecting the cell which is currently expanded
    //we want to minimize it back
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dicKeys.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray *ALLKeys=[dicKeys allKeys];
    
    // imageView.image=[UIImage imageNamed:@"BackgroundSection.png"];
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(60,8, 200, 17)];
    
    
    label.text=[ALLKeys objectAtIndex:section];
    label.backgroundColor=[UIColor clearColor];
    //
    //
    [label setFont:[UIFont fontWithName:@"System" size:3]];
    [label setTextColor:[UIColor  whiteColor]];
    //
    // [imageView addSubview:label];
    //
    label.textAlignment=NSTextAlignmentCenter;
    
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerView.tag                  = section;
    headerView.backgroundColor      = [UIColor blackColor];
    
    [headerView addSubview:label];
    return headerView;
}
-(IBAction)GoBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
