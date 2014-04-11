//
//  MainViewController.h
//  Dalilak
//
//  Created by RashOosh on 1/21/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StyledPullableView.h"
#import "Manager.h"
#import "RMDateSelectionViewController.h"


@interface MainViewController : UIViewController <UIScrollViewDelegate,PullableViewDelegate ,RMDateSelectionViewControllerDelegate>

{
    UIScrollView *scrollView;
	UIPageControl *pageControl;
    NSMutableArray *viewControllers;
	UIImageView  *hebView;
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    NSMutableArray *viewControllers_News;
    
    
   
  
    

}
@property (nonatomic, strong) IBOutlet UIScrollView *scrl_Dates;
@property (nonatomic, strong)IBOutlet  UIPageControl *pageControl;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong)  NSMutableArray *viewControllers_News;
// top bar
@property (nonatomic, strong) IBOutlet UILabel *lbl_News;
@property (nonatomic, strong)IBOutlet  UILabel *lblABoutApp;
@property (nonatomic, strong)IBOutlet   UILabel *lbl_Details;
@property (nonatomic, strong) IBOutlet  UIButton *btn_details;
@property (nonatomic, strong) IBOutlet UIButton *btn_AboutApp;
@property (nonatomic, strong) IBOutlet UIButton *btn_News;
@property (nonatomic, strong)IBOutlet UIImageView *imgBottom_Details;
@property (nonatomic, strong)IBOutlet UIImageView *imgBottom_News;
@property (nonatomic, strong)IBOutlet UIImageView *imgBottom_AboutApp;


- (IBAction)GoToMainDetailView;
- (IBAction)GoTNewsView;
- (IBAction)GoToAboutApp;


// Mainviews
@property (nonatomic) int currentIndex;
@property (nonatomic) BOOL AfterToday;
@property (nonatomic, strong) NSMutableArray *ListEvents;
@property (nonatomic, strong) NSMutableArray * ListDates;
@property (nonatomic, strong)IBOutlet  UIView *view_Aboutapp;

@property (nonatomic,retain) IBOutlet UIView *view_News;
@property (nonatomic, strong) IBOutlet UIView *view_Market;

@property (nonatomic, strong) NSString *currentDate;
//AbouApp

-(IBAction)RateApp:(id)sender;
-(IBAction)ShareApp:(id)sender;
-(IBAction)Facebook:(id)sender;
-(IBAction)ContactUs:(id)sender;
// NewsApp
@property (nonatomic,strong) IBOutlet UITableView *tableView_News;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView_News;
@property (nonatomic, strong) NSMutableArray *ListFeeds;
@property (nonatomic, strong) NSMutableDictionary *DicNews;
-(void)DidFinishLoadFeeds;
- (void)changePage:(int)page;
-(void)GetEventsOffline;

-(void)initsomecontrollers;
// pullup
@property (nonatomic, strong) StyledPullableView *pullUpView;
@property (nonatomic, strong) UILabel *pullUpLabel;


@property(nonatomic,strong)Manager *manager;
@end
