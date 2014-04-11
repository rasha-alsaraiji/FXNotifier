//
//  SearchViewController.m
//  FXNotifier
//
//  Created by RashOosh on 2/8/14.
//  Copyright (c) 2014 EnmaSolutions. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize didselect,manager,countryNs,importanceNs,TypeNs,lblCountry,lblImportance,lblType,lblChangeDate,delegate;
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
    NSString *today= [self FormatDateToForm7:[NSDate date]];
    lblChangeDate.text=today;
    // Do any additional setup after loading the view from its nib.
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    manager=[[Manager alloc] init];
    ListCountries=[manager fetchAllCountries];
    ListTypes=[manager fetchCalendarType];
    [ListTypes addObject:@"cancel"];
    ListImportance=[[NSMutableArray alloc] initWithObjects:@"effect_no",@"effect_weak",@"effect_middle",@"effect_strong",@"cancel",nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    didselect=FALSE;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)SearchCountry:(id)sender
{
   
    importance=false;
    kind=false;
    country=true;
    
    [self.Picker reloadAllComponents];
    [self showPicker];
    
  
        [self.Picker selectRow:0 inComponent:0 animated:YES];
        
    

    
}
-(IBAction)SearchKind:(id)sender
{
    importance=false;
    kind=true;
    country=false;
    
    [self.Picker reloadAllComponents];
    [self showPicker];
    
    
    [self.Picker selectRow:0 inComponent:0 animated:YES];
}
-(IBAction)SearchImportance:(id)sender
{
    importance=true;
    kind=false;
    country=false;
    
    [self.Picker reloadAllComponents];
    [self showPicker];
    
    
    [self.Picker selectRow:0 inComponent:0 animated:YES];
}
#pragma mark - Picker Delegate Handler
-(IBAction)closePicker
{
    [self.pickerView setHidden:YES];
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerView.frame = CGRectMake(self.pickerView.frame.origin.x,
                                           [[UIScreen mainScreen] bounds].size.height,
                                           self.pickerView.frame.size.width,
                                           self.pickerView.frame.size.height);
    }];
}


-(IBAction)showPicker
{
    [self dismissKeyboard];
    
    [self.pickerView setHidden:NO];
    [self.pickerView setHidden:NO];
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerView.frame = CGRectMake(self.pickerView.frame.origin.x,
                                           [[UIScreen mainScreen] bounds].size.height-self.self.pickerView.frame.size.height,
                                           self.pickerView.frame.size.width,
                                           self.pickerView.frame.size.height);
    }];
}

-(void)dismissKeyboard {
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

        didselect=TRUE;
        if(importance)
        {
    self.importanceNs=[ListImportance objectAtIndex:row];
            lblImportance.text= self.importanceNs;
        }
    
    if(kind)
    {
    self.TypeNs=[ListTypes objectAtIndex:row];
        lblType.text=self.TypeNs;
    }
    if(country)
    {
    self.countryNs=[ListCountries objectAtIndex:row];
        lblCountry.text=self.countryNs;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (country) {
        return ListCountries.count;
    }
    if(kind)
        return ListTypes.count;
    if (importance) {
        return ListImportance.count;
    }
    return 5;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
      if (country)
    return [NSString stringWithFormat:@"%@",[ListCountries objectAtIndex:row]];
    if (kind) {
           return [NSString stringWithFormat:@"%@",[ListTypes objectAtIndex:row]];
    }
    if (importance) {
        return [NSString stringWithFormat:@"%@",[ListImportance objectAtIndex:row]];
    }
    return @"";
}

- (IBAction)doneBtnPrss:(id)sender {
    [self closePicker];
    
    
        if(!didselect)
        {
                       didselect=FALSE;
        }
    
        
        
    
    
}

-(IBAction)Back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(IBAction)ChangeDate:(id)sender
{
    [self openDateSelectionController:nil];
}
-(IBAction)Search:(id)sender
{
    manager.delegate=self;
    int vol=[ListImportance indexOfObject:importanceNs];
    NSString *idtype=[manager fetchCalendarIDTypeByType:TypeNs];
    NSString *date=[self FormatDateToForm4:lblChangeDate.text];
    NSString *countryid=[manager fetchCountryIDByCountry:countryNs];
    [manager requestsearch:date IdEchType:idtype IdCountry:countryid Volatility:vol];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
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
-(NSString *)FormatDateToForm8 :(NSDate *)date
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //  NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"yyyyMMdd";
    return [ dateFormatter stringFromDate:date];
    
    
    
}
-(void)DidFinishLoadSearch :(NSDictionary *)ListSearch
{
    
    
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
    lblChangeDate.text=DateSelected;
    
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc {
    NSLog(@"Date selection was canceled");
}


@end
