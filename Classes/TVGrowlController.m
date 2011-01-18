//
//  TVGrowlController.m
//  TvTaggr
//
//  Created by Adam Hitchcock on 11/11/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "TVGrowlController.h"


@implementation TVGrowlController
- (id) init {
	self = [super init];
	
	return self;
}

- (void) awakeFromNib {
	[GrowlApplicationBridge setGrowlDelegate: self];
}

- (NSDictionary *)registrationDictionaryForGrowl{
	NSArray* notifications = [NSArray arrayWithObjects:MOVIE_DONE_SINGLE, MOVIE_DONE_BATCH, MOVIE_ERROR, nil];
	NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
						  notifications, GROWL_NOTIFICATIONS_ALL,
						  notifications, GROWL_NOTIFICATIONS_DEFAULT, nil];
	return dict;
} 

- (void) growlWithTitle:(NSString*) title description:(NSString*) desc notificationName:(NSString*) name{
	NSNumber *gea = [[NSUserDefaults standardUserDefaults] objectForKey:@"GROWLEnableAll"];
	if([gea boolValue]){
		NSLog([[[NSUserDefaults standardUserDefaults] objectForKey:@"GROWLEnableSingle"] className]);
		NSNumber *ges = [[NSUserDefaults standardUserDefaults] objectForKey:@"GROWLEnableSingle"];
		NSNumber *geb = [[NSUserDefaults standardUserDefaults] objectForKey:@"GROWLEnableBatch"];
		if(([name isEqualToString:MOVIE_DONE_SINGLE] && [ges boolValue])
		   || ([name isEqualToString:MOVIE_DONE_BATCH] && [geb boolValue])) {
			
			[ GrowlApplicationBridge notifyWithTitle:title
										 description:desc
									notificationName:name
											iconData:nil
											priority:0
											isSticky:NO
										clickContext:nil];
		}
	}
}
@end
