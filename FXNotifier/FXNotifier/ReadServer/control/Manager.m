//
//  Manager.m
//  CurrencyConvrter
//
//  Created by Syrisoft on 6/9/13.
//  Copyright (c) 2013 Syrisoft. All rights reserved.
//
#pragma mark - URLs
#define ExhangeURL [NSURL URLWithString: @"http://fxnotifier.com/mobiledata/grabdata"]
#define FeedsURL   [NSURL URLWithString: @"http://fxnotifier.com/mobiledata/feeds"]
#define SearchURL   [NSURL URLWithString: @"http://fxnotifier.com/mobiledata/search"]


#import "Manager.h"
#import "EventItem.h"
#import "FeedItem.h"
#import "FileDbAdapter.h"
#import "MainViewController.h"
#import "SubMainViewController.h"
#import "SearchViewController.h"
@implementation Manager
@synthesize receivedData;
@synthesize LLConnectionEvents,LLConnectionFeeds,LLConnectionSearch,delegate;
- (id)init {
    if (self = [super init]) {
       // self.currenciesDictionary=[[NSDictionary alloc] initWithDictionary:[self loadCurrenciesFile]];
    }
    return self;
}



- (void) requestFeeds
{
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setTimeoutInterval:60];
    
    [request setURL:FeedsURL];
    [request setHTTPMethod:@"GET"];
   
    [LLConnectionEvents cancel];
    [LLConnectionSearch cancel];
    
    LLConnectionEvents=nil;
    LLConnectionSearch=nil;
    LLConnectionFeeds=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (LLConnectionFeeds) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        self. receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }
    
    
    
    
    return ;

}

- (float) requestExchange: (NSString*) startdate : (NSString*) enddate{
    
    NSString * post =[NSString stringWithFormat:@"startdate=%@&enddate=%@",startdate,enddate];
    //[request setHTTPBody:[content dataUsingEncoding:NSUTF8StringEncoding]];

    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setTimeoutInterval:60];
    
    [request setURL:ExhangeURL];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [LLConnectionFeeds cancel];
    [LLConnectionSearch cancel];
    
    LLConnectionFeeds=nil;
    LLConnectionSearch=nil;
    LLConnectionEvents=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if ( LLConnectionEvents) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        self. receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }

    
   

    return 0;
    
}
- (float) requestsearch: (NSString*)date  IdEchType:(NSString*) idechtype IdCountry :(NSString *)idcountry Volatility:(int)volatitlity

{
    
    NSString * post;
    if(volatitlity<4)
   post =[NSString stringWithFormat:@"DateTime=%@&IdCountry='%@'&IdEcoCalendarType='%@'&Volatility=%d",date,idcountry,idechtype,volatitlity];
    else
        post =[NSString stringWithFormat:@"DateTime=%@&IdCountry='%@'&IdEcoCalendarType='%@'",date,idcountry,idechtype];
    
    //[request setHTTPBody:[content dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setTimeoutInterval:60];
    
    [request setURL:SearchURL];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [LLConnectionFeeds cancel];
    [LLConnectionEvents cancel];
    LLConnectionFeeds=nil;
    LLConnectionSearch=nil;
    
    LLConnectionSearch=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if ( LLConnectionSearch) {
        // Create the NSMutableData to hold the received data.
        // receivedData is an instance variable declared elsewhere.
        self. receivedData = [NSMutableData data];
    } else {
        // Inform the user that the connection failed.
    }
    
    
    
    
    return 0;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.receivedData setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
    
    if(LLConnectionEvents)
        
    {
    
    NSArray *PathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *rootPath = [PathArray objectAtIndex:0];
    
    
    NSString *file = [rootPath stringByAppendingPathComponent:@"events.json"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //if(![fileManager fileExistsAtPath:file]) {
    [fileManager createFileAtPath:file contents:nil attributes:nil];
    //}
    
    
    
    NSLog(@"Recieved %lu bytes of data.", (unsigned long)[data length]);
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:file];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:self.receivedData];
    [fileHandle closeFile];
    }
    if(LLConnectionFeeds)
        
    {
        
        NSArray *PathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *rootPath = [PathArray objectAtIndex:0];
        
        
        NSString *file = [rootPath stringByAppendingPathComponent:@"feeds.json"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //if(![fileManager fileExistsAtPath:file]) {
        [fileManager createFileAtPath:file contents:nil attributes:nil];
        //}
        
        
        
        NSLog(@"Recieved %lu bytes of data.", (unsigned long)[data length]);
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:file];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:self.receivedData];
        [fileHandle closeFile];
    }
    if(LLConnectionSearch)
        
    {
        
        NSArray *PathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *rootPath = [PathArray objectAtIndex:0];
        
        
        NSString *file = [rootPath stringByAppendingPathComponent:@"search.json"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //if(![fileManager fileExistsAtPath:file]) {
        [fileManager createFileAtPath:file contents:nil attributes:nil];
        //}
        
        
        
        NSLog(@"Recieved %lu bytes of data.", (unsigned long)[data length]);
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:file];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:self.receivedData];
        [fileHandle closeFile];
    }

    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
        // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    [delegate GetEventsOffline];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
     NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.receivedData length]);
    NSArray *PathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *rootPath = [PathArray objectAtIndex:0];
    if(LLConnectionEvents)
    {
   
      
   // NSString *datapath = [rootPath stringByAppendingPathComponent:@"events.json"];
   NSDictionary *dictevent=  [self loadevents];
     
        FileDbAdapter* fd = [[FileDbAdapter alloc] init];
        [fd openDB];
        
        BOOL ok=   [self InsertEventsIntoDb:dictevent];
        [delegate DidFinishLoadEvents];
    }
    

    
    
   
    if(LLConnectionFeeds)
    {
       // NSString *datapath = [rootPath stringByAppendingPathComponent:@"feeds.json"];
       NSDictionary *dictfeed= [self loadfeeds];
        FileDbAdapter* fd = [[FileDbAdapter alloc] init];
        [fd openDB];
        NSMutableArray *ListFeeds=  [fd fetchfeeds];
        NSMutableArray *ListIds=[[NSMutableArray alloc] init];
        for(int h=0;h<ListFeeds.count;h++)
        {
            FeedItem *feed=[ListFeeds objectAtIndex:h];
            [ListIds addObject:[NSNumber numberWithInt: feed.ROWID ]];
        }

        
     BOOL ok=   [self InsertFeedsIntoDb:dictfeed];
        if(ok)
        {
            FileDbAdapter* fd = [[FileDbAdapter alloc] init];
            [fd openDB];
            [fd DeleteAllOldFeeds:ListIds];
            
                   }
        [delegate DidFinishLoadFeeds];
    }

    if(LLConnectionSearch)
    {
        // NSString *datapath = [rootPath stringByAppendingPathComponent:@"feeds.json"];
        NSDictionary *dictsearch= [self loadSearch];
               [delegate DidFinishLoadSearch:dictsearch];
   

    }
}

- (NSDictionary*) loadfeeds
{
    NSDictionary * result;
    NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
    NSError *error;
    
    //  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"events" ofType:@"json"];
    NSArray *PathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *rootPath = [PathArray objectAtIndex:0];
    NSString *filePath = [rootPath stringByAppendingPathComponent:@"feeds.json"];
    
    
    
    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[fileContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    for (int i=0; i< jsonArray.count; i++) {
        
        NSDictionary *dic=[jsonArray objectAtIndex:i];
        FeedItem *tempevent=[[FeedItem alloc] initWithvalues:[[dic objectForKey:@"_id"] intValue] title:[dic objectForKey:@"fldTitle"] url:[dic objectForKey:@"fldUrl"] categoryid:[[dic objectForKey:@"fldCategoryId"] intValue] category:[dic objectForKey:@"fldCategory"] feedid:[[dic objectForKey:@"fldFeedId"] intValue] feedtitle:[dic objectForKey:@"fldFeedTitle"] details:[dic objectForKey:@"fldDetails"] thumb:[dic objectForKey:@"fldThumb"] datetime:[dic objectForKey:@"fldDatetime"]];
        
        
        NSString *RowID_str=[NSString stringWithFormat:@"%d",tempevent.ROWID];
     [temp setObject:tempevent forKey:RowID_str];
        
    }
    result=[[ NSDictionary alloc] initWithDictionary:temp];
    return result;
}
- (NSDictionary*) loadSearch{
    
    NSDictionary * result;
    NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
    NSError *error;
    
    //  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"events" ofType:@"json"];
    NSArray *PathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *rootPath = [PathArray objectAtIndex:0];
    NSString *filePath = [rootPath stringByAppendingPathComponent:@"search.json"];
    
    
    
    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[fileContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    for (int i=0; i< jsonArray.count; i++) {
        
        NSDictionary *dic=[jsonArray objectAtIndex:i];
        int volatility= 0;
        int relation=0;
        int Precision=0;
        int Preliminar=0;
        if(![[dic objectForKey:@"Volatility"]isKindOfClass:[NSNull class]])
            volatility=[[dic objectForKey:@"Volatility"] intValue];
        if( ![[dic objectForKey:@"Relation"]isKindOfClass:[NSNull class]])
            relation=[[dic objectForKey:@"Relation"] intValue];
        if(![[dic objectForKey:@"Preliminar"]isKindOfClass:[NSNull class]])
            Preliminar=   [[dic objectForKey:@"Preliminar"] intValue];
        if(![[dic objectForKey:@"Precision"] isKindOfClass:[NSNull class]])
            Precision=  [[dic objectForKey:@"Precision"] intValue];
        
        EventItem *tempevent=[[EventItem alloc] initWithvalues:0 Volatility:volatility Relation:relation  Revised:[dic objectForKey:@"Revised"]  PotActual:[dic objectForKey:@"PotActual"] PotConsensus:[dic objectForKey:@"PotConsensus"] PotPrevious:[dic objectForKey:@"PotPrevious"] Precision:Precision Preliminar:Preliminar Actual:[dic objectForKey:@"Actual"] Consensus:[dic objectForKey:@"Consensus"] Country:[dic objectForKey:@"Country"] CountryAr:[dic objectForKey:@"CountryAr"] Currency:[dic objectForKey:@"Currency"] DateTime:[dic objectForKey:@"DateTime"] DisplayActual:[dic objectForKey:@"DisplayActual"] DisplayConsensus:[dic objectForKey:@"DisplayConsensus"] DisplayPrevious:[dic objectForKey:@"DisplayPrevious"] DisplayRevised:[dic objectForKey:@"DisplayRevised"] EcoCalendarType:[dic objectForKey:@"EcoCalendarType"] EcoCalendarTypeAr:[dic objectForKey:@"EcoCalendarTypeAr"] For:[dic objectForKey:@"For"] ForType:[dic objectForKey:@"ForType"] HTMLDescription:[dic objectForKey:@"HTMLDescription"] HTMLDescriptionAr:[dic objectForKey:@"HTMLDescriptionAr"] IdCountry:[dic objectForKey:@"IdCountry"] IdEcoCalendar:[dic objectForKey:@"IdEcoCalendar"] IdEcoCalendarDate:[dic objectForKey:@"IdEcoCalendarDate"] IdEcoCalendarType:[dic objectForKey:@"IdEcoCalendarType"] InternationalCode:[dic objectForKey:@"InternationalCode"] Name:
                              [dic objectForKey:@"Name"] NameAr:[dic objectForKey:@"NameAr"] Unit:[dic objectForKey:@"Unit"] Previous:[dic objectForKey:@"Previous"]];
        
        
        
        
        [temp setObject:tempevent forKey:tempevent.IdEcoCalendarDate ];
        
    }
    result=[[ NSDictionary alloc] initWithDictionary:temp];
    return result;
}

- (NSDictionary*) loadevents{
    
    NSDictionary * result;
    NSMutableDictionary *temp=[[NSMutableDictionary alloc] init];
    NSError *error;
    
  //  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"events" ofType:@"json"];
    NSArray *PathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *rootPath = [PathArray objectAtIndex:0];
    NSString *filePath = [rootPath stringByAppendingPathComponent:@"events.json"];

    
    
    NSString *fileContent = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[fileContent dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    for (int i=0; i< jsonArray.count; i++) {
        
        NSDictionary *dic=[jsonArray objectAtIndex:i];
        int volatility= 0;
        int relation=0;
        int Precision=0;
        int Preliminar=0;
        if(![[dic objectForKey:@"Volatility"]isKindOfClass:[NSNull class]])
            volatility=[[dic objectForKey:@"Volatility"] intValue];
       if( ![[dic objectForKey:@"Relation"]isKindOfClass:[NSNull class]])
           relation=[[dic objectForKey:@"Relation"] intValue];
        if(![[dic objectForKey:@"Preliminar"]isKindOfClass:[NSNull class]])
            Preliminar=   [[dic objectForKey:@"Preliminar"] intValue];
        if(![[dic objectForKey:@"Precision"] isKindOfClass:[NSNull class]])
            Precision=  [[dic objectForKey:@"Precision"] intValue];
        
        EventItem *tempevent=[[EventItem alloc] initWithvalues:0 Volatility:volatility Relation:relation  Revised:[dic objectForKey:@"Revised"]  PotActual:[dic objectForKey:@"PotActual"] PotConsensus:[dic objectForKey:@"PotConsensus"] PotPrevious:[dic objectForKey:@"PotPrevious"] Precision:Precision Preliminar:Preliminar Actual:[dic objectForKey:@"Actual"] Consensus:[dic objectForKey:@"Consensus"] Country:[dic objectForKey:@"Country"] CountryAr:[dic objectForKey:@"CountryAr"] Currency:[dic objectForKey:@"Currency"] DateTime:[dic objectForKey:@"DateTime"] DisplayActual:[dic objectForKey:@"DisplayActual"] DisplayConsensus:[dic objectForKey:@"DisplayConsensus"] DisplayPrevious:[dic objectForKey:@"DisplayPrevious"] DisplayRevised:[dic objectForKey:@"DisplayRevised"] EcoCalendarType:[dic objectForKey:@"EcoCalendarType"] EcoCalendarTypeAr:[dic objectForKey:@"EcoCalendarTypeAr"] For:[dic objectForKey:@"For"] ForType:[dic objectForKey:@"ForType"] HTMLDescription:[dic objectForKey:@"HTMLDescription"] HTMLDescriptionAr:[dic objectForKey:@"HTMLDescriptionAr"] IdCountry:[dic objectForKey:@"IdCountry"] IdEcoCalendar:[dic objectForKey:@"IdEcoCalendar"] IdEcoCalendarDate:[dic objectForKey:@"IdEcoCalendarDate"] IdEcoCalendarType:[dic objectForKey:@"IdEcoCalendarType"] InternationalCode:[dic objectForKey:@"InternationalCode"] Name:
                              [dic objectForKey:@"Name"] NameAr:[dic objectForKey:@"NameAr"] Unit:[dic objectForKey:@"Unit"] Previous:[dic objectForKey:@"Previous"]];
        
        
       
        
        [temp setObject:tempevent forKey:tempevent.IdEcoCalendarDate ];
        
    }
    result=[[ NSDictionary alloc] initWithDictionary:temp];
    return result;
}
-(BOOL)InsertFeedsIntoDb :(NSDictionary *)DictFeed
{
   
    BOOL inserted;
    NSArray *allkeys=[DictFeed allKeys];
    NSMutableArray *allkeysint=[[NSMutableArray alloc] init];
    for(int j=0; j<allkeys.count;j++)
    {
        [allkeysint addObject:[NSNumber numberWithInt:[[allkeys objectAtIndex:j] intValue] ]];
    }
    allkeysint = [allkeysint sortedArrayUsingSelector:@selector(compare:)];
    for(NSInteger i=allkeysint.count-1  ;i>allkeysint.count-21;i--)
    {
        NSString *key=[NSString stringWithFormat:@"%d",[[allkeysint objectAtIndex:i] intValue]];
        FeedItem *feeditem=[DictFeed objectForKey:key];
        FileDbAdapter* fd = [[FileDbAdapter alloc] init];
        [fd openDB];
        inserted=[fd InsertFeed:feeditem];
        if(!inserted)
            return NO;
    }
    return inserted;
}

-(NSMutableArray *)GetFeeds
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
   return  [fd fetchfeeds];
}

-(NSMutableArray *)GetEvents :(NSString *)date
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
    return  [fd fetcheventsByDate:date];
}
-(NSMutableArray *)fetchAllCountries
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
    return [fd fetchCountriesFromEvents];
}
-(NSMutableArray *)fetchAllcountriesAr
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
    return [fd fetchCountriesARFromEvents];
}

-(NSMutableArray *)fetchCalendarType
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
    return [fd fetchCalendarType];
}
-(NSMutableArray *)fetchCalendarTypeAr
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
    return [fd fetchCalendarTypeAr];
}


-(NSMutableArray *)GetAllDatesFromEvents
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
    NSMutableArray *ListDates= [fd fetchAllDatesFromEvents];
    for(int i=0;i<ListDates.count;i++)
    {
        // Creating and configuring date formatter instance
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MMM/yyyy";
        NSDate *NowDate = [dateFormatter dateFromString:[ListDates objectAtIndex:i]];
        
        [ListDates replaceObjectAtIndex:i withObject:NowDate];
    }
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"self"
                                        ascending:YES];
    NSMutableArray*sortDescriptors = [NSMutableArray  arrayWithObject:dateDescriptor];
    NSMutableArray *sortedEventArray = [[ListDates
                                 sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    // sortedEventArray;
    for(int i=0;i<sortedEventArray.count;i++)
    {
        // Creating and configuring date formatter instance
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd/MMM/yyyy";
        NSString *NowDate = [dateFormatter stringFromDate:[sortedEventArray objectAtIndex:i]];
        
        [sortedEventArray replaceObjectAtIndex:i withObject:NowDate];
    }
    return sortedEventArray;
}
-(NSMutableArray *)GetAllNsDatesFromEvents
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
   NSMutableArray *ListDates= [fd fetchAllDatesFromEvents];
    for(int i=0;i<ListDates.count;i++)
    {
        // Creating and configuring date formatter instance
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyyMMdd";
        NSDate *NowDate = [dateFormatter dateFromString:[ListDates objectAtIndex:i]];
        
        [ListDates replaceObjectAtIndex:i withObject:NowDate];
    }
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                        sortDescriptorWithKey:@"startDateTime"
                                        ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
    NSMutableArray *sortedEventArray = [[ListDates
                                 sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
    return sortedEventArray;
}
#pragma Events
-(BOOL)InsertEventsIntoDb :(NSDictionary *)DictEvent
{
    
    BOOL inserted;
    NSArray *allkeys=[DictEvent allKeys];
    
    for(NSInteger i=0  ;i<allkeys.count;i++)
    {
        NSString *key=[NSString stringWithFormat:@"%@",[allkeys objectAtIndex:i]];
       EventItem *eventitem=[DictEvent objectForKey:key];
        FileDbAdapter* fd = [[FileDbAdapter alloc] init];
        [fd openDB];
        BOOL find=[fd FindEvent:eventitem.IdEcoCalendarDate];
        if (find) {
             [fd openDB];
            [fd updateEvent:eventitem.IdEcoCalendarDate Event:eventitem];
        }
        else
        {
        inserted=[fd InsertEvent:eventitem];
        }
        if(!inserted)
            return NO;
    }
    return inserted;
}

-(NSString *)fetchCalendarIDTypeByType:(NSString *)Type
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
    return [fd fetchCalendarIDTypeByType:Type];
}
- (NSString*) fetchCountryIDByCountry :(NSString *)country
{
    FileDbAdapter* fd = [[FileDbAdapter alloc] init];
    [fd openDB];
    return [fd fetchCountryIDByCountry:country];
}
-(void)StopConnection
{
    if(LLConnectionEvents)
    [LLConnectionEvents cancel];
    if(LLConnectionFeeds)
        [LLConnectionFeeds cancel];
}
@end
