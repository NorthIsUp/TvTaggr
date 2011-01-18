//
//  ViewController.h
//  TVShowNamer
//
//  Created by Adam Hitchcock on 10/19/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <QuickTime/Movies.h>
#import <QTKit/QTKit.h>
#import "TVGrowlController.h"
#import <OgreKit/OgreKit.h>
#import "TVMovie.h"	

@interface ViewController : NSObject {
	
	IBOutlet NSTextView* manualArgs;
	IBOutlet NSTextView* manualOutput;
	IBOutlet NSPathControl* moviePath;
	IBOutlet QTMovieView* movieView;
	IBOutlet NSTableView* tableView;
	IBOutlet NSDrawer* filesDrawer;
	IBOutlet TVGrowlController* growler;
	IBOutlet NSProgressIndicator* fetchIndicator;
	
	NSDictionary* argumentList;	
	NSMutableDictionary* properties;
	NSMutableDictionary* propertiesFetched;
	NSMutableDictionary* propertiesEnabled;
	NSMutableDictionary* propertiesFetchedEnabled;
	NSMutableDictionary* propertiesMisc;
	NSMutableDictionary* propertiesRegex;
	NSMutableArray* movieList;
	
	BOOL APFlag;
}

- (void) redrawTable;
//- (NSMutableDictionary*) properties;
- (IBAction) toggleManualWindow: (id) sender;
- (IBAction) runManual: (id) sender;
- (IBAction) retrieveData: (id) sender;
- (IBAction) applyChanges: (id) sender;
- (IBAction) applyChangesSelectNext: (id) sender;
- (IBAction) applyBatchChanges: (id)sender;
- (IBAction) applyRegex:(id) sender;
- (IBAction)mailMeFeedback:(id)sender;
- (IBAction)mailMeBugReport:(id)sender;
- (IBAction) reloadData:(id) sender;

- (NSMutableArray *) buildArgs;
- (NSDictionary *) parseOutput: (NSString *) apOutput;
- (NSArray *) runOnFile: (TVMovie *) aMovie;
- (NSArray *) runOnFiles: (NSArray *) fileList;
- (void) setFields: (NSDictionary *) aDict;

@end
