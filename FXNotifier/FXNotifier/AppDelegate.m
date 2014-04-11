//
//  AppDelegate.m
//  FXNotifier
//
//  Created by RashOosh on 1/31/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainViewController *MainView = [[MainViewController alloc]     initWithNibName:@"MainViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]  initWithRootViewController:MainView];
    self.window.rootViewController = nav;
    
    [self InitDefault];

    [self.window makeKeyAndVisible];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
   // [[UIApplication sharedApplication] setStatusBarHidden:YES];
       // Override point for customization after application launch.
    return YES;
}
-(void)InitDefault
{
    Default= [NSUserDefaults standardUserDefaults];
    
    Australia= [Default objectForKey:@"Australia"];
    if(!Australia)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Australia"];
        
    }
    
    
    
    Switzerland= [Default objectForKey:@"Switzerland"];
    if(!Switzerland)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Switzerland"];
        //[ btn_check2 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    
    
    
    European= [Default objectForKey:@"European Monetary Union"];
    if(!European)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"European Monetary Union"];
       // [ btn_check3 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
   
    
    
    
    
    France= [Default objectForKey:@"France"];
    if(!France)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"France"];
//[ btn_check4 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    
    Italy= [Default objectForKey:@"Italy"];
    if(!Italy)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Italy"];
      //  [ btn_check5 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    
    
    
    New_Zealand= [Default objectForKey:@"New Zealand"];
    if(!New_Zealand)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"New Zealand"];
       // [ btn_check6 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    
    
    
    United_States= [Default objectForKey:@"United States"];
    if(!United_States)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"United States"];
       // [ btn_check7 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    
    
    
    
    Canada= [Default objectForKey:@"Canada"];
    if(!Canada)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Canada"];
       // [ btn_check8 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
   
    
    
    
    China= [Default objectForKey:@"China"];
    if(!China)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"China"];
        //[ btn_check9 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    
    
    Spain= [Default objectForKey:@"Spain"];
    if(!Spain)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Spain"];
        //[ btn_check10 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
   
    
    
    Greece= [Default objectForKey:@"Greece"];
    if(!Greece)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Greece"];
        //[ btn_check11 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    
    
    
    Japan= [Default objectForKey:@"Japan"];
    if(!Japan)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Japan"];
      //  [ btn_check12 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    
    
    
    United_Kingdom= [Default objectForKey:@"United Kingdom"];
    if(!United_Kingdom)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"United Kingdom"];
       // [ btn_check13 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    
    
    Germany= [Default objectForKey:@"Germany"];
    if(!Germany)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"Germany"];
       // [ btn_check14 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
    effect_weak= [Default objectForKey:@"effect_weak"];
    if(!effect_weak)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"effect_weak"];
        // [ btn_check14 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    effect_strong= [Default objectForKey:@"effect_strong"];
    if(!effect_strong)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"effect_strong"];
        // [ btn_check14 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    effect_no= [Default objectForKey:@"effect_no"];
    if(!effect_no)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"effect_no"];
        // [ btn_check14 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    effect_middle= [Default objectForKey:@"effect_middle"];
    if(!effect_middle)
    {
        [Default setObject:[NSNumber numberWithBool:TRUE] forKey:@"effect_middle"];
        // [ btn_check14 setImage:[UIImage imageNamed:@"cb_checked_blue.png"] forState:UIControlStateNormal];
    }
    
   
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
