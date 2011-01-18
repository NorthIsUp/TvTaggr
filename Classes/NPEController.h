//
//  NPEController.h
//  TvTaggr
//
//  Created by Adam Hitchcock on 12/1/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NPEPrefsController.h"

@interface NPEController : NSObject {
    NSUserDefaults		*_defaults;
	NPEPrefsController	*_prefsController;
}

- (IBAction) showPreferences:(id) sender;

- (BOOL) preferenceOne;
- (void) setPreferenceOne:(BOOL) preferenceOne;

- (int) preferenceTwo;
- (void) setPreferenceTwo:(int) preferenceTwo;

@end