//
//  ContactUsViewController.m
//  FXNotifier
//
//  Created by RashOosh on 2/9/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()
{
    UITapGestureRecognizer *tap;
}
@end

@implementation ContactUsViewController

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
    
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(IBAction)Cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)dismissKeyboard {
    
}

@end
