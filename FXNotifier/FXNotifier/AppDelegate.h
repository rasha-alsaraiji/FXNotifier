//
//  AppDelegate.h
//  FXNotifier
//
//  Created by RashOosh on 1/31/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSUserDefaults *Default;
    NSObject *  Australia;
    
    NSObject *  Switzerland;
    NSObject *  European;
    NSObject * France;
    NSObject *  Italy;
    NSObject *  New_Zealand;
    
    NSObject *  United_States;
    NSObject * Canada;
    NSObject *  China;
    NSObject * Spain;
    NSObject *  Greece;
    NSObject *  Japan;
    NSObject * United_Kingdom;
    NSObject *  Germany;


    NSObject * effect_no;

    NSObject *  effect_strong;

    NSObject *  effect_weak;

    NSObject *  effect_middle;

}
@property (strong, nonatomic)IBOutlet UIWindow *window;

@end
