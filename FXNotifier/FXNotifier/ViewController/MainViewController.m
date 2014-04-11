 //
//  MainViewController.m
//  Dalilak
//
//  Created by RashOosh on 1/21/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "MainViewController.h"
#import "SubMainViewController.h"
#import "NewsViewController.h"
#import "NewsCell.h"
#import "MBProgressHUD2.h"
#import "SettingsViewController.h"
#import  "SearchViewController.h"
#import "FilterViewController.h"
#import "ContactUsViewController.h"
#import "FileDbAdapter.h"

 NSUInteger kNumberOfPages;
@interface MainViewController () <UIScrollViewDelegate>
{
NetworkStatus networkStatus ;

Reachability *networkReachability;
}
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;
@end

@implementation MainViewController

@synthesize scrollView, viewControllers,pageControl,imgBottom_AboutApp,imgBottom_Details,imgBottom_News,lbl_Details,lbl_News,lblABoutApp,view_Aboutapp,view_Market,view_News,scrollView_News,viewControllers_News;
@synthesize tableView_News,pullUpView,pullUpLabel,manager,ListFeeds,DicNews,ListEvents,ListDates,AfterToday,currentDate,currentIndex,scrl_Dates;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)initsomecontrollers
{
    for (UIView *subview in scrollView.subviews) {
        [subview removeFromSuperview];
    }
    
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < ListDates.count; i++) {
        [controllers addObject:[NSNull null]];
    }
    
    self.viewControllers = controllers;
    
    [scrollView setContentOffset: CGPointMake(scrollView.frame.size.width*currentIndex, 0)];
    [self loadScrollViewWithPage:currentIndex];
    [self loadScrollViewWithPage:currentIndex+1];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
     //test
   // manager=[[Manager alloc] init];
    ListFeeds=[[NSMutableArray alloc] init];
   // [self GetEvents];
    
   // [self GetFeeds];
//    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
//    [fd openDB];
//    NSMutableArray *feed = [fd fetchfeedByID:3];
    //finisgtest
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
     networkReachability = [Reachability reachabilityForInternetConnection];
    
    scrollView.userInteractionEnabled=YES;
    // Do any additional setup after loading the view from its nib.
  	
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * ListDates.count, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    
    scrollView.delegate = self;
	
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    
    
    view_News.hidden=YES;
    view_Aboutapp.hidden=YES
    
    
    ;
    view_Market.hidden=NO;
    
    [self.tableView_News registerNib:[UINib nibWithNibName:@"NewsCell" bundle:Nil] forCellReuseIdentifier:@"Cell"];
     CGFloat xOffset = 0;
   
    pullUpView = [[StyledPullableView alloc] initWithFrame:CGRectMake(xOffset, 0, 320, 460)];
    pullUpView.openedCenter = CGPointMake(160 + xOffset,self.view.frame.size.height + 50);
    pullUpView.closedCenter = CGPointMake(160 + xOffset, self.view.frame.size.height + 210);
    pullUpView.center = pullUpView.closedCenter;
    pullUpView.handleView.frame = CGRectMake(0, 0, 320, 40);
    pullUpView.delegate = self;
    
    [self.view addSubview:pullUpView];
   
    pullUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 320, 20)];
    pullUpLabel.textAlignment = NSTextAlignmentCenter;
    
    pullUpLabel.backgroundColor = [UIColor clearColor];
    pullUpLabel.textColor = [UIColor colorWithRed:141.0f/255.0f green:133.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
    pullUpLabel.shadowColor = [UIColor blackColor];
    pullUpLabel.font = [UIFont systemFontOfSize:8];
    pullUpLabel.text = @"الإعدادات";
    
    [pullUpView addSubview:pullUpLabel];
  
    UIButton *btn_Settings = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Settings.frame = CGRectMake(10, 20, 140, 60); // position in the parent view and set the size of the
    [btn_Settings setTitle:@"الإعدادات" forState:UIControlStateNormal];
    btn_Settings.titleLabel.textAlignment=NSTextAlignmentCenter;
    btn_Settings.titleLabel.textColor=[UIColor whiteColor];
    
    
   // btn_Settings.backgroundColor=[UIColor redColor];
    [btn_Settings addTarget:self action:@selector(GoToSettings) forControlEvents:UIControlEventTouchUpInside];
    [pullUpView insertSubview:btn_Settings atIndex:1];
    
    UIButton *btn_Filter = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Filter.frame = CGRectMake(170, 20, 140, 60); // position in the parent view and set the size of the
     [btn_Filter setTitle:@"التصفية" forState:UIControlStateNormal];
       btn_Filter.titleLabel.textAlignment=NSTextAlignmentCenter;
    btn_Filter.titleLabel.textColor=[UIColor whiteColor];

    
    
    btn_Filter.backgroundColor=[UIColor clearColor];
    [btn_Filter addTarget:self action:@selector(GoToFilter) forControlEvents:UIControlEventTouchUpInside];
    [pullUpView addSubview:btn_Filter];
    
    UIButton *btn_Search = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Search.frame = CGRectMake(10, 100, 140, 60); // position in the parent view and set the size of the
    [btn_Search setTitle:@"البحث" forState:UIControlStateNormal];
    
    btn_Search.titleLabel.textAlignment=NSTextAlignmentCenter;
    btn_Search.titleLabel.textColor=[UIColor whiteColor];

    
    btn_Search.backgroundColor=[UIColor clearColor];
    [btn_Search addTarget:self action:@selector(GoToSearch) forControlEvents:UIControlEventTouchUpInside];
    [pullUpView addSubview:btn_Search];

    
    UIButton *btn_Moveto = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_Moveto.frame = CGRectMake(170, 100, 140, 60); // position in the parent view and set the size of the
    [btn_Moveto setTitle:@"انتقل إلى" forState:UIControlStateNormal];
   // btn_Moveto.titleLabel.text=@"انتقل إلى";
    btn_Moveto.titleLabel.textAlignment=NSTextAlignmentCenter;
    btn_Moveto.titleLabel.textColor=[UIColor whiteColor];
    
    btn_Moveto.backgroundColor=[UIColor clearColor];
    [btn_Moveto addTarget:self action:@selector(GoToMoveto) forControlEvents:UIControlEventTouchUpInside];
    [pullUpView addSubview:btn_Moveto];
    
    kNumberOfPages=ListDates.count;
    [self GoToMainDetailView];

}
-(BOOL)Refresh
{
    NSUserDefaults *Default= [NSUserDefaults standardUserDefaults];
    NSDate *today=[NSDate date];
   // NSString *tday_str=[self FormatDateToForm3:today];
    
    NSDate *CurrentDefault= [Default objectForKey:@"LastRefresh"];
    
    CurrentDefault=[self dateWithOutTime:CurrentDefault];
    today=[self dateWithOutTime:today];
    if(!CurrentDefault)
        return YES;
    
    if([today compare: CurrentDefault] == NSOrderedDescending) // if start is later in time than end
    {
        // do something
        return YES;
    }
    return NO;

}
-(BOOL)RefreshFeeds
{
    NSUserDefaults *Default= [NSUserDefaults standardUserDefaults];
    NSDate *today=[NSDate date];
    // NSString *tday_str=[self FormatDateToForm3:today];
    
    NSDate *CurrentDefault= [Default objectForKey:@"LastRefreshFeeds"];
    
    CurrentDefault=[self dateWithOutTime:CurrentDefault];
    today=[self dateWithOutTime:today];
    if(!CurrentDefault)
        return YES;
    
    if([today compare: CurrentDefault] == NSOrderedDescending) // if start is later in time than end
    {
        // do something
        return YES;
    }
    return NO;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
    
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    currentIndex=page;
    UIButton *sender_btn;
    for (UIButton *subview in scrl_Dates.subviews) {
        [subview setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [subview setBackgroundColor:[UIColor clearColor]];
        if(page==subview.tag)
            sender_btn=subview;
    }
    CGRect frame = sender_btn.frame;
    frame.origin.x = 130 *page;
    frame.origin.y = 0;
   // currentIndex=page;
    
    // btn_Settings.backgroundColor=[UIColor redColor];
    
    self.scrl_Dates.contentSize = CGSizeMake(130*ListDates.count, self.scrl_Dates.frame.size.height);
    [self.scrl_Dates scrollRectToVisible:frame animated:YES];
    
    
    [sender_btn setBackgroundImage:[UIImage imageNamed:@"changedate.png"] forState:UIControlStateNormal];
    

    
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}
-(void)viewDidDisappear:(BOOL)animated
{
     [MBProgressHUD2 hideHUDForView:view_News animated:YES];
    [manager StopConnection];
}
// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (void)changePage:(int)page {
   // int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    currentIndex=page;
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= ListDates.count) return;
    
    NSString *datecurrentpage=[self FormatDateToForm4:[ListDates objectAtIndex:page]];
    ListEvents= [manager GetEvents:datecurrentpage];
    // replace the placeholder if necessary
   
    
    SubMainViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[SubMainViewController alloc] initWithPageNumber:page];
        controller.delegate=self;
        controller.ListEvents=ListEvents;
        controller.ListDates=ListDates;
        controller.CurrentIndex=page;
        [viewControllers replaceObjectAtIndex:page withObject:controller];
       
    }
//	 controller.CurrentIndex=page;
//     controller.ListDates=ListDates;
//    controller.ListEvents=ListEvents;
    // add the controller's view to the scroll view
    if(ListEvents)
    {
        if(ListEvents.count!=0)
        {
            if (nil == controller.view.superview) {
                
                CGRect frame = scrollView.frame;
                frame.origin.x = frame.size.width * page;
                frame.origin.y = 0;
                controller.view.frame = frame;
                [scrollView addSubview:controller.view];
                //  [scrollView_News addSubview:controller.view];
                
            }
            else
            {
//                [controller.view removeFromSuperview];
//                
//                CGRect frame = scrollView.frame;
//                frame.origin.x = frame.size.width * page;
//                frame.origin.y = 0;
//                controller.view.frame = frame;
//                [scrollView addSubview:controller.view];
            }
 
        }
    }
  }
- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma TopBar

- (IBAction)GoToMainDetailView
{
    UIView *subview=[self
                     getSubViewInViewWithTag:view_News withTag:200];
    if(subview)
        [subview removeFromSuperview];
    AfterToday=FALSE;
    
  //  [MBProgressHUD2 showHUDAddedTo:view_Market animated:YES];
    
    view_News.hidden=YES;
    view_Aboutapp.hidden=YES;
    view_Market.hidden=NO;
    
    imgBottom_Details.hidden=NO;
    imgBottom_News.hidden=YES;
    imgBottom_AboutApp.hidden=YES;
    
    lbl_Details.textColor=[UIColor whiteColor];
    lbl_News.textColor=[UIColor grayColor];
    lblABoutApp.textColor=[UIColor grayColor];

    
    
    [manager StopConnection];
    if([self Refresh])
        [self GetEvents];
    else
    [self GetEventsOffline];
    
}
- (IBAction)GoTNewsView
{
    
    
       // [self presentViewController:newview animated:YES completion:nil]ك
    view_News.hidden=NO;
    view_Aboutapp.hidden=YES;
    view_Market.hidden=YES;
    
    imgBottom_Details.hidden=YES;
    imgBottom_News.hidden=NO;
    imgBottom_AboutApp.hidden=YES;
    
    lbl_Details.textColor=[UIColor grayColor];
    lbl_News.textColor=[UIColor whiteColor];
    lblABoutApp.textColor=[UIColor grayColor];
     [manager StopConnection];
    
    if([self RefreshFeeds])
    [self GetFeeds];
    else
       [self GetFeedsOffline];
    
}
- (IBAction)GoToAboutApp
{
    UIView *subview=[self
                     getSubViewInViewWithTag:view_News withTag:200];
    if(subview)
        [subview removeFromSuperview];
    view_News.hidden=YES;
    view_Aboutapp.hidden=NO;
    view_Market.hidden=YES;
    
    
    imgBottom_Details.hidden=YES;
    imgBottom_News.hidden=YES;
    imgBottom_AboutApp.hidden=NO;
    
    lbl_Details.textColor=[UIColor grayColor];
    lbl_News.textColor=[UIColor grayColor];
    lblABoutApp.textColor=[UIColor whiteColor];
    
    [MBProgressHUD2 hideHUDForView:view_News animated:YES];
   // [manager StopConnection];
}


#pragma mark - UITableViewDataSource Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    
    
    NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *key=[[DicNews allKeys] objectAtIndex:indexPath.section];
    NSMutableArray *ListFeeds_=[DicNews objectForKey:key];
    FeedItem *feeditem=[ListFeeds_ objectAtIndex:indexPath.row];
    cell.lbl_Date.text=feeditem.DATETIME;
    
    cell.lbl_title.text=feeditem.FEEDTITLE;
    cell.lbl_Details.text=feeditem.TITLE;
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
    return 90;
    
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSDictionary *d=[historyDictionary objectAtIndex:section];
    NSString *key=[[DicNews allKeys] objectAtIndex:section];
    NSMutableArray *ListFeeds_=[DicNews objectForKey:key];
    return ListFeeds_.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < 1; i++) {
        [controllers addObject:[NSNull null]];
    }
    
    self.viewControllers_News = controllers;

    NewsViewController *controller = [viewControllers_News objectAtIndex:0];
   
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
        [viewControllers_News replaceObjectAtIndex:0 withObject:controller];
        
    }
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        NSString *key=[[DicNews allKeys] objectAtIndex:indexPath.section];
        NSMutableArray *ListFeeds_=[DicNews objectForKey:key];
        FeedItem *feeditem=[ListFeeds_ objectAtIndex:indexPath.row];

        
        CGRect frame = self.view_News.frame;
        frame.origin.x = frame.size.width * 0;
        frame.origin.y = 0;
        frame.size.height=445;
        controller.view.frame = frame;
        controller.feeditem=feeditem;
        controller.view.tag=200;
        
        [self.view_News addSubview:controller.view];
        //  [scrollView_News addSubview:controller.view];
        
    }
    
    
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
    return DicNews.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    // imageView.image=[UIImage imageNamed:@"BackgroundSection.png"];
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(40,8, 200, 17)];
    NSString *date=[[DicNews allKeys] objectAtIndex:section];
    
    label.text=date;
    label.backgroundColor=[UIColor clearColor];
    //
    //
    [label setFont:[UIFont fontWithName:@"System" size:3]];
    [label setTextColor:[UIColor  blackColor]];
    //
    // [imageView addSubview:label];
    //
    label.textAlignment=NSTextAlignmentCenter;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerView.backgroundColor=[UIColor clearColor];
    UIImageView *headerView_img              = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    headerView_img.image=[UIImage imageNamed:@"SectionNews.png"];
    [headerView addSubview:headerView_img];
    
    headerView.tag = section;
    
   
    [headerView_img addSubview:label];
    return headerView;
}

#pragma PullUp
- (void)pullableView:(PullableView *)pView didChangeState:(BOOL)opened {
    if (opened) {
        pullUpLabel.text = @"الرجاء الاختيار";
    } else {
        pullUpLabel.text = @"الإعدادات";
    }
}
-(void)GoToSettings
{
    
    SettingsViewController *settingview=[[SettingsViewController alloc] initWithNibName:
                                         @"SettingsViewController" bundle:nil];
    [self presentViewController:settingview animated:YES completion:nil];
    
}
-(void)GoToMoveto
{
    [self openDateSelectionController:nil];
}
-(void)GoToSearch
{
    SearchViewController *searchview=[[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
    [self presentViewController:searchview animated:YES completion:nil];
}
-(void)GoToFilter
{
    FilterViewController *filterview=[[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
    filterview.delegate=self;
    [self presentViewController:filterview animated:YES completion:nil];
    
}
#pragma AboutApp
-(IBAction)ContactUs:(id)sender
{
    ContactUsViewController *contactusview=[[ContactUsViewController alloc] initWithNibName:@"ContactUsViewController" bundle:nil];
    [self presentViewController:contactusview animated:YES completion:nil];
    
}


#pragma getfeeds
-(void)GetFeeds
{
    [MBProgressHUD2 showHUDAddedTo:view_News animated:YES];
    manager=[[Manager alloc] init];
    
     manager.delegate=self;
   [manager requestFeeds];
   
    
    
    
}
-(void)GetFeedsOffline
{
    [self InitListFeeds];
    [self.tableView_News reloadData];

    
}
#pragma Helpfuncs
-(void)InitListDatesScroll
{
    UIButton *btnDate;
    for (int i=0; i<ListDates.count ;i++) {
        btnDate=[UIButton buttonWithType:UIButtonTypeCustom];;
        btnDate.frame= CGRectMake((i)*130, 2, 100, self.scrl_Dates.frame.size.height);
        [self.scrl_Dates addSubview:btnDate];
        btnDate.titleLabel.textColor=[UIColor whiteColor];
        //lblDate.font=[UIFont fontWithName:@"System" size:9];
        // [ lblDate.font fontWithSize:10];
        btnDate.tag=i;
        btnDate.backgroundColor=[UIColor clearColor];
        // btnDate.alpha=0.4;
        btnDate.titleLabel.textAlignment=NSTextAlignmentCenter;
        
        [btnDate setTitle:[ListDates objectAtIndex:i] forState:UIControlStateNormal];
                if(i==currentIndex)
        {
           [btnDate setBackgroundImage:[UIImage imageNamed:@"changedate.png"] forState:UIControlStateNormal];
           
            // btnDate.alpha=0.5f;
        }
        btnDate.titleLabel.font = [UIFont systemFontOfSize:8];
        [btnDate addTarget:self action:@selector(GoToEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
    CGRect frame = btnDate.frame;
    frame.origin.x = 130 * currentIndex;
    frame.origin.y = 0;
    
    
    // btn_Settings.backgroundColor=[UIColor redColor];
    
    self.scrl_Dates.contentSize = CGSizeMake(130*ListDates.count, self.scrl_Dates.frame.size.height);
    [self.scrl_Dates scrollRectToVisible:frame animated:YES];
}
-(UIView*) getSubViewInViewWithTag:(UIView*)view withTag:(NSInteger)tag {
	
	for (UIView *subview in view.subviews) {
		if(subview.tag==tag)
			return subview;
	}
	return nil;
}
-(NSDate *)dateWithOutTime:(NSDate *)datDate{
    if( datDate == nil ) {
        return datDate;
    }
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:datDate];
//    [comps setHour:00];
//    [comps setMinute:00];
//    [comps setSecond:00];
    [comps setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
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
-(NSString *)FormatDate :(NSString *)date
{
   
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"dd-MMM-yyyy";
   return [ dateFormatter stringFromDate:yourDate];
}
-(void)InitListFeeds
{
  ListFeeds=[manager GetFeeds];
    DicNews=[[NSMutableDictionary alloc] init];
    NSMutableArray *TListDates=[[NSMutableArray alloc] init];
    NSString *currentDate_;
    for(int j=0;j<ListFeeds.count;j++)
    {
        FeedItem *feeditem=[ListFeeds objectAtIndex:j];
        currentDate_=[self FormatDate:feeditem.DATETIME];
        if(![self FindDateInlist:TListDates Date:currentDate_])
        {
            if(currentDate_)
            [TListDates addObject:currentDate_];
            
        }
        
    }
    NSMutableArray *ListFeedsforkey ;
    for(int i=0;i<TListDates.count;i++)
    {
         ListFeedsforkey=[[NSMutableArray alloc] init];
        NSString *date=[TListDates objectAtIndex:i];
        for (int j=0; j<ListFeeds.count; j++) {
            FeedItem *feeditem=[ListFeeds objectAtIndex:j];
            currentDate_=[self FormatDate:feeditem.DATETIME];
            if([date isEqualToString:currentDate_])
            {
                [ListFeedsforkey addObject:feeditem];
            }
        }
        [DicNews setObject:ListFeedsforkey forKey:date];
    }
}
#pragma Delegate fetch events
-(void)DidFinishLoadEvents
{
   if(!AfterToday)
   {
    NSDate *today=[NSDate date];
    NSString *Today_str=[self FormatDateToForm3:today];
   
    NSString *After4Day=[self AddDayToDate:Today_str :4];
    
    manager.delegate=self;
    AfterToday=YES;
    [manager requestExchange:Today_str :After4Day];
   }
    else
    {
    
   
     [self InitListDatesToBar];
        [self InitListDatesScroll];
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * ListDates.count, scrollView.frame.size.height);
//        NSMutableArray *controllers = [[NSMutableArray alloc] init];
//        for (unsigned i = 0; i < ListDates.count; i++) {
//            [controllers addObject:[NSNull null]];
//        }
//        
//        self.viewControllers = controllers;
//       
//    [scrollView setContentOffset: CGPointMake(scrollView.frame.size.width*currentIndex, 0)];
//    [self loadScrollViewWithPage:currentIndex];
//        
//        
//    [self loadScrollViewWithPage:currentIndex+1];
    
        [self initsomecontrollers];
      // [self.tableView reloadData];
    
    [MBProgressHUD2 hideHUDForView:view_Market animated:YES];
        NSDate *today=[NSDate date];
        NSString *Today_str=[self FormatDateToForm3:today];
 NSUserDefaults *Default= [NSUserDefaults standardUserDefaults];
       
        today=[self dateWithOutTime:today];
          [Default setObject:today forKey:@"LastRefresh"];
    }
}
-(void)DidFinishLoadEvents2
{
}
#pragma Delegate fetch feeds
-(void)DidFinishLoadFeeds
{
    [self InitListFeeds];
    [self.tableView_News reloadData];
    [MBProgressHUD2 hideHUDForView:view_News animated:YES];
    
    NSDate *today=[NSDate date];
    //NSString *Today_str=[self FormatDateToForm3:today];
    NSUserDefaults *Default= [NSUserDefaults standardUserDefaults];
    
    today=[self dateWithOutTime:today];
    [Default setObject:today forKey:@"LastRefreshFeeds"];
    
}
#pragma getevents

-(void)GetEvents
{
       NSDate *today=[NSDate date];
    NSString *Today_str=[self FormatDateToForm3:today];
    NSString *Before4Day=[self AddDayToDate:Today_str :-4];
   // NSString *After4Day=[self AddDayToDate:Today_str :4];
    manager=[[Manager alloc] init];
    manager.delegate=self;
    [MBProgressHUD2 showHUDAddedTo:view_Market animated:YES];
    [manager requestExchange:Before4Day :Today_str];
}
-(void)GetEventsOffline
{
    manager=[[Manager alloc] init];
    manager.delegate=self;
    [self GetDateClosetToday];
    [self InitListDatesScroll];
//scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * ListDates.count, scrollView.frame.size.height);
//    NSMutableArray *controllers = [[NSMutableArray alloc] init];
//    for (unsigned i = 0; i < ListDates.count; i++) {
//        [controllers addObject:[NSNull null]];
//    }
//    
//    self.viewControllers = controllers;
//   
//    [scrollView setContentOffset: CGPointMake(scrollView.frame.size.width*currentIndex, 0)];
//    [self loadScrollViewWithPage:currentIndex];
//    [self loadScrollViewWithPage:currentIndex+1];
    
    [self initsomecontrollers];
}
#pragma HelpFuns
#pragma HelpFunc
-(void)GetDateClosetToday
{
    NSMutableArray *ListDatesEvents=[manager  GetAllDatesFromEvents];
    NSDate *today=[NSDate date];
    NSString *Today_str=[self FormatDateToForm3:today];
ListDates=ListDatesEvents;
    NSString *currentdate;
    for(int i=0;i<20;i++)
    {
        currentdate=[self AddDayToDate:Today_str :-i];
          currentdate=[self FormatDateToForm6:currentdate];
        currentIndex=[ListDatesEvents indexOfObject:currentdate];
      
        if(currentIndex!=-1)
        {
            return;
        }
    }
    //    NSString *Before2Day=[self AddDayToDate:Today_str :-2];
    //    Before2Day=[self FormatDateToForm6:Before2Day];
    
    
    
}
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
    NSString *datenow=[dateFormatter stringFromDate:newDate];
    return datenow;
    // Clean up
    
}

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
-(NSString *)FormatDateToForm4 :(NSString  *)date
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MMM/yyyy";
    NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"yyyyMMdd";
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
-(NSString *)FormatDateToForm5 :(NSDate *)date
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"yyyyMMdd HH:mm:ss";
    //    NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"dd/MMM/yyyy";
    return [ dateFormatter stringFromDate:date];
}
-(NSString *)FormatDateToForm6 :(NSString  *)date
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"dd/MMM/yyyy";
    return [ dateFormatter stringFromDate:yourDate];
    
}
-(NSString *)FormatDateToForm7 :(NSDate *)date
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
//    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  //  NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"dd/MMM/yyyy";
    return [ dateFormatter stringFromDate:date];
    
}

-(void)InitListDatesToBar
{
    NSMutableArray *ListDatesEvents=[manager  GetAllDatesFromEvents];
    NSDate *today=[NSDate date];
     NSString *Today_str=[self FormatDateToForm5:today];
//    NSString *Before2Day=[self AddDayToDate:Today_str :-2];
//    Before2Day=[self FormatDateToForm6:Before2Day];
   
   [self GetDateClosetToday];
    ListDates=ListDatesEvents;
      
}
-(void)GoToEvents:(UIButton *)sender
{
   
   
    CGRect frame = sender.frame;
    frame.origin.x = 130 *sender.tag;
    frame.origin.y = 0;
    currentIndex=sender.tag;
    for (UIButton *subview in scrl_Dates.subviews) {
        [subview setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [subview setBackgroundColor:[UIColor clearColor]];
       
    }
    // btn_Settings.backgroundColor=[UIColor redColor];
    
    self.scrl_Dates.contentSize = CGSizeMake(130*ListDates.count, self.scrl_Dates.frame.size.height);
    [self.scrl_Dates scrollRectToVisible:frame animated:YES];
    
    
    [sender setBackgroundImage:[UIImage imageNamed:@"changedate.png"] forState:UIControlStateNormal];
    
    

    
    [self changePage:sender.tag ];
}
#pragma mark - ActionsDatePicker
- (IBAction)openDateSelectionController:(id)sender {
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    dateSelectionVC.delegate = self;
    
    //You can enable or disable bouncing and motion effects
    //dateSelectionVC.disableBouncingWhenShowing = YES;
    //dateSelectionVC.disableMotionEffects = YES;
    
    [dateSelectionVC show];
    
    //After -[RMDateSelectionViewController show] or -[RMDateSelectionViewController showFromViewController:] has been called you can access the actual UIDatePicker via the datePicker property
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
    dateSelectionVC.datePicker.minuteInterval = 5;
    dateSelectionVC.datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
    
    //You can also adjust colors (enabling example will result in a black version)
    //dateSelectionVC.tintColor = [UIColor whiteColor];
    //dateSelectionVC.backgroundColor = [UIColor colorWithWhite:0.25 alpha:1];
}

- (IBAction)openDateSelectionControllerWithBlock:(id)sender {
    RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
    
    //You can enable or disable bouncing and motion effects
    //dateSelectionVC.disableBouncingWhenShowing = YES;
    //dateSelectionVC.disableMotionEffects = YES;
    [dateSelectionVC showWithSelectionHandler:^(RMDateSelectionViewController *vc, NSDate *aDate) {
        NSLog(@"Successfully selected date: %@ (With block)", aDate);
    } andCancelHandler:^(RMDateSelectionViewController *vc) {
        NSLog(@"Date selection was canceled (with block)");
    }];
    
    //After -[RMDateSelectionViewController show] or -[RMDateSelectionViewController showFromViewController:] has been called you can access the actual UIDatePicker via the datePicker property
    dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    dateSelectionVC.datePicker.minuteInterval = 5;
    dateSelectionVC.datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:0];
}

//#pragma mark - UITableView Delegates
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if(indexPath.section == 0 && indexPath.row == 0) {
//        [self openDateSelectionController:self];
//    } else if (indexPath.section == 0 && indexPath.row == 1) {
//        [self openDateSelectionControllerWithBlock:self];
//    }
//    
//    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

#pragma mark - RMDAteSelectionViewController Delegates
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate {
    NSLog(@"Successfully selected date: %@", aDate);
    NSString *DateSelected=[self FormatDateToForm7:aDate];
    int selectedindex=[ListDates indexOfObject:DateSelected];
    [self changePage:selectedindex];
    
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"Date selection was canceled");
}


@end