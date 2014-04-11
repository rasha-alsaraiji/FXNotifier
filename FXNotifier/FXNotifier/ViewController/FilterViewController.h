//
//  FilterViewController.h
//  FXNotifier
//
//  Created by RashOosh on 2/9/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController

{
   IBOutlet UIImageView *img_flag1;
    IBOutlet UIButton *btn_check1;
    
    IBOutlet UIImageView *img_flag2;
    IBOutlet UIButton *btn_check2;
    
    IBOutlet UIImageView *img_flag3;
    IBOutlet UIButton *btn_check3;
    
    IBOutlet UIImageView *img_flag4;
    IBOutlet UIButton *btn_check4;
    
    IBOutlet UIImageView *img_flag5;
    IBOutlet UIButton *btn_check5;
    
    IBOutlet UIImageView *img_flag6;
    IBOutlet UIButton *btn_check6;
    
    IBOutlet UIImageView *img_flag7;
    IBOutlet UIButton *btn_check7;
    
    
    //second col
    IBOutlet UIImageView *img_flag8;
    IBOutlet UIButton *btn_check8;
    
    IBOutlet UIImageView *img_flag9;
    IBOutlet UIButton *btn_check9;
    
    IBOutlet UIImageView *img_flag10;
    IBOutlet UIButton *btn_check10;
    
    IBOutlet UIImageView *img_flag11;
    IBOutlet UIButton *btn_check11;
    
    IBOutlet UIImageView *img_flag12;
    IBOutlet UIButton *btn_check12;
    
    IBOutlet UIImageView *img_flag13;
    IBOutlet UIButton *btn_check13;
    
    IBOutlet UIImageView *img_flag14;
    IBOutlet UIButton *btn_check14;
    
     IBOutlet UIButton *btn_check16 ;
     IBOutlet UIButton *btn_check17 ;
     IBOutlet UIButton *btn_check18 ;
     IBOutlet UIButton *btn_check19 ;
    
    
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
    
    NSMutableArray *ListCountries;
     NSMutableArray *ListEffects ;
}
@property(nonatomic,strong)id delegate;
-(IBAction)SelectCheckBox:(UIButton *)sender ;
-(IBAction)Back:(id)sender ;
@end
