//
//  SearchViewController.h
//  FXNotifier
//
//  Created by RashOosh on 2/8/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Manager.h"
#import "RMDateSelectionViewController.h"


@interface SearchViewController : UIViewController <RMDateSelectionViewControllerDelegate>
{
      UITapGestureRecognizer *tap;
    NSMutableArray *ListCountries;
    NSMutableArray *ListTypes;
    NSMutableArray *ListImportance;

    BOOL country;
    BOOL importance;
    BOOL  kind;
    
}
@property (strong, nonatomic) Manager *manager;
// Picker View
@property (strong, nonatomic) IBOutlet UIView *pickerView;
@property (strong, nonatomic) IBOutlet UIPickerView *Picker;

@property (strong, nonatomic)NSString *TypeNs;

@property (strong, nonatomic)NSString *importanceNs;
@property (strong, nonatomic)NSString *countryNs;

@property ( nonatomic) BOOL didselect;
- (IBAction)doneBtnPrss:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblCountry;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblImportance;
@property (strong, nonatomic) IBOutlet UILabel *lblChangeDate;
@property (strong, nonatomic) id delegate;
-(IBAction)SearchCountry:(id)sender;
-(IBAction)SearchKind:(id)sender;
-(IBAction)SearchImportance:(id)sender;
-(IBAction)Search:(id)sender;
-(IBAction)ChangeDate:(id)sender;
-(IBAction)Back:(id)sender;

-(void)DidFinishLoadSearch :(NSDictionary *)ListSearch;
@end
