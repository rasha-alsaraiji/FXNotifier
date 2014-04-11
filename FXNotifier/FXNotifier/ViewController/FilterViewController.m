//
//  FilterViewController.m
//  FXNotifier
//
//  Created by RashOosh on 2/9/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "FilterViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize delegate;
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
    ListCountries=[[NSMutableArray alloc] initWithObjects:@"Australia",@"Switzerland",@"European Monetary Union",@"France",@"Italy",@"New Zealand",@"United States",@"Canada",@"China",@"Spain",@"Greece",@"Japan",@"United Kingdom",@"Germany", nil];
    ListEffects=[[NSMutableArray alloc] initWithObjects:@"effect_no",@"effect_weak",@"effect_middle",@"effect_strong",nil];
    // Do any additional setup after loading the view from its nib.
//   btn_check1.titleLabel.text=@"hg";
//    [btn_check1 setTitle:@"hhh" forState:UIControlStateNormal];
//    [btn_check1 setImage:[UIImage imageNamed:@"checkedFilter.png"] forState:UIControlStateNormal];
   Default= [NSUserDefaults standardUserDefaults];
    
    Australia= [Default objectForKey:@"Australia"];
    if(!Australia)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Australia"];
         [ btn_check1 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)Australia;
        if([ok intValue]==1)

            [ btn_check1 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
             [ btn_check1 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
   
   
    
    Switzerland= [Default objectForKey:@"Switzerland"];
    if(!Switzerland)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Switzerland"];
        [ btn_check2 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)Switzerland;
        if([ok intValue]==1)

            [ btn_check2 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check2 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
    
 European= [Default objectForKey:@"European Monetary Union"];
    if(!European)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"European Monetary Union"];
        [ btn_check3 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)European;
        if([ok intValue]==1)

            [ btn_check3 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check3 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
    France= [Default objectForKey:@"France"];
    if(!France)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"France"];
        [ btn_check4 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)France;
        if([ok intValue]==1)

            [ btn_check4 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check4 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
     Italy= [Default objectForKey:@"Italy"];
    if(!Italy)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Italy"];
        [ btn_check5 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)Italy;
        if([ok intValue]==1)

            [ btn_check5 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check5 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
     New_Zealand= [Default objectForKey:@"New Zealand"];
    if(!New_Zealand)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"New Zealand"];
        [ btn_check6 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)New_Zealand;
        if([ok intValue]==1)

            [ btn_check6 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check6 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
     United_States= [Default objectForKey:@"United States"];
    if(!United_States)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"United States"];
        [ btn_check7 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)United_States;
        if([ok intValue]==1)

            [ btn_check7 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check7 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
     Canada= [Default objectForKey:@"Canada"];
    if(!Canada)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Canada"];
        [ btn_check8 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)Canada;
        if([ok intValue]==1)

            [ btn_check8 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check8 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
     China= [Default objectForKey:@"China"];
    if(!China)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"China"];
        [ btn_check9 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)China;
        if([ok intValue]==1)

            [ btn_check9 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check9 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    Spain= [Default objectForKey:@"Spain"];
    if(!Spain)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Spain"];
        [ btn_check10 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)Spain;
        if([ok intValue]==1)

            [ btn_check10 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check10 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
     Greece= [Default objectForKey:@"Greece"];
    if(!Greece)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Greece"];
        [ btn_check11 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)Greece;
        if([ok intValue]==1)

            [ btn_check11 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check11 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
     Japan= [Default objectForKey:@"Japan"];
    if(!Japan)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Japan"];
        [ btn_check12 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)Japan;
        if([ok intValue]==1)

            [ btn_check12 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check12 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
    United_Kingdom= [Default objectForKey:@"United Kingdom"];
    if(!United_Kingdom)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"United Kingdom"];
        [ btn_check13 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)United_Kingdom;
        if([ok intValue]==1)

            [ btn_check13 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check13 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    
    
    Germany= [Default objectForKey:@"Germany"];
    if(!Germany)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Germany"];
        [ btn_check14 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)Germany;
        if([ok intValue]==1)
            [ btn_check14 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check14 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

    effect_weak= [Default objectForKey:@"effect_weak"];
    if(!effect_weak)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"effect_weak"];
        [ btn_check17 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)effect_weak;
        if([ok intValue]==1)
            [ btn_check17 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check17 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    
    
    
    effect_strong= [Default objectForKey:@"effect_strong"];
    if(!effect_strong)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"effect_strong"];
        [ btn_check19 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)effect_strong;
        if([ok intValue]==1)
            [ btn_check19 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check19 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    
    
    effect_no= [Default objectForKey:@"effect_no"];
    if(!effect_no)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"effect_no"];
        [ btn_check16 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)effect_no;
        if([ok intValue]==1)
            [ btn_check16 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check16 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    
    
    effect_middle= [Default objectForKey:@"effect_middle"];
    if(!effect_middle)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"effect_middle"];
        [ btn_check18 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
        NSNumber * ok=(NSNumber *)effect_middle;
        if([ok intValue]==1)
            [ btn_check18 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
        else
            [ btn_check18 setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
    }
    

      // [Default setObject:ListFilters forKey:@"Filters"];
    
//    if(CurrentDefault)
//    {
//        
//    }
//    else
//    {
//        NSMutableArray *ListFilters=[[NSMutableArray alloc] init];
//        for(int i=0;i<14; i++)
//        {
//            
//            [ListFilters addObject:false];
//        }
//     
//    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)SelectCheckBox:(UIButton *)sender
{
    NSLog(@"%ld",(long)sender.tag);
//    UIButton *button = (UIButton *)[self.view viewWithTag:sender.tag];
//    sender.titleLabel.text=@"hgghj";
//    button.titleLabel.text=@"hg";
    NSString *name;
    if (sender.tag>15) {
        name=[ListEffects objectAtIndex:sender.tag-16];
    }
    else
    {
        name=[ListCountries objectAtIndex:sender.tag-1];
    }
    Default= [NSUserDefaults standardUserDefaults];
    
    NSObject *obj= [Default objectForKey:name];
    if(!obj)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:name];
        [ sender setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    else
    {
       NSNumber * ok=(NSNumber *)obj;
        if([ok intValue]==0)
        {
            [ sender setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
             [Default setObject:[NSNumber numberWithBool:TRUE] forKey:name];
        }
        else
        {
            [sender setImage:[UIImage imageNamed:@"cb_hover_blue.png"] forState:UIControlStateNormal];
             [Default setObject:[NSNumber numberWithBool:FALSE] forKey:name];
            
        }
    }

    
    
    //[sender setImage:[UIImage imageNamed:@"checkedFilter.png"] forState:UIControlStateNormal];
    
  //  [button setImage:[UIImage imageNamed:@"checkedFilter.png"] forState:UIControlStateSelected];
}

-(IBAction)Back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
   // MainViewController *MainView = [[MainViewController alloc]     initWithNibName:@"MainViewController" bundle:nil];
  //  UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:MainView];
  //  AppDelegate *appDelegate = ( AppDelegate *)[[UIApplication sharedApplication] delegate];
   [delegate initsomecontrollers];
   // appDelegate.window.rootViewController = nav;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
