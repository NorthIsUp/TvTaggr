//
//  TVGrowlController.h
//  TvTaggr
//
//  Created by Adam Hitchcock on 11/11/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Growl-WithInstaller/Growl.h>

#ifdef __OBJC__
#define XSTR(x) (@x)
#define STRING_TYPE NSString *
#else
#define XSTR CFSTR
#define STRING_TYPE CFStringRef
#endif

#define MOVIE_DONE_SINGLE XSTR("Metadata committed for movie")
#define MOVIE_DONE_BATCH  XSTR("Metadata committed for all movies")
#define MOVIE_ERROR       XSTR("Error")

@interface TVGrowlController :  NSObject <GrowlApplicationBridgeDelegate> {

}

- (NSDictionary *)registrationDictionaryForGrowl;
- (void)growlWithTitle:(NSString*) title description:(NSString*) desc notificationName:(NSString*) name;
@end
