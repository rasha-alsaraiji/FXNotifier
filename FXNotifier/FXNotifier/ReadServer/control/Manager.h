//
//  Manager.h
//  CurrencyConvrter
//
//  Created by Syrisoft on 6/9/13.
//  Copyright (c) 2013 Syrisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject

#pragma mark - Properties

@property (nonatomic,strong) NSMutableData *receivedData;
@property (nonatomic,strong)  NSURLConnection *LLConnectionEvents;
@property (nonatomic,strong)  NSURLConnection *LLConnectionFeeds;
@property (nonatomic,strong)  NSURLConnection *LLConnectionSearch;
@property (nonatomic,strong) id delegate;
- (float) requestExchange: (NSString*) startdate : (NSString*) enddate;
- (float) requestsearch: (NSString*)date  IdEchType:(NSString*) idechtype IdCountry :(NSString *)idcountry Volatility:(int)volatitlity;

-(NSMutableArray *)fetchAllCountries;
-(NSMutableArray *)fetchAllcountriesAr;
-(NSMutableArray *)fetchCalendarType;
-(NSMutableArray *)fetchCalendarTypeAr;
-(NSString *)fetchCalendarIDTypeByType:(NSString *)Type;
- (void) requestFeeds;
-(NSMutableArray *)GetAllDatesFromEvents;
-(void)StopConnection ;
-(NSMutableArray *)GetFeeds;
-(NSMutableArray *)GetEvents:(NSString *)date;
- (NSString*) fetchCountryIDByCountry :(NSString *)country;
@end
