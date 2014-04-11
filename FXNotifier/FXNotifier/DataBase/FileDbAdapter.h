

#import <Foundation/Foundation.h>
#import "FeedItem.h"
#import "EventItem.h"
@interface FileDbAdapter : NSObject {
	NSString *databaseName;
	NSString *databasePath;
    NSMutableArray *ListEffects;
    NSDateFormatter *formatter ;
}
@property (nonatomic,retain) NSString *databaseName;
@property (nonatomic, retain) NSString *databasePath;

//test ok
// Creates a writable copy of the bundled default database in the application Documents directory.
-(void)openDB;
- (NSMutableArray *) fetchfeeds;
- (NSMutableArray *) fetchAllDates ;
- (NSMutableArray *) fetchfeedsByDate:(NSString *)date ;
- (NSMutableArray *) fetchfeedByID:(int )idfeed ;

-(BOOL)InsertFeed :(FeedItem *)feeditem;
-(BOOL)DeleteAllOldFeeds:(NSMutableArray *)IdsList;

#pragma FetchEvents

- (NSMutableArray *) fetchevents;
- (NSMutableArray *) fetcheventsByDate :(NSString *)date;
- (NSMutableArray *) fetchAllDatesFromEvents;
- (NSMutableArray *) fetchCountriesFromEvents;
- (NSMutableArray *) fetchCountriesARFromEvents;
- (NSMutableArray *) fetchCalendarType;
- (NSMutableArray *) fetchCalendarTypeAr;

-(BOOL)InsertEvent :(EventItem *)eventitem;
-(BOOL)FindEvent :(NSString *)IdEcoDate;
-(void) updateEvent:(NSString *)EcoDate  Event:(EventItem *)eventitem_;
- (NSString*) fetchCalendarIDTypeByType :(NSString *)Type;
- (NSString*) fetchCountryIDByCountry :(NSString *)country;
//-(NSMutableArray*) fetchData;
//- (NSMutableArray *) fetchFavourite;
//- (NSMutableArray *) fetchTableInfo;
//- (NSMutableArray *) fetchDataSQL:(NSString*) sql;
//- (NSMutableArray *) fetchDataFavouriteSQL:(NSString*) sql;
//- (NSMutableArray *) fetchAppTable: (int)categoryId;
//- (NSMutableArray *) fetchAll_AppTable;
//-(BOOL) addFavourite:(NSString *)name description:(NSString *)_description iconpath: (NSString *) _iconpath shortname:(NSString*)_shortname  isNew:(NSString*)_isNew isPortrate:(NSString*)_isPortrate fullVersionLink:(NSString*)_fullVersionLink firstButtonText:(NSString*)_firstButtonText  Date:(NSString*)_Date  IsSoon:(NSString*)_issoon ArrayImages:(NSMutableArray *)_arrayimages CategoryID:(int)categoryid  FullUrl:(NSString*)_fullurl  secondbutton:(NSString*)_secondbutton;
//
//-(BOOL) removeFavourite:(int)ID;
@end
