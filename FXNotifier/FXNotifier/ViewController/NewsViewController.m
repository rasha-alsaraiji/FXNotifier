//
//  NewsViewController.m
//  FXNotifier
//
//  Created by RashOosh on 2/4/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize lblDate,lblsubtitle,lblTitle,feeditem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithPageNumber:(int)page {
    
    if (self = [super initWithNibName:@"NewsViewController" bundle:nil]) {
       
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
}
-(void)viewWillDisappear:(BOOL)animated
{
   

}
-(void)viewDidDisappear:(BOOL)animated
{
   //  [self.view removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    lblsubtitle.text=feeditem.FEEDTITLE;
    lblTitle.text=feeditem.TITLE;
    lblDate.text=feeditem.DATETIME;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)GoBack:(id)sender
{
    [self.view removeFromSuperview];
    
}

@end
