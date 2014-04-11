//
//  SubMainViewController.m
//  FXNotifier
//
//  Created by RashOosh on 2/1/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "SubMainViewController.h"
#import "MarketCell.h"
#import "EventItem.h"
#import "MBProgressHUD2.h"
#import "MainViewController.h"
#define COMMENT_LABEL_WIDTH 230
static NSUInteger kNumberOfDates = 12;

@interface SubMainViewController ()

@end

@implementation SubMainViewController
@synthesize manager,ListEvents,ListDates,CurrentIndex,delegate;
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
    [self.tableView registerNib:[UINib nibWithNibName:@"MarketCell" bundle:Nil] forCellReuseIdentifier:@"Cell"];
    
     manager=[[Manager alloc] init];
    selectedIndex = -1;
    
   
    //set set our selected Index to -1 to indicate no cell will be expanded
    [self.tableView reloadData];
   // self.tableView.tableHeaderView.hidden = YES;
   // ListFeeds=[[NSMutableArray alloc] init];
   // [self DidFinishLoadEvents];
   // [self GetEvents];
   
}
-(void)viewWillAppear:(BOOL)animated
{
     selectedIndex = -1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id)initWithPageNumber:(int)page {
    
        if (self = [super initWithNibName:@"SubMainViewController" bundle:nil]) {
            pageNumber = page;
        }
  
    return self;
}
#pragma mark - UITableViewDataSource Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString *CellIdentifier = @"Cell";
    

    
    MarketCell *cell = (MarketCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[MarketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   // cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"CellBack.png"]];
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellBack.png"]];
//    
//    imgView.frame=CGRectMake(0, 0, 320, cell.bounds.size.height);
//    imgView.contentMode = UIViewContentModeScaleToFill;
//    [cell addSubview:imgView];
    //[cell sendSubviewToBack:imgView];
//cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"CellBack.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:10.0] ];
    EventItem *eventitem=[ListEvents objectAtIndex:indexPath.row];
    if(selectedIndex == indexPath.row)
    {
         cell.lbl_Details.hidden=NO;
        CGFloat labelHeight = [self getLabelHeightForIndex:indexPath.row];
        //cell.lbl_Details=[[UILabel alloc] initWithFrame: ];

        
        
        cell.lbl_Details.frame=CGRectMake(74,
                                          63,
                                          cell.lbl_Details.frame.size.width,
                                          labelHeight);
        
       cell.lbl_Details.font = [UIFont fontWithName:@"Helvetica" size:12.0f];
        cell.lbl_Details.text = eventitem.HTMLDescriptionAr;
        cell.lbl_Details.lineBreakMode=NSLineBreakByWordWrapping;
        cell.lbl_Details.textAlignment=NSTextAlignmentRight;
        cell.lbl_Details.numberOfLines=6;
        cell.lbl_Details.tag=100;
       // [cell addSubview:cell.lbl_Details];
    }
    else {
        
        //Otherwise just return the minimum height for the label.
       // UILabel *detail=(UILabel *)[cell viewWithTag:100];
      cell.lbl_Details.hidden=YES;
    //[detail removeFromSuperview];
    }
    
    cell.lbl_Title.text=eventitem.NameAr;
    cell.lbl_Current.text=eventitem.DisplayActual;
    cell.lbl_Previous.text=eventitem.DisplayPrevious;
    cell.lbl_Next.text=eventitem.DisplayConsensus;
    NSString *date=[self FormatDateToForm1 :eventitem.DateTime];
    cell.lbl_Time.text=date;
    cell.lbl_unit.text=eventitem.Currency;
    NSString *imageFlag=[NSString stringWithFormat:@"%@.png",[[eventitem.InternationalCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString]];
    cell.imgview.image=[UIImage imageNamed:imageFlag];
    cell.lblDate.text=eventitem.DateTime;
    if(eventitem.Volatility==0)
        cell.img_important.backgroundColor=[UIColor clearColor];
    if(eventitem.Volatility==1)
        cell.img_important.backgroundColor=[UIColor yellowColor];
    if(eventitem.Volatility==2)
        cell.img_important.backgroundColor=[UIColor orangeColor];
    if(eventitem.Volatility==3)
        cell.img_important.backgroundColor=[UIColor redColor];
   
       return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1;
//}
#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        //If this is the selected index we need to return the height of the cell
        //in relation to the label height otherwise we just return the minimum label height with padding
        if(selectedIndex == indexPath.row)
        {
            return [self getLabelHeightForIndex:indexPath.row] + 135;
        }
        else {
            return 135 ;
        }
   

    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSDictionary *d=[historyDictionary objectAtIndex:section];
    
    return ListEvents.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //The user is selecting the cell which is currently expanded
    //we want to minimize it back
    if(selectedIndex == indexPath.row)
    {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        return;
    }
    
    //First we check if a cell is already expanded.
    //If it is we want to minimize make sure it is reloaded to minimize it back
    if(selectedIndex >= 0)
    {
        NSIndexPath *previousPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:previousPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    //Finally set the selected index to the new selection and reload it to expand
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


-(CGFloat)getLabelHeightForIndex:(NSInteger)index
{
    CGSize maximumSize = CGSizeMake(210, 10000);
    
    CGSize labelHeighSize = [@"نتنتب تيابتبالتيبال تيالتنيبالتالتيبال ايبلتابتيالت سهعهخقثعلاىةلاح  ثعلاىيلاي حخععععحخ" sizeWithFont: [UIFont fontWithName:@"Helvetica" size:14.0f]
                                                        constrainedToSize:maximumSize
                                                                                                                       lineBreakMode:NSLineBreakByWordWrapping];
    return labelHeighSize.height+30;
    
}

#pragma HelpFuns
-(NSString *)FormatDateToForm1 :(NSString *)date
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd HH:mm:ss";
    NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"HH:mm";
    return [ dateFormatter stringFromDate:yourDate];
}
-(NSString *)FormatDateToForm2 :(NSString *)date
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd HH:mm:ss";
    NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"dd/MMM/yyyy";
    return [ dateFormatter stringFromDate:yourDate];
}
-(NSString *)FormatDateToForm3 :(NSDate *)date
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"yyyyMMdd HH:mm:ss";
//    NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return [ dateFormatter stringFromDate:date];
}

-(BOOL)FindDateInlist:(NSMutableArray *)DateLists Date:(NSString *)date
{
    for(int i=0;i<DateLists.count;i++)
    {
        NSString *temp=[DateLists objectAtIndex:i];
        if([temp isEqualToString:date])
            return TRUE;
    }
    return FALSE;
}

#pragma HelpFunc
-(NSString *)AddDayToDate:(NSString *)date :(int)countday
{
   
    
    // How much day to add
    
    
    // Creating and configuring date formatter instance
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    // Retrieve NSDate instance from stringified date presentation
    NSDate *dateFromString = [dateFormatter dateFromString:date];
    
    // Create and initialize date component instance
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:countday];
    
    // Retrieve date with increased days count
    NSDate *newDate = [[NSCalendar currentCalendar]
                       dateByAddingComponents:dateComponents
                       toDate:dateFromString options:0];
    
    NSLog(@"Original date: %@", [dateFormatter stringFromDate:dateFromString]);
    NSLog(@"New date: %@", [dateFormatter stringFromDate:newDate]);
    return [dateFormatter stringFromDate:newDate];
    // Clean up
    
}

@end
