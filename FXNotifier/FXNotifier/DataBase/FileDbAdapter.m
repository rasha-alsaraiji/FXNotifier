

#import "FileDbAdapter.h"
#import "sqlite3.h"
#import "MesssageItem.h"



@implementation FileDbAdapter

@synthesize databaseName;
@synthesize databasePath;


//sqlite3 *db;


//test ok
// Creates a writable copy of the bundled default database in the application Documents directory.
-(void)openDB {
	databaseName =@"forex.sqlite";
    // First, test for existence.
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
    BOOL success;
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    databasePath = [documentsDirectory stringByAppendingPathComponent:databaseName];
	//NSLog(@" app path path %@",databasePath);
    // Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
    // If the database already exists then return without doing anything
	if (success) return;
	// If not then proceed to copy the database from the application to the users filesystem
	// Get the path to the database in the application package
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    // Copy the database from the package to the users filesystem
	success = [fileManager copyItemAtPath:defaultDBPath toPath:databasePath error:&error];
    NSLog(@" resource path %@",defaultDBPath);
	
	if (!success) {
		NSLog(@"Copying database error:%@",error);
	}	
}
# pragma FeedsTable
//test ok
- (NSMutableArray *) fetchfeeds{
	sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
         FeedItem *feeditem =[[FeedItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select %@,%@,%@,%@,%@,%@,%@,%@,%@,%@ from tblfeeditems",feeditem.KEY_ROWID,feeditem.KEY_TITLE,feeditem.KEY_URL,feeditem.KEY_CATEGORYID,feeditem.KEY_CATEGORY,feeditem.KEY_FEEDID,feeditem.KEY_FEEDTITLE,feeditem.KEY_DETAILS,feeditem.KEY_THUMB,feeditem.KEY_DATETIME];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
				int _id =  sqlite3_column_int(stm, 0);
                
                NSString * _title = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)] copy];
                NSString * _url = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)] copy];
                int _idcategory =  sqlite3_column_int(stm, 3);
                 NSString * _category = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 4)] copy];
                int _idfeed =  sqlite3_column_int(stm, 5);
                 NSString * _feed = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 6)] copy];
                 NSString * _details = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 7)] copy];
                 NSString * _thumb = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 8)] copy];
                 NSString * _datetime = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 9)] copy];
                
                
                FeedItem *feeditem =[[FeedItem alloc] initWithvalues:_id title:_title url:_url categoryid:_idcategory category:_category feedid:_idfeed feedtitle:_feed details:_details thumb:_thumb datetime:_datetime];
                
                [arr addObject:feeditem];
			
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
	
}
- (NSMutableArray *) fetchAllDates
{
    sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        FeedItem *feeditem =[[FeedItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select DISTINCT %@ from tblfeeditems",feeditem.KEY_DATETIME];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
				
                NSString * _datetime = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 0)] copy];
                
                
                
                
                [arr addObject:_datetime];
                
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
    
}
- (NSMutableArray *) fetchfeedsByDate:(NSString *)date{
	sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
    	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        FeedItem *feeditem =[[FeedItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select %@,%@,%@,%@,%@,%@,%@,%@,%@,%@ from tblfeeditems where %@='%@' ",feeditem.KEY_ROWID,feeditem.KEY_TITLE,feeditem.KEY_URL,feeditem.KEY_CATEGORYID,feeditem.KEY_CATEGORY,feeditem.KEY_FEEDID,feeditem.KEY_FEEDTITLE,feeditem.KEY_DETAILS,feeditem.KEY_THUMB,feeditem.KEY_DATETIME,feeditem.KEY_DATETIME,date];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
				int _id =  sqlite3_column_int(stm, 0);
                
                NSString * _title = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)] copy];
                NSString * _url = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)] copy];
                int _idcategory =  sqlite3_column_int(stm, 3);
                NSString * _category = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 4)] copy];
                int _idfeed =  sqlite3_column_int(stm, 5);
                NSString * _feed = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 6)] copy];
                NSString * _details = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 7)] copy];
                NSString * _thumb = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 8)] copy];
                NSString * _datetime = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 9)] copy];
                
                
                FeedItem *feeditem =[[FeedItem alloc] initWithvalues:_id title:_title url:_url categoryid:_idcategory category:_category feedid:_idfeed feedtitle:_feed details:_details thumb:_thumb datetime:_datetime];
                
                [arr addObject:feeditem];
                
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
	
}
- (NSMutableArray *) fetchfeedByID:(int )idfeed{
	sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        FeedItem *feeditem =[[FeedItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select %@,%@,%@,%@,%@,%@,%@,%@,%@,%@ from tblfeeditems where %@=%d ",feeditem.KEY_ROWID,feeditem.KEY_TITLE,feeditem.KEY_URL,feeditem.KEY_CATEGORYID,feeditem.KEY_CATEGORY,feeditem.KEY_FEEDID,feeditem.KEY_FEEDTITLE,feeditem.KEY_DETAILS,feeditem.KEY_THUMB,feeditem.KEY_DATETIME,feeditem.KEY_ROWID,idfeed];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
				int _id =  sqlite3_column_int(stm, 0);
                
                NSString * _title = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)] copy];
                NSString * _url = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)] copy];
                int _idcategory =  sqlite3_column_int(stm, 3);
                NSString * _category = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 4)] copy];
                int _idfeed =  sqlite3_column_int(stm, 5);
                NSString * _feed = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 6)] copy];
                NSString * _details = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 7)] copy];
                NSString * _thumb = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 8)] copy];
                NSString * _datetime = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 9)] copy];
                
                
                FeedItem *feeditem =[[FeedItem alloc] initWithvalues:_id title:_title url:_url categoryid:_idcategory category:_category feedid:_idfeed feedtitle:_feed details:_details thumb:_thumb datetime:_datetime];
                
                [arr addObject:feeditem];
                
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
	
}
-(BOOL)InsertFeed :(FeedItem *)feeditem
{
    BOOL ret=YES;
    sqlite3 *db = nil;
    if(sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
             		const char * query= "Insert into tblfeeditems(fldTitle,fldUrl,fldCategoryId,fldCategory,fldFeedId,fldFeedTitle,fldDetails,fldThumb,fldDatetime) values(?,?,?,?,?,?,?,?,?)";
       
        		sqlite3_stmt *stm;
        		if (sqlite3_prepare_v2(db, query, -1, &stm, NULL) == SQLITE_OK) {
                 //   NSLog(@"Text %@",text);
        			//sqlite3_bind_text(stm, 1, [text UTF8String], -1, SQLITE_TRANSIENT);
       if(feeditem.TITLE)
        			sqlite3_bind_text(stm, 1, [feeditem.TITLE UTF8String], -1, SQLITE_TRANSIENT);
                     if(feeditem.URL)
        			sqlite3_bind_text(stm, 2, [feeditem.URL UTF8String], -1, SQLITE_TRANSIENT);
                    sqlite3_bind_int(stm, 3, feeditem.CATEGORYID);
                     if(feeditem.CATEGORY)
                    sqlite3_bind_text(stm, 4, [feeditem.CATEGORY UTF8String], -1, SQLITE_TRANSIENT);
        
                    sqlite3_bind_int(stm, 5, feeditem.FEEDID);
        if(feeditem.FEEDTITLE)
                    sqlite3_bind_text(stm, 6, [feeditem.FEEDTITLE UTF8String], -1, SQLITE_TRANSIENT);
         if(feeditem.DETAILS)
                   sqlite3_bind_text(stm, 7, [feeditem.DETAILS UTF8String], -1, SQLITE_TRANSIENT);
        if(feeditem.THUMB)
                   sqlite3_bind_text(stm, 8, [feeditem.THUMB UTF8String], -1, SQLITE_TRANSIENT);
                     if(feeditem.DATETIME)
                    sqlite3_bind_text(stm, 9, [feeditem.DATETIME UTF8String], -1, SQLITE_TRANSIENT);
        
                    
       		}
       		if (sqlite3_step(stm)!= SQLITE_DONE) {
        			ret = NO;
        			NSLog(@"Error while addFeed data. %s",sqlite3_errmsg(db));
       		} else {
       			sqlite3_last_insert_rowid(db);
        			NSLog(@"Insert addFeed success");
       		
       		}
       		sqlite3_finalize(stm);
        		sqlite3_close(db);
        	} else {
     	ret = NO;
       		NSLog(@"Error while addFeed data.");
               
        	}
        	return ret;

}
-(BOOL)DeleteAllOldFeeds:(NSMutableArray *)IdsList
{
    sqlite3 *database;
            BOOL retValue = YES;
    for(int i=0;i<IdsList.count;i++)
    {
        int id_=[[IdsList objectAtIndex:i] intValue];
            if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
                NSString* sql = [NSString stringWithFormat:@"Delete from tblfeeditems where _id=%d",id_];
                sqlite3_stmt *compiledStatement;
              retValue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &compiledStatement, NULL);
                if(SQLITE_DONE != sqlite3_step(compiledStatement))//add this line
                {
                    NSLog(@"Error while inserting data. '%s'", sqlite3_errmsg(database));
                   return NO;
               }
                sqlite3_finalize(compiledStatement);
            }
            sqlite3_close(database);
    
    }
          return retValue;
  
  

}

#pragma FetchEvents

- (NSMutableArray *) fetchevents{
	sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
    ListEffects=[[NSMutableArray alloc] initWithObjects:@"effect_no",@"effect_weak",@"effect_middle",@"effect_strong",nil];
    

    
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        EventItem *eventitem =[[EventItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select %@,%@,%@,%@,%@,%@,%@,%@,%@,%@ ,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@ ,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@ from event ",eventitem.KEY_id,eventitem.KEY_IdEcoCalendarType,eventitem.KEY_EcoCalendarType,eventitem.KEY_IdEcoCalendar,eventitem.KEY_IdEcoCalendarDate,eventitem.KEY_DateTime,eventitem.KEY_InternationalCode,eventitem.KEY_Country,eventitem.KEY_IdCountry,eventitem.KEY_Currency,eventitem.KEY_Name,eventitem.KEY_HTMLDescription,eventitem.KEY_Preliminar,eventitem.KEY_ForType,eventitem.KEY_For,eventitem.KEY_Volatility,eventitem.KEY_Unit,eventitem.KEY_Actual,eventitem.KEY_PotActual,eventitem.KEY_Consensus,eventitem.KEY_PotConsensus,eventitem.KEY_Relation,eventitem.KEY_Previous,eventitem.KEY_PotPrevious,eventitem.KEY_Revised,eventitem.KEY_DisplayActual,eventitem.KEY_DisplayPrevious,eventitem.KEY_DisplayConsensus,eventitem.KEY_DisplayRevised,eventitem.KEY_Precision,eventitem.KEY_EcoCalendarTypeAr,eventitem.KEY_CountryAr,eventitem.KEY_NameAr,eventitem.KEY_HTMLDescriptionAr
                            ];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
				int _id =  sqlite3_column_int(stm, 0);
                NSString * _country = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 7)] copy];
                
                NSUserDefaults  * Default= [NSUserDefaults standardUserDefaults];
                
                NSObject * countryCheck= [Default objectForKey:_country];
                if(!countryCheck)
                {
                    [Default setObject:[NSNumber numberWithBool:TRUE] forKey:_country];
                    
                }
                else
                {
                    NSNumber * ok=(NSNumber *)countryCheck;
                    if([ok intValue]==0)
                    {
                        continue;
                    }
                }

                
                int  _Volatility = sqlite3_column_int(stm, 15) ;

                NSString *effect=[ListEffects objectAtIndex:_Volatility];
                NSObject * effectCheck= [Default objectForKey:effect];
                
                if(!effectCheck)
                {
                    [Default setObject:[NSNumber numberWithBool:TRUE] forKey:effect];
                    
                }
                else
                {
                    NSNumber * ok=(NSNumber *)effectCheck;
                    if([ok intValue]==0)
                    {
                        continue;
                    }
                }
                
                
                NSString * _idcalendartype = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)] copy];
                NSString * _calendartype = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)] copy];
                NSString * _idcalendar =  [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 3)] copy];;
                NSString * _idcalendardate = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 4)] copy];
                NSString * _datetime =  [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 5)] copy];
                NSString * _internationalcode = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 6)] copy];
               // NSString * _country = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 7)] copy];
                NSString * _idcountry = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 8)] copy];
                NSString * _currency = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 9)] copy];
                NSString * _Name = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 10)] copy];
                NSString * _HtmlDescription = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 11)] copy];
                int  _Preliminar = sqlite3_column_int(stm, 12) ;
                
                
                NSString * _ForType=@"";
                if ( (char *) sqlite3_column_text(stm, 13)) {
                    _ForType =[[NSString stringWithUTF8String: (char *) sqlite3_column_text(stm, 13)] copy];
                }
                ;
                
                
                NSString * _For =@"";
                if ((char *) sqlite3_column_text(stm, 14)) {
                    _For=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 14)] copy] ;
                }
                
                
                
                NSString * _Unit =@"";
                if ((char *) sqlite3_column_text(stm, 16)) {
                    _Unit=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 16)] copy] ;
                }
                
                
                
                NSString * _Actual =@"";
                if ((char *) sqlite3_column_text(stm, 17)) {
                    _Actual=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 17)] copy] ;
                }
                
                
                NSString * _PotActual =@"";
                if ((char *) sqlite3_column_text(stm, 18)) {
                    _PotActual=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 18)] copy] ;
                }
                
                
                
                NSString * _Consensus =@"";
                if ((char *) sqlite3_column_text(stm, 19)) {
                    _Consensus=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 19)] copy] ;
                }
                
                NSString * _potConsensus =@"";
                if ((char *) sqlite3_column_text(stm, 20)) {
                    _potConsensus=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 20)] copy] ;
                }
                
                
                int _Relation = sqlite3_column_int(stm, 21);
                
                NSString * _previous =@"";
                if ((char *) sqlite3_column_text(stm, 22)) {
                    _previous=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 22)] copy] ;
                }
                
                NSString * _Potprevious =@"";
                if ((char *) sqlite3_column_text(stm, 23)) {
                    _Potprevious=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 23)] copy] ;
                }
                
                
                NSString * _Revised =@"";
                if ((char *) sqlite3_column_text(stm, 24)) {
                    _Revised=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 24)] copy] ;
                }
                
                NSString * _DisplayActual =@"";
                if ((char *) sqlite3_column_text(stm, 25)) {
                    _DisplayActual=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 25)] copy] ;
                }
                
                NSString * _DisplayPrevious =@"";
                if ((char *) sqlite3_column_text(stm, 26)) {
                    _DisplayPrevious=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 26)] copy] ;
                }
                
                
                NSString * _DisplayConsensus =@"";
                if ((char *) sqlite3_column_text(stm, 27)) {
                    _DisplayConsensus=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 27)] copy] ;
                }
                
                
                
                NSString * _DisplayRevised =@"";
                if ((char *) sqlite3_column_text(stm, 28)) {
                    _DisplayRevised=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 28)] copy] ;
                }
                
                
                
                
                
                
                int  _Precision = sqlite3_column_int(stm, 29);
                
                NSString * _EcoCalendarTypeAr =@"";
                if ((char *) sqlite3_column_text(stm, 30)) {
                    _EcoCalendarTypeAr=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 30)] copy] ;
                }
                
                NSString * _CountryAr =@"";
                if ((char *) sqlite3_column_text(stm, 31)) {
                    _CountryAr=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 31)] copy] ;
                }
                
                
                NSString * _NameAr =@"";
                if ((char *) sqlite3_column_text(stm, 32)) {
                    _NameAr=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 32)] copy] ;
                }
                
                NSString * _HTMLDescriptionAr =@"";
                if ((char *) sqlite3_column_text(stm, 33)) {
                    _HTMLDescriptionAr=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 33)] copy] ;
                }
                
                EventItem *eventitem=[[EventItem alloc] initWithvalues:_id Volatility:_Volatility Relation:_Relation Revised:_Revised PotActual:_PotActual PotConsensus:_potConsensus PotPrevious:_Potprevious Precision:_Precision Preliminar:_Preliminar Actual:_Actual Consensus:_Consensus Country:_country CountryAr:_CountryAr Currency:_currency DateTime:_datetime DisplayActual:_DisplayActual DisplayConsensus:_DisplayConsensus DisplayPrevious:_DisplayPrevious DisplayRevised:_DisplayRevised EcoCalendarType:_calendartype EcoCalendarTypeAr:_EcoCalendarTypeAr For:_For ForType:_ForType HTMLDescription:_HtmlDescription HTMLDescriptionAr:_HTMLDescriptionAr IdCountry:_idcountry IdEcoCalendar:_idcalendar IdEcoCalendarDate:_idcalendardate IdEcoCalendarType:_idcalendartype InternationalCode:_internationalcode Name:_Name NameAr:_NameAr Unit:_Unit Previous:_previous];
                
                [arr addObject:eventitem];
                
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
}
- (NSMutableArray *) fetchCountriesFromEvents
{
    sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        EventItem *eventitem =[[EventItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select DISTINCT %@ from event",eventitem.KEY_Country];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
                //
                char *IntCode=(char *) sqlite3_column_text(stm, 0);
                NSString * _IntCode=@"";
                if(IntCode)
                {
                    _IntCode = [[NSString stringWithUTF8String:IntCode] copy];
                  
                    
                }
                NSLog(@" ........%@ .............",_IntCode);
                //
                //
                //
                //
                if(_IntCode)
                    [arr addObject:_IntCode];
                //
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
    
}
- (NSMutableArray *) fetchCountriesARFromEvents
{
    sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        EventItem *eventitem =[[EventItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select DISTINCT %@ from event",eventitem.KEY_CountryAr];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
                //
                char *IntCode=(char *) sqlite3_column_text(stm, 0);
                NSString * _IntCode=@"";
                if(IntCode)
                {
                    _IntCode = [[NSString stringWithUTF8String:IntCode] copy];
                    
                    
                }
                NSLog(@" ........%@ .............",_IntCode);
                //
                //
                //
                //
                if(_IntCode)
                    [arr addObject:_IntCode];
                //
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
    
}
- (NSString*) fetchCountryIDByCountry :(NSString *)country
{
    sqlite3 * database=nil;
    NSString * _IntCode=@"";
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        EventItem *eventitem =[[EventItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select DISTINCT %@ from event where %@='%@'"  ,eventitem.KEY_IdCountry,eventitem.KEY_Country,country];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
                //
                char *IntCode=(char *) sqlite3_column_text(stm, 0);
                
                if(IntCode)
                {
                    _IntCode = [[NSString stringWithUTF8String:IntCode] copy];
                    
                    
                }
                NSLog(@" ........%@ .............",_IntCode);
                //
                //
                //
                //
                
                //
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return _IntCode;
    
}


- (NSString*) fetchCalendarIDTypeByType :(NSString *)Type
{
    sqlite3 * database=nil;
	  NSString * _IntCode=@"";
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        EventItem *eventitem =[[EventItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select DISTINCT %@ from event where %@='%@'"  ,eventitem.KEY_IdEcoCalendarType,eventitem.KEY_EcoCalendarType,Type];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
                //
                char *IntCode=(char *) sqlite3_column_text(stm, 0);
                
                if(IntCode)
                {
                    _IntCode = [[NSString stringWithUTF8String:IntCode] copy];
                    
                    
                }
                NSLog(@" ........%@ .............",_IntCode);
                //
                //
                //
                //
                
                //
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return _IntCode;
    
}


- (NSMutableArray *) fetchCalendarType
{
    sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        EventItem *eventitem =[[EventItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select DISTINCT %@ from event",eventitem.KEY_EcoCalendarType];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
                //
                char *IntCode=(char *) sqlite3_column_text(stm, 0);
                NSString * _IntCode=@"";
                if(IntCode)
                {
                    _IntCode = [[NSString stringWithUTF8String:IntCode] copy];
                    
                    
                }
                NSLog(@" ........%@ .............",_IntCode);
                //
                //
                //
                //
                if(_IntCode)
                    [arr addObject:_IntCode];
                //
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
    
}

- (NSMutableArray *) fetchCalendarTypeAr
{
    sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        EventItem *eventitem =[[EventItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select DISTINCT %@ from event",eventitem.KEY_EcoCalendarTypeAr];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
                //
                char *IntCode=(char *) sqlite3_column_text(stm, 0);
                NSString * _IntCode=@"";
                if(IntCode)
                {
                    _IntCode = [[NSString stringWithUTF8String:IntCode] copy];
                    
                    
                }
                NSLog(@" ........%@ .............",_IntCode);
                //
                //
                //
                //
                if(_IntCode)
                    [arr addObject:_IntCode];
                //
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
    
}


- (NSMutableArray *) fetcheventsByDate :(NSString *)date{
	sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
    ListEffects=[[NSMutableArray alloc] initWithObjects:@"effect_no",@"effect_weak",@"effect_middle",@"effect_strong",nil];
    
    
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        EventItem *eventitem =[[EventItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select %@,%@,%@,%@,%@,%@,%@,%@,%@,%@ ,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@ ,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@ from event where %@ LIKE '%@%%' ",eventitem.KEY_id,eventitem.KEY_IdEcoCalendarType,eventitem.KEY_EcoCalendarType,eventitem.KEY_IdEcoCalendar,eventitem.KEY_IdEcoCalendarDate,eventitem.KEY_DateTime,eventitem.KEY_InternationalCode,eventitem.KEY_Country,eventitem.KEY_IdCountry,eventitem.KEY_Currency,eventitem.KEY_Name,eventitem.KEY_HTMLDescription,eventitem.KEY_Preliminar,eventitem.KEY_ForType,eventitem.KEY_For,eventitem.KEY_Volatility,eventitem.KEY_Unit,eventitem.KEY_Actual,eventitem.KEY_PotActual,eventitem.KEY_Consensus,eventitem.KEY_PotConsensus,eventitem.KEY_Relation,eventitem.KEY_Previous,eventitem.KEY_PotPrevious,eventitem.KEY_Revised,eventitem.KEY_DisplayActual,eventitem.KEY_DisplayPrevious,eventitem.KEY_DisplayConsensus,eventitem.KEY_DisplayRevised,eventitem.KEY_Precision,eventitem.KEY_EcoCalendarTypeAr,eventitem.KEY_CountryAr,eventitem.KEY_NameAr,eventitem.KEY_HTMLDescriptionAr
                      ,eventitem.KEY_DateTime,date   ];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
				int _id =  sqlite3_column_int(stm, 0);
                 NSString * _country = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 7)] copy];
                
              NSUserDefaults  * Default= [NSUserDefaults standardUserDefaults];
                
              NSObject * countryCheck= [Default objectForKey:_country];
                if(!countryCheck)
                {
                    [Default setObject:[NSNumber numberWithBool:TRUE] forKey:_country];
                   
                }
                else
                {
                    NSNumber * ok=(NSNumber *)countryCheck;
                    if([ok intValue]==0)
                    {
                        continue;
                    }
                        
                       
                    
                       
                }
                

                int  _Volatility = sqlite3_column_int(stm, 15) ;
                
                NSString *effect=[ListEffects objectAtIndex:_Volatility];
                NSObject * effectCheck= [Default objectForKey:effect];
                
                if(!effectCheck)
                {
                    [Default setObject:[NSNumber numberWithBool:TRUE] forKey:effect];
                    
                }
                else
                {
                    NSNumber * ok=(NSNumber *)effectCheck;
                    if([ok intValue]==0)
                    {
                        continue;
                    }
                }
                

                
                
                
                NSString * _idcalendartype = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)] copy];
                NSString * _calendartype = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)] copy];
                NSString * _idcalendar =  [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 3)] copy];;
                NSString * _idcalendardate = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 4)] copy];
                NSString * _datetime =  [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 5)] copy];
                NSString * _internationalcode = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 6)] copy];
               
                NSString * _idcountry = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 8)] copy];
                NSString * _currency = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 9)] copy];
                NSString * _Name = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 10)] copy];
                NSString * _HtmlDescription = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 11)] copy];
                int  _Preliminar = sqlite3_column_int(stm, 12) ;
                
              
                NSString * _ForType=@"";
                if ( (char *) sqlite3_column_text(stm, 13)) {
                    _ForType =[[NSString stringWithUTF8String: (char *) sqlite3_column_text(stm, 13)] copy];
                }
                 ;
                
           
                NSString * _For =@"";
                if ((char *) sqlite3_column_text(stm, 14)) {
                    _For=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 14)] copy] ;
                }
                
                
             //   int  _Volatility = sqlite3_column_int(stm, 15) ;
                
                NSString * _Unit =@"";
                if ((char *) sqlite3_column_text(stm, 16)) {
                    _Unit=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 16)] copy] ;
                }
                
               
                
                NSString * _Actual =@"";
                if ((char *) sqlite3_column_text(stm, 17)) {
                    _Actual=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 17)] copy] ;
                }
               
                
                NSString * _PotActual =@"";
                if ((char *) sqlite3_column_text(stm, 18)) {
                    _PotActual=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 18)] copy] ;
                }
                
               
               
                NSString * _Consensus =@"";
                if ((char *) sqlite3_column_text(stm, 19)) {
                    _Consensus=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 19)] copy] ;
                }
              
                NSString * _potConsensus =@"";
                if ((char *) sqlite3_column_text(stm, 20)) {
                    _potConsensus=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 20)] copy] ;
                }
               
                
                int _Relation = sqlite3_column_int(stm, 21);
                
                NSString * _previous =@"";
                if ((char *) sqlite3_column_text(stm, 22)) {
                   _previous=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 22)] copy] ;
                }
                
                NSString * _Potprevious =@"";
                if ((char *) sqlite3_column_text(stm, 23)) {
                   _Potprevious=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 23)] copy] ;
                }
                
                
                NSString * _Revised =@"";
                if ((char *) sqlite3_column_text(stm, 24)) {
                    _Revised=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 24)] copy] ;
                }
                
                NSString * _DisplayActual =@"";
                if ((char *) sqlite3_column_text(stm, 25)) {
                    _DisplayActual=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 25)] copy] ;
                }
               
                NSString * _DisplayPrevious =@"";
                if ((char *) sqlite3_column_text(stm, 26)) {
                    _DisplayPrevious=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 26)] copy] ;
                }
                
              
                NSString * _DisplayConsensus =@"";
                if ((char *) sqlite3_column_text(stm, 27)) {
                    _DisplayConsensus=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 27)] copy] ;
                }
                
             
                
                NSString * _DisplayRevised =@"";
                if ((char *) sqlite3_column_text(stm, 28)) {
                    _DisplayRevised=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 28)] copy] ;
                }

                
                
                
             
                
                int  _Precision = sqlite3_column_int(stm, 29);
                
                NSString * _EcoCalendarTypeAr =@"";
                if ((char *) sqlite3_column_text(stm, 30)) {
                   _EcoCalendarTypeAr=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 30)] copy] ;
                }
                
                NSString * _CountryAr =@"";
                if ((char *) sqlite3_column_text(stm, 31)) {
                   _CountryAr=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 31)] copy] ;
                }

                
                NSString * _NameAr =@"";
                if ((char *) sqlite3_column_text(stm, 32)) {
                   _NameAr=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 32)] copy] ;
                }
                
                NSString * _HTMLDescriptionAr =@"";
                if ((char *) sqlite3_column_text(stm, 33)) {
                    _HTMLDescriptionAr=   [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 33)] copy] ;
                }
                
                EventItem *eventitem=[[EventItem alloc] initWithvalues:_id Volatility:_Volatility Relation:_Relation Revised:_Revised PotActual:_PotActual PotConsensus:_potConsensus PotPrevious:_Potprevious Precision:_Precision Preliminar:_Preliminar Actual:_Actual Consensus:_Consensus Country:_country CountryAr:_CountryAr Currency:_currency DateTime:_datetime DisplayActual:_DisplayActual DisplayConsensus:_DisplayConsensus DisplayPrevious:_DisplayPrevious DisplayRevised:_DisplayRevised EcoCalendarType:_calendartype EcoCalendarTypeAr:_EcoCalendarTypeAr For:_For ForType:_ForType HTMLDescription:_HtmlDescription HTMLDescriptionAr:_HTMLDescriptionAr IdCountry:_idcountry IdEcoCalendar:_idcalendar IdEcoCalendarDate:_idcalendardate IdEcoCalendarType:_idcalendartype InternationalCode:_internationalcode Name:_Name NameAr:_NameAr Unit:_Unit Previous:_previous];
                
                [arr addObject:eventitem];
                
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
	
}
-(BOOL)FindEvent :(NSString *)IdEcoDate
{
   
        sqlite3 * database=nil;
    BOOL IsFound=FALSE;
        if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
            EventItem *eventitem =[[EventItem alloc] initWithKeys];
            NSString *sql = [NSString stringWithFormat:@"select %@ from event  where %@='%@'",eventitem.KEY_IdEcoCalendarDate,eventitem.KEY_IdEcoCalendarDate,IdEcoDate];
            
            sqlite3_stmt *stm;
            
            if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
                
                while (sqlite3_step(stm)==SQLITE_ROW) {
                    
                  
                    NSString * _idcalendardate = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 0)] copy];
                    IsFound=YES;
                }
                
            }
            else {
                NSLog(@"fetchAvailableUploadFiles#Error");
            }
            sqlite3_close(database);
        }
        return  IsFound;
    

}
- (NSMutableArray *) fetchAllDatesFromEvents
{
    sqlite3 * database=nil;
	NSMutableArray *arr = [[NSMutableArray alloc]init];
	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
        EventItem *eventitem =[[EventItem alloc] initWithKeys];
		NSString *sql = [NSString stringWithFormat:@"select DISTINCT substr( %@, 1, 8) from event",eventitem.KEY_DateTime];
        
		sqlite3_stmt *stm;
		
		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
			
			while (sqlite3_step(stm)==SQLITE_ROW) {
                
//
                char *date=(char *) sqlite3_column_text(stm, 0);
                 NSString * _datetime=@"";
                if(date)
                {
                       _datetime = [[NSString stringWithUTF8String:date] copy];
                    _datetime=[self FormatDateToForm2:_datetime];
                    
                }
                NSLog(@" ........%@ .............",_datetime);
//
//                
//                
//
                if(_datetime)
               [arr addObject:_datetime];
//                
            }
			
		} else {
			NSLog(@"fetchAvailableUploadFiles#Error");
		}
		sqlite3_close(database);
	}
	return arr;
    
}
- (void) updateEvent:(NSString *)EcoDate  Event:(EventItem *)eventitem_ {
  sqlite3 *sqlite;
     EventItem *eventitem =[[EventItem alloc] initWithKeys];
//    NSString *db_path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"e3rab_final.sqlite"];
    if (sqlite3_open([databasePath UTF8String], &sqlite) != SQLITE_OK)
        return;
    
    NSString *query = [NSString stringWithFormat:@"update event set %@ = %@ ,%@ = %@ ,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %d,%@ = %@,%@ = %@,%@ = %d,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %d,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %@,%@ = %d,%@ = %@,%@ = %@,%@ = %@,%@ = %@ where %@ = '%@'",
                       eventitem.KEY_IdEcoCalendarType,eventitem_.IdEcoCalendarType,eventitem.KEY_EcoCalendarType,eventitem_.EcoCalendarType,eventitem.KEY_IdEcoCalendar,eventitem_.IdEcoCalendar,eventitem.KEY_IdEcoCalendarDate,eventitem_.IdEcoCalendarDate,eventitem.KEY_DateTime,eventitem_.DateTime,eventitem.KEY_InternationalCode,eventitem_.InternationalCode,eventitem.KEY_Country,eventitem_.Country,eventitem.KEY_IdCountry,eventitem_.IdCountry,eventitem.KEY_Currency,eventitem_.Currency
                       ,eventitem.KEY_Name,eventitem_.Name,eventitem.KEY_HTMLDescription,eventitem_.HTMLDescription,eventitem.KEY_Preliminar,eventitem_.Preliminar,eventitem.KEY_ForType,eventitem_.ForType,eventitem.KEY_For,eventitem_.For,eventitem.KEY_Volatility,eventitem_.Volatility,eventitem.KEY_Unit,eventitem_.Unit,eventitem.KEY_Actual,eventitem_.Actual,eventitem.KEY_PotActual,eventitem_.PotActual,eventitem.KEY_Consensus,eventitem_.Consensus,eventitem.KEY_PotConsensus,eventitem_.PotConsensus,eventitem.KEY_Relation,eventitem_.Relation,eventitem.KEY_Previous,eventitem_.Previous,eventitem.KEY_PotPrevious,eventitem_.PotPrevious,eventitem.KEY_Revised,eventitem_.Revised,eventitem.KEY_DisplayActual,eventitem_.DisplayActual,eventitem.KEY_DisplayPrevious,eventitem_.DisplayPrevious,eventitem.KEY_DisplayConsensus,eventitem_.DisplayConsensus,eventitem.KEY_DisplayRevised,eventitem_.DisplayRevised,eventitem.KEY_Precision,eventitem_.Precision,eventitem.KEY_EcoCalendarTypeAr,eventitem_.EcoCalendarTypeAr,eventitem.KEY_CountryAr,eventitem_.CountryAr,eventitem.KEY_NameAr,eventitem_.NameAr,eventitem.KEY_HTMLDescriptionAr,eventitem_.HTMLDescriptionAr, eventitem.KEY_IdEcoCalendarDate, EcoDate];
    sqlite3_exec(sqlite, [query UTF8String], NULL, NULL, NULL);
    
    sqlite3_close(sqlite);
}


-(BOOL)InsertEvent :(EventItem *)eventitem_
{
    BOOL ret=YES;
    sqlite3 *db = nil;
     EventItem *eventitem =[[EventItem alloc] initWithKeys];
    if(sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) {
       NSString * query=[NSString stringWithFormat:@"Insert into event(%@,%@,%@,%@,%@,%@,%@,%@,%@ ,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@ ,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@ ) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",eventitem.KEY_IdEcoCalendarType,eventitem.KEY_EcoCalendarType,eventitem.KEY_IdEcoCalendar,eventitem.KEY_IdEcoCalendarDate,eventitem.KEY_DateTime,eventitem.KEY_InternationalCode,eventitem.KEY_Country,eventitem.KEY_IdCountry,eventitem.KEY_Currency,eventitem.KEY_Name,eventitem.KEY_HTMLDescription,eventitem.KEY_Preliminar,eventitem.KEY_ForType,eventitem.KEY_For,eventitem.KEY_Volatility,eventitem.KEY_Unit,eventitem.KEY_Actual,eventitem.KEY_PotActual,eventitem.KEY_Consensus,eventitem.KEY_PotConsensus,eventitem.KEY_Relation,eventitem.KEY_Previous,eventitem.KEY_PotPrevious,eventitem.KEY_Revised,eventitem.KEY_DisplayActual,eventitem.KEY_DisplayPrevious,eventitem.KEY_DisplayConsensus,eventitem.KEY_DisplayRevised,eventitem.KEY_Precision,eventitem.KEY_EcoCalendarTypeAr,eventitem.KEY_CountryAr,eventitem.KEY_NameAr,eventitem.KEY_HTMLDescriptionAr
         ];

        
       
        
        sqlite3_stmt *stm;
        if (sqlite3_prepare_v2(db, [query UTF8String], -1, &stm, NULL) == SQLITE_OK) {
            //   NSLog(@"Text %@",text);
            //sqlite3_bind_text(stm, 1, [text UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.IdEcoCalendarType)
                sqlite3_bind_text(stm, 1, [eventitem_.IdEcoCalendarType UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.EcoCalendarType)
                sqlite3_bind_text(stm, 2, [eventitem_.EcoCalendarType UTF8String], -1, SQLITE_TRANSIENT);

            if(eventitem_.IdEcoCalendar)
                sqlite3_bind_text(stm, 3, [eventitem_.IdEcoCalendar UTF8String], -1, SQLITE_TRANSIENT);

            if(eventitem_.IdEcoCalendarDate)
                sqlite3_bind_text(stm, 4, [eventitem_.IdEcoCalendarDate UTF8String], -1, SQLITE_TRANSIENT);

            if(eventitem_.DateTime)
                sqlite3_bind_text(stm, 5, [eventitem_.DateTime UTF8String], -1, SQLITE_TRANSIENT);
            
            if(eventitem_.InternationalCode)
                sqlite3_bind_text(stm, 6, [eventitem_.InternationalCode UTF8String], -1, SQLITE_TRANSIENT);

            if(eventitem_.Country)
                sqlite3_bind_text(stm, 7, [eventitem_.Country UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.IdCountry)
                sqlite3_bind_text(stm,8, [eventitem_.IdCountry UTF8String], -1, SQLITE_TRANSIENT);

            if(eventitem_.Currency)
                sqlite3_bind_text(stm, 9, [eventitem_.Currency UTF8String], -1, SQLITE_TRANSIENT);
            
            if(eventitem_.Name)
                sqlite3_bind_text(stm, 10, [eventitem_.Name UTF8String], -1, SQLITE_TRANSIENT);
            
            if(eventitem_.HTMLDescription)
                sqlite3_bind_text(stm, 11, [eventitem_.HTMLDescription UTF8String], -1, SQLITE_TRANSIENT);
            
            if(eventitem_.Preliminar)
                sqlite3_bind_int(stm, 12, eventitem_.Preliminar);
            
            if(eventitem_.ForType)
                sqlite3_bind_text(stm, 13, [eventitem_.ForType UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.For)
                sqlite3_bind_text(stm, 14, [eventitem_.For UTF8String], -1, SQLITE_TRANSIENT);
            
            if(eventitem_.Volatility)
                sqlite3_bind_int(stm, 15, eventitem_.Volatility);
            
            if(eventitem_.Unit)
                sqlite3_bind_text(stm, 16, [eventitem_.Unit UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.Actual)
                sqlite3_bind_text(stm, 17, [eventitem_.Actual UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.PotActual)
                sqlite3_bind_text(stm, 18, [eventitem_.PotActual UTF8String], -1, SQLITE_TRANSIENT);
            
            
            if(eventitem_.Consensus)
                sqlite3_bind_text(stm, 19, [eventitem_.Consensus UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.PotConsensus)
                sqlite3_bind_text(stm, 20, [eventitem_.PotConsensus UTF8String], -1, SQLITE_TRANSIENT);
            
            if(eventitem_.Relation)
                sqlite3_bind_int(stm, 21, eventitem_.Relation );
            if(eventitem_.Previous)
                sqlite3_bind_text(stm, 22 ,[eventitem_.Previous UTF8String], -1, SQLITE_TRANSIENT);

            if(eventitem_.PotPrevious)
                sqlite3_bind_text(stm, 23 ,[eventitem_.PotPrevious UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.Revised)
                sqlite3_bind_text(stm, 24 ,[eventitem_.Revised UTF8String], -1, SQLITE_TRANSIENT);
            
            if(eventitem_.DisplayActual)
                sqlite3_bind_text(stm, 25 ,[eventitem_.DisplayActual UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.DisplayPrevious)
                sqlite3_bind_text(stm, 26 ,[eventitem_.DisplayPrevious UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.DisplayConsensus)
                sqlite3_bind_text(stm, 27 ,[eventitem_.DisplayConsensus UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.DisplayRevised)
                sqlite3_bind_text(stm, 28 ,[eventitem_.DisplayRevised UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.Precision  )
                sqlite3_bind_int(stm, 29 ,eventitem_.Precision);
            
            if(eventitem_.EcoCalendarTypeAr)
                sqlite3_bind_text(stm, 30 ,[eventitem_.EcoCalendarTypeAr UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.CountryAr)
                sqlite3_bind_text(stm, 31 ,[eventitem_.CountryAr UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.NameAr)
                sqlite3_bind_text(stm, 32 ,[eventitem_.NameAr UTF8String], -1, SQLITE_TRANSIENT);
            if(eventitem_.HTMLDescriptionAr)
                sqlite3_bind_text(stm, 33 ,[eventitem_.HTMLDescriptionAr  UTF8String], -1, SQLITE_TRANSIENT);
            
           
            
            
        }
        if (sqlite3_step(stm)!= SQLITE_DONE) {
            ret = NO;
            NSLog(@"Error while addevent data. %s",sqlite3_errmsg(db));
        } else {
            sqlite3_last_insert_rowid(db);
            NSLog(@"Insert addevent success");
       		
        }
        sqlite3_finalize(stm);
        sqlite3_close(db);
    } else {
     	ret = NO;
        NSLog(@"Error while addevent data.");
        
    }
    return ret;
    
}

-(NSString *)FormatDateToForm2 :(NSString *)date
{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    NSDate *yourDate = [dateFormatter dateFromString:date];
    dateFormatter.dateFormat = @"dd/MMM/yyyy";
    return [ dateFormatter stringFromDate:yourDate];
}
//- (NSMutableArray *) fetchDataSQL:(NSString*) sql{
//	sqlite3 * database=nil;
//	NSMutableArray *arr = [[NSMutableArray alloc]init];
//	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
//		
//		sqlite3_stmt *stm;
//		
//		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
//			
//			while (sqlite3_step(stm)==SQLITE_ROW) {
//                ConverInfo *info =[[ConverInfo alloc] init];
//				NSString * _id = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 0)] copy];
//                //NSString * _convertText = [NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)];
//                NSString * _text = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)] copy];
//                NSString * _description = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)] copy];
//                NSString * _bookmark = nil;
//                if(sqlite3_column_text(stm, 3) != nil)
//                    _bookmark = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 3)] copy];
//                [info setID:_id];
//                //[info setConverText:_convertText];
//                [info setText:_text];
//                [info setDesciption:_description];
//                [info setBookmark:_bookmark];
//				[arr addObject:info];
//			}
//			
//		} else {
//			NSLog(@"fetchAvailableUploadFiles#Error");
//		}
//		sqlite3_close(database);
//	}
//	return arr;
//	
//}
//
//
//
//- (NSMutableArray *) fetchTableInfo 
//{
//    sqlite3 * database=nil;
//	NSMutableArray *arr = [[NSMutableArray alloc]init];
//	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
//		const char *sql = "select ID, TableName ,Image_net,Image,Xml from TableInfo";
//		sqlite3_stmt *stm;
//		
//		if(sqlite3_prepare_v2(database,sql, -1, &stm, NULL) == SQLITE_OK){
//			
//			while (sqlite3_step(stm)==SQLITE_ROW) {
//                TableInfo *info =[[TableInfo alloc] init];
//				NSString * _id = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 0)] copy];
//                NSString * _tableName = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)] copy];
//                NSString *_image_net=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)] copy];
//                 NSString *_image=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 3)] copy];
//                 NSString *_xml=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 4)] copy];
//                
//                [info setID:_id];
//                [info setTableName:_tableName];
//                [info setImage_net:_image_net];
//                [info setImage:_image];
//                [info setXml:_xml];
//                
//				[arr addObject:info];
//                [info release];
//			}
//			
//		} else {
//			NSLog(@"fetchAvailableUploadFiles#Error");
//		}
//		sqlite3_close(database);
//	}
//	return arr;
//}
//
//- (NSMutableArray *) fetchAll_AppTable
//{
//    formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"]; 
//    
//    //Optionally for time zone converstions
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
//    
//    
//    
//    sqlite3 * database=nil;
//	NSMutableArray *arr = [[NSMutableArray alloc]init];
//	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
//        NSString *sql=[NSString stringWithFormat:@"select ID, name,description,iconPath,shortName,isNew,isPortrate,fullVersionLink,firstButtonText,DataModified,IsSoon,Image1,Image2,Image3,Image4,Image5,CategorID,FreeUrlLink,SecondButtontext from AppTable"];		
//		sqlite3_stmt *stm;
//		
//		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
//			
//			while (sqlite3_step(stm)==SQLITE_ROW) {
//                app *info =[[app alloc] init];
//				int _id =  sqlite3_column_int(stm, 0) ;
//                NSString * _Name = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)] copy];
//                NSString *_description=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)] copy];
//                NSString *_iconpath=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 3)] copy];
//                NSString *_shortname=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 4)] copy];
//                NSString *_isnew=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm,5)] copy];
//                NSString *_isport=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 6)] copy];
//                NSString *_fullVersionLink=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 7)] copy];
//                NSString *_firstButtonText=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 8)] copy];
//                NSString *_DataModified=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 9)] copy];
//                
//                NSString *_IsSoon=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 10)] copy];
//                
//                ImageAndData *imageAndData;
//                info.images=[[NSMutableArray alloc] init];
//                NSString *_Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 11)] copy];
//                
//                
//                imageAndData =[[ImageAndData alloc] init];
//                imageAndData.imageUrl=_Image1;
//                
//                [info.images addObject:imageAndData];
//                _Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 12)] copy];
//                imageAndData =[[ImageAndData alloc] init];
//                imageAndData.imageUrl=_Image1;
//                
//                [info.images addObject:imageAndData];
//                
//                
//                _Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 13)] copy];
//                imageAndData =[[ImageAndData alloc] init];
//                imageAndData.imageUrl=_Image1;
//                
//                [info.images addObject:imageAndData];
//                
//                char *c=(char *)sqlite3_column_text(stm, 14);
//                if( c)
//                {
//                    _Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 14)] copy];
//                    imageAndData =[[ImageAndData alloc] init];
//                    imageAndData.imageUrl=_Image1;
//                    
//                    [info.images addObject:imageAndData];
//                }
//                char *c2=(char *)sqlite3_column_text(stm, 15);
//                if( c2)
//                {
//                    _Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 15)] copy];
//                    imageAndData =[[ImageAndData alloc] init];
//                    imageAndData.imageUrl=_Image1;
//                    
//                    [info.images addObject:imageAndData];
//                }
//                
//                int category=sqlite3_column_int(stm, 16);
//                char *c3=(char *)sqlite3_column_text(stm, 17);
//                if( c3)
//                {
//                    info.freeDownloadLink=[[NSString stringWithUTF8String:c3] copy];
//                }
//                char *c4=(char *)sqlite3_column_text(stm, 18);
//                if( c4)
//                {
//                    info.button2Text=[[NSString stringWithUTF8String:c4] copy];
//                }
//                
//                info.id_=_id;
//                info.name=_Name;
//                info.isSoon=[_IsSoon boolValue];
//                info.description=_description;
//                info.iconInfo.imageUrl=_iconpath;
//                info.shortName=_shortname;
//                info.isNew=[_isnew boolValue];
//                info.isPortrate=[_isport boolValue];
//                info.fullVersionLink=_fullVersionLink;
//                info.button1Text=_firstButtonText;
//                info.date = [formatter dateFromString:_DataModified];
//                
//                
//				[arr addObject:info];
//                [info release];
//                
//			}
//			
//		} else {
//			NSLog(@"fetchAvailableUploadFiles#Error");
//		}
//		sqlite3_close(database);
//	}
//    [formatter release];
//	return arr;
//}
//- (NSMutableArray *) fetchAppTable:(int)categoryId
//{
//    formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"]; 
//    
//    //Optionally for time zone converstions
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
//    
//  
//    
//    sqlite3 * database=nil;
//	NSMutableArray *arr = [[NSMutableArray alloc]init];
//	if (sqlite3_open([databasePath UTF8String], &database)==SQLITE_OK) {
//        NSString *sql=[NSString stringWithFormat:@"select ID, name,description,iconPath,shortName,isNew,isPortrate,fullVersionLink,firstButtonText,DataModified,IsSoon,Image1,Image2,Image3,Image4,Image5,FreeUrlLink,SecondButtontext from AppTable where CategorID=%d",categoryId];
//
//		
//		sqlite3_stmt *stm;
//		
//		if(sqlite3_prepare_v2(database,[sql UTF8String], -1, &stm, NULL) == SQLITE_OK){
//			
//			while (sqlite3_step(stm)==SQLITE_ROW) {
//                app *info =[[app alloc] init];
//				int _id =  sqlite3_column_int(stm, 0) ;
//                NSString * _Name = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 1)] copy];
//                NSString *_description=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 2)] copy];
//                NSString *_iconpath=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 3)] copy];
//                NSString *_shortname=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 4)] copy];
//                 NSString *_isnew=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm,5)] copy];
//                 NSString *_isport=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 6)] copy];
//                 NSString *_fullVersionLink=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 7)] copy];
//                 NSString *_firstButtonText=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 8)] copy];
//                 NSString *_DataModified=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 9)] copy];
//                
//                 NSString *_IsSoon=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 10)] copy];
//               
//                ImageAndData *imageAndData;
//                info.images=[[NSMutableArray alloc] init];
//                 NSString *_Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 11)] copy];
//                
//                
//                imageAndData =[[ImageAndData alloc] init];
//                imageAndData.imageUrl=_Image1;
//                
//                [info.images addObject:imageAndData];
//                 _Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 12)] copy];
//                imageAndData =[[ImageAndData alloc] init];
//                imageAndData.imageUrl=_Image1;
//                
//                [info.images addObject:imageAndData];
//                
//                
//                 _Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 13)] copy];
//                imageAndData =[[ImageAndData alloc] init];
//                imageAndData.imageUrl=_Image1;
//                
//                [info.images addObject:imageAndData];
//                
//                char *c=(char *)sqlite3_column_text(stm, 14);
//                if( c)
//                {
//                 _Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 14)] copy];
//                imageAndData =[[ImageAndData alloc] init];
//                imageAndData.imageUrl=_Image1;
//                
//                [info.images addObject:imageAndData];
//                }
//                char *c2=(char *)sqlite3_column_text(stm, 15);
//                if( c2)
//                {
//                 _Image1=[[NSString stringWithUTF8String:(char *) sqlite3_column_text(stm, 15)] copy];
//                imageAndData =[[ImageAndData alloc] init];
//                imageAndData.imageUrl=_Image1;
//                
//                [info.images addObject:imageAndData];
//                }
//                
//                int category=sqlite3_column_int(stm, 16);
//                char *c3=(char *)sqlite3_column_text(stm, 17);
//                if( c3)
//                {
//                    info.freeDownloadLink=[[NSString stringWithUTF8String:c3] copy];
//                }
//                char *c4=(char *)sqlite3_column_text(stm, 18);
//                if( c4)
//                {
//                    info.button2Text=[[NSString stringWithUTF8String:c4] copy];
//                }
//
//                
//                info.id_=_id;
//                info.name=_Name;
//                info.isSoon=[_IsSoon boolValue];
//                info.description=_description;
//                info.iconInfo.imageUrl=_iconpath;
//                info.shortName=_shortname;
//                info.isNew=[_isnew boolValue];
//                info.isPortrate=[_isport boolValue];
//                info.fullVersionLink=_fullVersionLink;
//                info.button1Text=_firstButtonText;
//                info.date = [formatter dateFromString:_DataModified];
//                 
//                
//				[arr addObject:info];
//                [info release];
//                
//			}
//			
//		} else {
//			NSLog(@"fetchAvailableUploadFiles#Error");
//		}
//		sqlite3_close(database);
//	}
//    [formatter release];
//	return arr;
//}
//
//
//
//-(BOOL) addFavourite:(NSString *)name description:(NSString *)_description iconpath: (NSString *) _iconpath shortname:(NSString*)_shortname  isNew:(NSString*)_isNew isPortrate:(NSString*)_isPortrate fullVersionLink:(NSString*)_fullVersionLink firstButtonText:(NSString*)_firstButtonText  Date:(NSString*)_Date  IsSoon:(NSString*)_issoon ArrayImages:(NSMutableArray *)_arrayimages CategoryID:(int)categoryid  FullUrl:(NSString*)_fullurl  secondbutton:(NSString*)_secondbutton {
//	BOOL ret = YES;
//	sqlite3 *db = nil;
//	if(sqlite3_open([databasePath UTF8String], &db) == SQLITE_OK) { 
//       		const char * query= "Insert into AppTable(name,description,iconPath,shortName,isNew,isPortrate,fullVersionLink,firstButtonText,DataModified,IsSoon,Image1,Image2,Image3,Image4,Image5,CategorID,FreeUrlLink,SecondButtontext) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
//		
//		sqlite3_stmt *stm;
//		if (sqlite3_prepare_v2(db, query, -1, &stm, NULL) == SQLITE_OK) {
//         //   NSLog(@"Text %@",text);
//			//sqlite3_bind_text(stm, 1, [text UTF8String], -1, SQLITE_TRANSIENT);
//			
//			sqlite3_bind_text(stm, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
//			sqlite3_bind_text(stm, 2, [_description UTF8String], -1, SQLITE_TRANSIENT);
//            sqlite3_bind_text(stm, 3, [_iconpath UTF8String], -1, SQLITE_TRANSIENT);
//            sqlite3_bind_text(stm, 4, [_shortname UTF8String], -1, SQLITE_TRANSIENT);
//
//            sqlite3_bind_text(stm, 5, [_isNew UTF8String], -1, SQLITE_TRANSIENT);
//
//            sqlite3_bind_text(stm, 6, [_isPortrate UTF8String], -1, SQLITE_TRANSIENT);
//
//            sqlite3_bind_text(stm, 7, [_fullVersionLink UTF8String], -1, SQLITE_TRANSIENT);
//
//            sqlite3_bind_text(stm, 8, [_firstButtonText UTF8String], -1, SQLITE_TRANSIENT);
//            sqlite3_bind_text(stm, 9, [_Date UTF8String], -1, SQLITE_TRANSIENT);
//            
//            sqlite3_bind_text(stm, 10, [_issoon UTF8String], -1, SQLITE_TRANSIENT);
//            
//            for(int i=0;i<_arrayimages.count;i++)
//            {
//                ImageAndData *imageAndData = [_arrayimages objectAtIndex:i];                 sqlite3_bind_text(stm,11+i, [imageAndData.imageUrl UTF8String], -1, SQLITE_TRANSIENT);
//            }
//            
//            sqlite3_bind_int(stm, 16, categoryid);            
//
//            sqlite3_bind_text(stm, 17, [_fullurl UTF8String], -1, SQLITE_TRANSIENT);
//
//            sqlite3_bind_text(stm, 18, [_secondbutton UTF8String], -1, SQLITE_TRANSIENT);
//
//            
//            
//
//		}	
//		if (sqlite3_step(stm)!= SQLITE_DONE) {
//			ret = NO;
//			NSLog(@"Error while addFavourite data. %@",sqlite3_errmsg(db));
//		} else {
//			sqlite3_last_insert_rowid(db);
//			NSLog(@"Insert addFavourite success");
//			
//		}
//		sqlite3_finalize(stm);
//		sqlite3_close(db);	
//	} else {
//		ret = NO;
//		NSLog(@"Error while addFavourite data.");
//        
//	}
// 	return ret;
//	
//}
//
//-(BOOL) removeFavourite:(int)ID
//{
//        sqlite3 *database;
//        BOOL retValue = YES;
//        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
//            NSString* sql = [NSString stringWithFormat:@"Delete from Favourites where ID=%d",ID];
//            sqlite3_stmt *compiledStatement;
//            retValue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &compiledStatement, NULL);
//            if(SQLITE_DONE != sqlite3_step(compiledStatement))//add this line
//            {
//                NSLog(@"Error while inserting data. '%s'", sqlite3_errmsg(database));
//                return NO;
//            }
//            sqlite3_finalize(compiledStatement);
//        }
//        sqlite3_close(database);
//        
//        if(retValue == FALSE)
//        {
//            if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
//                NSString* sql = [NSString stringWithFormat:@"Delete from Favourites where BookMarkID=%d",ID];
//                sqlite3_stmt *compiledStatement;
//                retValue = sqlite3_prepare_v2(database, [sql UTF8String], -1, &compiledStatement, NULL);
//                if(SQLITE_DONE != sqlite3_step(compiledStatement))//add this line
//                {
//                    NSLog(@"Error while inserting data. '%s'", sqlite3_errmsg(database));
//                    return NO;
//                }
//                sqlite3_finalize(compiledStatement);
//            }
//            sqlite3_close(database);
//        }
//        
//        return retValue;        
//
//}

@end
