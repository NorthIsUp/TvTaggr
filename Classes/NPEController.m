//
//  NPEController.m
//  TvTaggr
//
//  Created by Adam Hitchcock on 12/1/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "NPEController.h"

#define PREF_ONE_KEY @"preferenceOne"
#define PREF_TWO_KEY @"preferenceTwo"

@implementation NPEController

- (void) awakeFromNib{
    // set our default prefs.
    _defaults = [[NSUserDefaults standardUserDefaults] retain];
    NSDictionary *defaultPreferences = 
	[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO], PREF_ONE_KEY,
	 [NSNumber numberWithInt:0], PREF_TWO_KEY, nil];
    [_defaults registerDefaults:defaultPreferences];
}

- (void) dealloc{
    [_defaults synchronize];
    [_defaults release];
	[_prefsController release];
    [super dealloc];
}

- (void) applicationWillTerminate:(NSNotification *)notification{
    [self release]; // to make sure we do get released.
}

- (BOOL) preferenceOne{ return [_defaults boolForKey:PREF_ONE_KEY]; }

- (void) setPreferenceOne:(BOOL) preferenceOne{
    [_defaults setBool:preferenceOne forKey:PREF_ONE_KEY];
}

- (int) preferenceTwo{ return [[_defaults objectForKey:PREF_TWO_KEY] intValue]; }

- (void) setPreferenceTwo:(int) preferenceTwo{
    NSAssert(preferenceTwo >= 0 && preferenceTwo <= 3, 
			 @"preferenceTwo was less than 0 or greater than 3");
	
    [_defaults setInteger:preferenceTwo forKey:PREF_TWO_KEY];
}

- (IBAction) showPreferences:(id) sender{
    if(! _prefsController){
        NSString *path = nil;
        NSString *ext = nil;
        _prefsController = [[NPEPrefsController alloc] initWithPanesSearchPath:path 
                                                               bundleExtension:ext 
                                                                    controller:self];
		
        // so that we always see the toolbar, even with just one pane
        [_prefsController setAlwaysShowsToolbar:YES];
        [_prefsController setPanesOrder:[NSArray arrayWithObjects:@"General", @"Growl", @"Update", @"Advanced", nil]];
    }
	
    [_prefsController showPreferencesWindow];
}


@end