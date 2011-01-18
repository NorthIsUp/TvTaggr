//
//  NPEPrefsController.m
//  TvTaggr
//
//  Created by Adam Hitchcock on 12/1/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "NPEPrefsController.h"

@implementation NPEPrefsController

// Designated initializer

- (id)initWithPanesSearchPath:(NSString*)path bundleExtension:(NSString *)ext controller:(id)controller;
{
    if (self = [super init]) {
        [self setDebug:NO];
        preferencePanes = [[NSMutableDictionary alloc] init];
        panesOrder = [[NSMutableArray alloc] init];
        
        [self setToolbarDisplayMode:NSToolbarDisplayModeIconAndLabel];
#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_2
        [self setToolbarSizeMode:NSToolbarSizeModeDefault];
#endif
        [self setUsesTexturedWindow:NO];
        [self setAlwaysShowsToolbar:NO];
        [self setAlwaysOpensCentered:YES];
        
        if (!ext || [ext isEqualToString:@""]) {
            bundleExtension = [[NSString alloc] initWithString:@"preferencePane"];
        } else {
            bundleExtension = [ext retain];
        }
        
        if (!path || [path isEqualToString:@""]) {
            searchPath = [[NSString alloc] initWithString:[[NSBundle mainBundle] resourcePath]];
        } else {
            searchPath = [path retain];
        }
        
        // Read PreferencePanes - this is where we differ from SS_PrefsController
		
        if (searchPath) {
            NSEnumerator* enumerator = [[NSBundle pathsForResourcesOfType:bundleExtension inDirectory:searchPath] objectEnumerator];
            NSString* panePath;
            while ((panePath = [enumerator nextObject])) {
                [self activatePane:panePath controller:controller];
            }
        }
        return self;
    }
    return nil;
}

- (void)activatePane:(NSString*)path controller:(id)controller{
    
    NSBundle* paneBundle = [NSBundle bundleWithPath:path];
    NSAssert1(paneBundle != nil, @"Could not initialize bundle: %@", paneBundle);
    
    NSDictionary* paneDict = [paneBundle infoDictionary];
    NSString* paneClassName = [paneDict objectForKey:@"NSPrincipalClass"];
    NSAssert1(paneClassName != nil, @"Could not obtain name of Principal Class for bundle: %@", paneBundle);    
    
    Class paneClass = NSClassFromString(paneClassName);
    NSAssert2(paneClass == nil, @"Did not load bundle: %@ because its Principal Class %@ was already used in another Preference pane.", paneBundle, paneClassName);
    
    paneClass = [paneBundle principalClass];
    
    NSAssert2([paneClass isSubclassOfClass:[NPEPreferencePaneController class]], 
              @"Could not load bundle %@ because it Principal Class %@ is not a subclass of NPEPreferencePaneController",
              paneBundle, paneClassName);
    
    NSString *nibName = [paneDict objectForKey:@"NSMainNibFile"];
    NSAssert1(nibName, @"Could not obtain name of nib for bundle: %@", paneBundle);
    
    NPEPreferencePaneController *aPane = [[paneClass alloc] initWithNib:nibName dictionary:paneDict controller:controller];    
    
    if(aPane != nil){
        [panesOrder addObject:[aPane paneName]];
        [preferencePanes setObject:aPane forKey:[aPane paneName]];
        [aPane release];
    }
}


#if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3
- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar{
    return panesOrder;
}
#endif


// make sure we get a highlighted icon first time around.

- (void)showPreferencesWindow{
    [super showPreferencesWindow];
    [prefsToolbar setSelectedItemIdentifier:[prefsWindow title]];    
}

// make sure we get a highlighted icon when activating a pane programmatically.

- (void)showPreferencePane:(NSString *) paneName{
    [self loadPreferencePaneNamed:paneName];        
    [prefsToolbar setSelectedItemIdentifier:paneName];    
}

@end