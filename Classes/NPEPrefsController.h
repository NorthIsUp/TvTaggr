//
//  NPEPrefsController.h
//  TvTaggr
//
//  Created by Adam Hitchcock on 12/1/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SS_PrefsController.h"
#import "NPEPreferencePaneController.h"

@interface NPEPrefsController : SS_PrefsController {
	
}

- (id)initWithPanesSearchPath:(NSString*)path bundleExtension:(NSString *)ext controller:(id)controller;
- (void)activatePane:(NSString*)path controller:(id)controller;

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar;

- (void)showPreferencesWindow;
- (void)showPreferencePane:(NSString *) paneName;

@end