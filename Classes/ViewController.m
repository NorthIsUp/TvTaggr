//
//  ViewController.m
//  TVShowNamer
//
//  Created by Adam Hitchcock on 10/19/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AtomicParsleyController.h"
#import "TableViewDataSource.h"
#import "TVRageInterface.h"

@implementation ViewController
#pragma mark setup
- (id) init {
	NSLog(@"init: ViewController");
	self = [super init];
	
	NSArray* tags = [NSArray arrayWithObjects:
					 @"©ART", @"©nam", @"©alb", @"©gen", @"trkn",
					 @"trknmax", @"disk", @"diskmax", @"comment", @"©day",
					 @"@lyr", @"composer", @"cprt", @"grouping", @"covr",
					 @"bpm", @"aART", @"compilation", @"rtng", @"stik",
					 @"desc", @"tvnn", @"tvsh", @"tven", @"tvsn",
					 @"tves", @"podcastFlag", @"category", @"keyword", @"podcastURL",
					 @"podcastGUID", @"purd", @"encodingTool", @"gapless", nil];
	
	NSArray* keys	= [NSArray arrayWithObjects:
					   @"artist", @"title", @"album", @"genre", @"tracknum",
					   @"tracknummax", @"disk", @"diskmax", @"comment", @"year",
					   @"lyrics", @"composer", @"copyright", @"grouping", @"artwork",
					   @"bpm", @"albumArtist", @"compilation", @"advisory", @"stik",
					   @"description", @"TVNetwork", @"TVShowName", @"TVEpisode", @"TVSeasonNum",
					   @"TVEpisodeNum", @"podcastFlag", @"category", @"keyword", @"podcastURL",
					   @"podcastGUID", @"purchaseDate", @"encodingTool", @"gapless", nil];
	
	NSArray* values = [NSArray arrayWithObjects:
					   [NSString string], [NSString string], [NSString string], [NSString string], [NSString string],
					   [NSString string], [NSString string], [NSString string], [NSString string], [NSString string],
					   [NSString string], [NSString string], [NSString string], [NSString string], [[NSURL alloc] initFileURLWithPath:@"/"],
					   [NSString string], [NSString string], [NSString string], [NSString string], [NSString string],
					   [NSString string], [NSString string], [NSString string], [NSString string], [NSString string],
					   [NSString string], [NSString string], [NSString string], [NSString string], [NSString string],
					   [NSString string], [NSString string], [NSString string], [NSString string], nil];
	
	NSArray* boolValues = [NSArray arrayWithObjects:
						   [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0],
						   [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0],
						   [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0],
						   [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0],
						   [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0],
						   [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0],
						   [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], [[NSNumber alloc] initWithBool:0], nil];
	
	NSArray* regexKeys = [NSArray arrayWithObjects:@"regex", @"artist", @"title", @"TVShowName", @"TVEpisode", @"TVSeasonNum", @"TVEpisodeNum", nil];
	NSArray* regexObjects = [NSArray arrayWithObjects:[NSString string], [NSString string], [NSString string], [NSString string], [NSString string], [NSString string],[NSString string], nil];
	
	properties = [[NSMutableDictionary alloc] initWithObjects:values
													  forKeys:keys];
	
	propertiesFetched = [[NSMutableDictionary alloc] initWithObjects:values
															 forKeys:keys];

	
	NSLog(@"properties misc");
	propertiesMisc = [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects: [[NSNumber alloc] initWithInt:0], [[NSNumber alloc] initWithInt:0], [[NSNumber alloc] initWithBool:0], nil]
														  forKeys:[NSArray arrayWithObjects: @"progressOverallMax", @"progressOverall", @"smartValues", nil]];
	NSLog(@"properties misc");
	
	propertiesEnabled = [[NSMutableDictionary alloc] initWithObjects:boolValues
															 forKeys:keys];
	
	propertiesFetchedEnabled = [[NSMutableDictionary alloc] initWithObjects:boolValues
																	forKeys:keys];
	
	NSLog(@"propertiesEnabled");	
	propertiesRegex = [[NSMutableDictionary alloc] initWithObjects:regexObjects
														   forKeys:regexKeys];
	NSLog(@"propertiesRegex");
	argumentList = [[NSDictionary alloc] initWithObjects:keys
												 forKeys:tags];
	NSLog(@"argumentList");
	movieList = [[NSMutableArray alloc] init];
	
	for (NSString* k in keys) {
		[properties addObserver:self
					 forKeyPath:k
						options:NSKeyValueObservingOptionNew
						context:NULL];
	}
	NSLog(@"init end");
	return self;
}


- (void) awakeFromNib {
	NSLog(@"awake");
	if([[[moviePath URL] path] compare:@"/"] != NSOrderedSame) {
		[self retrieveData:self];
	}
	[fetchIndicator setDisplayedWhenStopped:NO];
	[manualArgs setTextColor:[NSColor whiteColor]];
	[manualArgs setFont:[NSFont fontWithName:@"Andale Mono" size:10.0]];
	
	[manualOutput setTextColor:[NSColor whiteColor]];
	[manualOutput setFont:[NSFont fontWithName:@"Andale Mono" size:10.0]];
	NSLog(@"awake end");
}

#pragma mark -
#pragma mark Actions
- (IBAction) runManual: (id) sender {
	AtomicParsleyController* apc = [[AtomicParsleyController alloc] init];
	NSString *aString;
	aString = [apc runAPWithArgs: [[manualArgs string] componentsSeparatedByString:@"  "]];
	[manualOutput setTextColor:[NSColor whiteColor]];
	[manualOutput setFont:[NSFont fontWithName:@"Andale Mono" size:10.0]];
	[manualOutput setString:aString];
}

- (IBAction) toggleManualWindow: (id) sender{
	
}

- (IBAction) handleOpenMovie:(id)sender {
	QTMovie* qtMovie;
	
	//	NSArray* fileTypes = [NSArray arrayWithObjects:@"mp4", @"m4a", nil];
	//	NSString* moviesDir = [NSHomeDirectory() stringByAppendingString:[NSString stringWithString: @"/Movies"]];
	
	//	NSOpenPanel* panel = [NSOpenPanel openPanel];
	//	[panel runModalForDirectory:moviesDir file:nil types:fileTypes ];
	
	NSError* openError = nil;
	qtMovie = [QTMovie movieWithURL:[moviePath URL] error:&openError];
	if (openError != nil) {
		printf ("Error!\n");
		NSLog(@"ERR: %@", openError); 
		return;
	} 
	
	[movieView setMovie:qtMovie];
	
}

#pragma mark do it
- (IBAction) retrieveData: (id) sender {

	NSString* path;
	NSArray* selection = [[tableView dataSource] selectedObjects];
	TVMovie *aMovie;
	
	if([selection count] > 0) {
		aMovie = [selection objectAtIndex:0];
		[aMovie resetProgress];
		path = [[aMovie URL] path];
	} else {
		return;
	}
	
	AtomicParsleyController* apc = [[AtomicParsleyController alloc] init];
	NSString* aString;
	
	NSArray* args = [NSArray arrayWithObjects:path, @"-t", nil];

	[aMovie bumpProgress];
	aString = [apc runAPWithArgs:args];
	for (NSString* key in [properties allKeys]) {
		NSNumber* b = [propertiesEnabled objectForKey:key];
		if( [b boolValue] != 0)
			continue;
//		if(   [key isNotEqualTo:@"stik"]
//		   && [key isNotEqualTo:@"advisory"]){
			[properties setObject:@"" forKey:key];
	}
	[aMovie bumpProgress];
	[self setFields: [self parseOutput: aString]];
	[aMovie bumpProgress];
}

- (IBAction) applyChanges: (id) sender {
	MyArrayController* mac = [tableView dataSource];
	NSArray* tableValues = [mac selectedObjects];
	[self runOnFiles:tableValues];
//	[propertiesMisc setObject:[NSNumber numberWithInt:[tableValues count]] forKey:@"progressOverallMax"];
//	[propertiesMisc setObject:[NSNumber numberWithInt:0] forKey:@"progressOverall"];
//	for (TVMovie *m in tableValues) {
//		[m resetProgress];
//		[self redrawTable];
//	}
//	
//	
//	int i = 0;
//	for (TVMovie *m in tableValues) {
//		[m resetProgress];
//		[self redrawTable];
//		NSLog([[m URL] path]);
//		[self runOnFile:m];
//		[m doneProgress];
//		[self redrawTable];
//		[propertiesMisc setObject:[NSNumber numberWithInt:++i] forKey:@"progressOverall"];
//		[growler growlWithTitle:[m title] description:@"Metadata has been committed" notificationName:MOVIE_DONE_SINGLE];
//	}
}

- (IBAction) applyChangesSelectNext: (id) sender {
	[self applyChanges:sender];
	[[tableView dataSource] selectNext:sender];
}

- (IBAction) applyBatchChanges: (id)sender{
	MyArrayController* mac = [tableView dataSource];
	NSArray* tableValues = [mac arrangedObjects];
	[self runOnFiles:tableValues];
//	
//	for (TVMovie *m in tableValues) {
//		[m resetProgress];
//	}
//	
//	if([tableValues count] > 0){
//	[propertiesMisc setObject:[NSNumber numberWithInt:[tableValues count]] forKey:@"progressOverallMax"];
//		[propertiesMisc setObject:[NSNumber numberWithInt:0] forKey:@"progressOverall"];
//		int i = 0;
//		for (TVMovie *m in tableValues) {
//			NSLog([[m URL] path]);
//			[self runOnFile:m];
//			[m doneProgress];
////			[growler growlWithTitle:[m title]
////						description:@"Metadata has been committed"
////				   notificationName:MOVIE_DONE_SINGLE];
//			[propertiesMisc setObject:[NSNumber numberWithInt:++i] forKey:@"progressOverall"];
//		}
		[growler growlWithTitle:@"Batch Job"
					description:@"All metadata has been committed"
			   notificationName:MOVIE_DONE_BATCH];	
//	}
}

- (NSArray *) runOnFiles: (NSArray *) fileList {
	NSArray *tableValues = fileList;
	
	if([tableValues count] <= 0){
		return nil;
	}
	
	[propertiesMisc setObject:[NSNumber numberWithInt:[tableValues count]] forKey:@"progressOverallMax"];
	[propertiesMisc setObject:[NSNumber numberWithInt:0] forKey:@"progressOverall"];
	for (TVMovie *m in tableValues) {
		[m resetProgress];
		[self redrawTable];
	}
	
	
	int i = 0;
	for (TVMovie *m in tableValues) {
		[m resetProgress];
		[self redrawTable];
		NSLog([[m URL] path]);
		[self runOnFile:m];
		[m doneProgress];
		[self redrawTable];
		[propertiesMisc setObject:[NSNumber numberWithInt:++i] forKey:@"progressOverall"];
		[growler growlWithTitle:[m title] description:@"Metadata has been committed" notificationName:MOVIE_DONE_SINGLE];
	}
	return nil;
}


- (NSArray *) runOnFile: (TVMovie *) aMovie {
	
	AtomicParsleyController* apc = [[AtomicParsleyController alloc] init];
	NSString *aString;
	NSMutableArray* args = [self buildArgs];
	[args addObject:@"--overWrite"];
	[aMovie progress];
	aString = [apc runAPWithArgs:args
						  onFile:[[aMovie URL] path]];
	[aMovie progress];
	return nil;
}

#pragma mark arguments
- (NSMutableArray *) buildArgs {
	//	NSLog(@"buildArgs");
	NSMutableArray* arglist = [[NSMutableArray alloc] init];

	//disk and tracknum logic
	Boolean trackDone = NO;
	Boolean diskDone = NO;

	
	for (NSString* fieldKey in [properties allKeys]) {
		NSString* field = [properties objectForKey:fieldKey];
		NSNumber* enabled = [propertiesEnabled objectForKey:fieldKey];
		//		NSLog(@"%@ is: %@, with value: %@", fieldKey, enabled, field);
		if([enabled boolValue] == 0)
			continue;
		
		
		if([fieldKey isEqualToString:@"year"]){
			NSLog([[properties objectForKey:fieldKey] className]);
			NSDate* d = [properties objectForKey:fieldKey];
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc]
										   initWithDateFormat:@"%Y-%b-%dT00:00:00Z" allowNaturalLanguage:NO];
			[arglist addObject:[NSString stringWithFormat:@"--%@", fieldKey]];
			[arglist addObject:[NSString stringWithFormat:@"%@", [dateFormat stringFromDate:d]]];
			
		} else if ([fieldKey isEqualToString:@"tracknum"] || [fieldKey isEqualToString:@"disk"]
				   || [fieldKey isEqualToString:@"tracknummax"] || [fieldKey isEqualToString:@"diskmax"]) {
			NSLog(fieldKey);
			NSString* f = [fieldKey stringByReplacingOccurrencesOfString:@"max" withString:@""];
			NSString* fm = [f stringByAppendingString:@"max"];
			if([f isEqualToString:@"tracknum"]){
				if(trackDone)
					continue;
				else
					trackDone = YES;
			}
			if ([f isEqualToString:@"disk"]){
				if(diskDone)
					continue;
				else
					diskDone = YES;
			}
			
			// # / #
			if([propertiesEnabled objectForKey:fm] && [propertiesEnabled objectForKey:f]){
				[arglist addObject:[NSString stringWithFormat:@"--%@", f]];
				[arglist addObject:[NSString stringWithFormat:@"%@/%@", [properties objectForKey:f], [properties objectForKey:fm]]];
			}
			// #
			else if(![propertiesEnabled objectForKey:fm] && [propertiesEnabled objectForKey:f]){
				[arglist addObject:[NSString stringWithFormat:@"--%@", f]];
				[arglist addObject:[NSString stringWithFormat:@"%@", [properties objectForKey:f]]];
			}
			// <#|0> / #
			else if([propertiesEnabled objectForKey:fm] && ![propertiesEnabled objectForKey:f]){
				[arglist addObject:[NSString stringWithFormat:@"--%@", f]];
				[arglist addObject:[NSString stringWithFormat:@"%@/%@", ([properties objectForKey:f] == nil ? 0 : [properties objectForKey:f]),
									[properties objectForKey:fm]]];
				
			}
			
		} else {
			if([field compare:@""] != NSOrderedSame){
				[arglist addObject:[NSString stringWithFormat:@"--%@", fieldKey]];
				[arglist addObject:[NSString stringWithFormat:@"%@", field]];	
			}			
		}
	}
	
	NSLog(@"%@", arglist);
	return arglist;
}

- (void) retrieveArtwork:(NSString *) aString {
	
	aString = [aString stringByReplacingOccurrencesOfString:@"Extracted artwork to file: " withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@"\nNo changes." withString:@""];
	//	NSImage* im = [[NSImage alloc] initWithContentsOfFile:aString];
	//	NSLog(@"About to change the artwork");
	//	NSLog(aString);
	[properties	setObject:[[NSURL alloc] initFileURLWithPath:aString] forKey:@"artwork"];
	
}

- (NSDictionary *) parseOutput: (NSString *) apOutput {
	//	NSLog(@"parseOutput");
	NSString* NEWLINE = @"@@@newline@@@";
	NSString* PAIRS = @"@@@,@@@";
	apOutput = [apOutput stringByReplacingOccurrencesOfString:@"\nAtom \"" withString:NEWLINE];
	apOutput = [apOutput stringByReplacingOccurrencesOfString:@"\" contains: " withString:PAIRS];
	apOutput = [apOutput stringByReplacingOccurrencesOfString:@"\" [iTunEXTC] contains: " withString:PAIRS];
	apOutput = [apOutput stringByReplacingOccurrencesOfString:@"Atom \"" withString:@""];
	NSArray* rawData = [apOutput componentsSeparatedByString:NEWLINE];
	NSString* touple;
	
	NSMutableDictionary* touples = [[[NSMutableDictionary alloc] initWithCapacity:40] retain];
	for (touple in rawData) {
		[touples setObject:[[touple componentsSeparatedByString:PAIRS] objectAtIndex: 1]
					forKey:[[touple componentsSeparatedByString:PAIRS] objectAtIndex: 0]];
	}
	return touples;
}

- (void) setFields: (NSDictionary *) touples{
	NSArray* tags = [touples allKeys];
	NSString* arg;
	for (NSString* tag in tags) {
		arg = [argumentList objectForKey:tag];
		if(arg == nil) {
			continue;
		}
		
		if([tag isEqualToString:@"covr"]){
			
		} else if ([tag isEqualToString:@"trkn"]) {
			NSArray* split = [[touples valueForKey:tag] componentsSeparatedByString:@" of "];
			switch ([split count]) {
				case 2:
					[properties setObject:[split objectAtIndex:1]
								   forKey:@"tracknummax"];
				case 1:
					[properties setObject:[split objectAtIndex:0]
								   forKey:@"tracknum"];
			}
		} else if ([tag isEqualToString:@"disk"]) {
			NSArray* split = [[touples valueForKey:tag] componentsSeparatedByString:@" of "];
			switch ([split count]) {
				case 2:
					[properties setObject:[split objectAtIndex:1]
								   forKey:@"diskmax"];
				case 1:
					[properties setObject:[split objectAtIndex:0]
								   forKey:@"disk"];
			}
		} else if ([tag isEqualToString:@"@day"]) {
			NSLog(arg);
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc]
										   initWithDateFormat:@"%Y-%b-%dT%H:%m:%sZ" allowNaturalLanguage:NO];
			[properties setObject:[dateFormat dateFromString:[touples valueForKey:tag]]
						   forKey:arg];
			NSLog(@"%@",[dateFormat dateFromString:[touples valueForKey:tag]]);			
		} else {
			[properties setObject:[touples valueForKey:tag]
						   forKey:arg];
		}
	}	
}

#pragma mark table view
- (IBAction) reloadData:(id) sender {
	[self tableViewSelectionDidChange:nil];
}

- (void)selectionChanged:(NSNotification *)aNotification {
}

- (void) tableViewSelectionDidChange: (NSNotification *) notification
{
	int row;
	row = [tableView selectedRow];
	if (row == -1) {
		// do stuff for the no-rows-selected case
	} else {
		// do stuff for the selected row
		NSArray* selection = [[tableView dataSource] selectedObjects];
		if([selection count] > 0) {
			//			[moviePath setURL:[[selection objectAtIndex:0] URL]];
			[self retrieveData:self];			
			[self applyRegex:self];
			[self fetchFromWeb:self];
		}
	}
} // tableViewSelectionDidChange

- (IBAction) fetchFromWeb:(id) sender{
	[fetchIndicator startAnimation:self];
	TVRageInterface* tri = [[TVRageInterface alloc] init];
	NSString* ep = [[properties objectForKey:@"TVEpisode"] substringToIndex:1];
	NSString* se = [[properties objectForKey:@"TVEpisode"] substringFromIndex:2];
	NSDictionary* fetchedData = [tri retrieveDataForShow:[properties objectForKey:@"TVShowName"] Episode:ep Season:se];
	NSMutableDictionary* appliedData = [[NSMutableDictionary alloc] init];
	if(fetchedData != nil){
		[propertiesFetched setValuesForKeysWithDictionary:fetchedData];
		for (NSString* d in [propertiesFetchedEnabled allKeys]) {
			if([[propertiesFetchedEnabled objectForKey:d] boolValue]){
				[appliedData setObject:[propertiesFetched objectForKey:d] forKey:d];
			}
		}
		[properties setValuesForKeysWithDictionary:appliedData];
	}
	[fetchIndicator stopAnimation:self];
}

- (IBAction) applyRegex:(id) sender{
	NSLog(@"apply regex");
	// first find all placeholders in it
	// scan left to right, collect placeholders, remember order
	NSString* pattern = [propertiesRegex objectForKey:@"regex"];
	NSMutableArray* matches = [[NSMutableArray alloc] init];
	if(pattern == nil || [pattern isEqualToString:@""])
		return;
	int i = 0;
	Boolean foundPercent = NO;
	for(i = 0; i < [pattern length]; i++){
		unichar uc[1] = {[pattern characterAtIndex:i]};
		NSString* now = [NSString stringWithCharacters:uc length:1];

		if(foundPercent){
			foundPercent = NO;
			if([now isEqualToString:@"%"]){
			} else if([now isEqualToString:@"N"]){
				[matches addObject:@"TVShowName"];
			}else if([now isEqualToString:@"T"]){
				[matches addObject:@"title"];
			}else if([now isEqualToString:@"A"]){
				[matches addObject:@"artist"];
			}else if([now isEqualToString:@"E"]){
				[matches addObject:@"TVEpisodeNum"];
			}else if([now isEqualToString:@"S"]){
				[matches addObject:@"TVSeasonNum"];
			}else if([now isEqualToString:@"P"]){
				[matches addObject:@"TVEpisode"];
			}
		} else if([now isEqualToString:@"%"]){
			foundPercent = YES;
		}
	}

	pattern = [pattern stringByReplacingOccurrencesOfString:@"%%" withString:@"^^^%^^^"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%N" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%T" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%A" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%E" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%S" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%P" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%n" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%t" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%a" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%e" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%s" withString:@"(.*)"];
	pattern = [pattern stringByReplacingOccurrencesOfString:@"%p" withString:@"(.*)"];
	
	pattern = [pattern stringByReplacingOccurrencesOfString:@"^^^%^^^" withString:@"%"];

	OGRegularExpression			*rx;
	OGRegularExpressionMatch	*match, *lastMatch = nil;
	NSArray* selection = [[tableView dataSource] selectedObjects];
	NSString* str = [[selection objectAtIndex:0] title];


	
	NSString	*escapeChar = @"\\";

	[OGRegularExpression setDefaultEscapeCharacter:escapeChar];

	[OGRegularExpression setDefaultSyntax:OgreRubySyntax];

	rx = [OGRegularExpression regularExpressionWithString: pattern options: OgreFindNotEmptyOption | OgreCaptureGroupOption | OgreIgnoreCaseOption];
	
	NSEnumerator	*enumerator = [rx matchEnumeratorInString:str];

	while((match = [enumerator nextObject]) != nil) {
		NSLog(@"a match");
		for (i = 0; i < [match count]; i++) {
			NSRange	subexpRange = [match rangeOfSubstringAtIndex:i];
			NSLog( [NSString stringWithFormat:@"#%d.%d", [match index], i]);
			if([match nameOfSubstringAtIndex:i] != nil) {
				NSLog([NSString stringWithFormat:@"(\"%@\")", [match nameOfSubstringAtIndex:i]]);
			}
			NSLog([NSString stringWithFormat:@": (%d-%d)", subexpRange.location, subexpRange.location + subexpRange.length]);
			if([match substringAtIndex:i] == nil) {
				NSLog(@" no match!\n");
			} else {
				NSLog(@"\"%@\"", [match substringAtIndex:i]);
			}
		}
		i = 1;
		for (NSString* m in matches) {
			[propertiesRegex setObject:[match substringAtIndex:i] forKey:m];
			if([[[NSUserDefaults standardUserDefaults] objectForKey:@"regexEnabled"] boolValue] == 1){
				[properties setObject:[match substringAtIndex:i] forKey:m];
			}
			i++;
		}
		
	}
	
	//RKRegex *aRegex = [[RKRegex alloc] initWithRegexString:pattern options:RKCompileNoOptions];
//	
//	NSArray* selection = [[tableView dataSource] selectedObjects];
//	NSString* filename = [[selection objectAtIndex:0] title];
//	RKEnumerator *anEnumerator = [filename matchEnumeratorWithRegex:aRegex];
//	NSLog(pattern);
//	while([anEnumerator nextRanges] != NULL) {
//		// Do something with the current match results of anEnumerator
//		NSRange matchRange = [anEnumerator currentRange];
//		NSLog([filename substringWithRange:matchRange]);
//		
//	}

	
	
//	NSArray* selection = [[tableView dataSource] selectedObjects];
//	NSArray *backrefArray;
//	PCRegex *regex = [PCRegex regexWithPattern:filename];
//
//	[[[selection objectAtIndex:0] title] match:regex backreferences:&backrefArray];
//
//	NSLog(@"_%@_ matches on _%@_", [regex pattern], [[selection objectAtIndex:0] title]);
//	NSLog(@"count: %@", [backrefArray count]);
//	
//	for (PCRegexBackreference *s in backrefArray) {
//		NSLog(@"%@", [s string]);
//		NSLog(@"%@", [s className]);
//	}
	//
//	i = 1;
}

#pragma mark apply tv to Music

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	NSString* newValue = [change objectForKey:NSKeyValueChangeNewKey];
	//	NSString* oldValue = [change objectForKey:NSKeyValueChangeOldKey];
	//	NSLog(@"%@: ( %@ | %@ )", keyPath, newValue, oldValue);
	if( [[propertiesMisc valueForKey:@"smartValues"] intValue] ) {
		if(newValue == nil){
			newValue = [[NSString alloc] initWithString:@""];
		}
		if( [keyPath isEqualToString:@"TVShowName"] ) {
			[properties setObject:newValue
						   forKey:@"artist"];
			[properties setObject:newValue
						   forKey:@"albumArtist"];
			[properties setObject:[NSString stringWithFormat:@"%@, %@", newValue, [properties objectForKey:@"TVSeasonNum"]]
						   forKey:@"album"];
		} else if( [keyPath isEqualToString:@"TVSeasonNum"] ) {
			[properties setObject:[NSString stringWithFormat:@"%@, %@", [properties objectForKey:@"TVShowName"], newValue]
						   forKey:@"album"];
			[properties setObject:[NSString stringWithFormat:@"%@%@", newValue, [properties objectForKey:@"TVEpisodeNum"]]
						   forKey:@"album"];
		} else if( [keyPath isEqualToString:@"TVEpisodeNum"] ) {
			[properties setObject:[NSString stringWithFormat:@"%@%@", [properties objectForKey:@"TVSeasonNum"], newValue]
						   forKey:@"album"];
		}
	}
}

- (BOOL)shouldPerformAP:(id)sender {
	if(APFlag == YES) {
		return YES;
	} else {
		return NO;
	}
}

- (void)didStartWorking:(id)sender {
	// turn off buttons
}

- (void)didStopWorking:(id)sender {
	// tunr on buttons
}

- (IBAction)mailMeFeedback:(id)sender{
	NSString *to			= @"adam@northisup.net";
	NSString *subject		= @"TvTaggr FEEDBACK: ";
	NSString *bodyString	= @"";

	
	NSString *encodedSubject	= [NSString stringWithFormat:@"SUBJECT=%@", [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	NSString *encodedBody		= [NSString stringWithFormat:@"BODY=%@", [bodyString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	NSString *encodedTo			= [to stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSString *encodedURLString	= [NSString stringWithFormat:@"mailto:%@?%@&%@", encodedTo, encodedSubject, encodedBody];
	NSURL *mailtoURL			= [NSURL URLWithString:encodedURLString];
	
	[[NSWorkspace sharedWorkspace] openURL:mailtoURL]; 
	
}

- (IBAction)mailMeBugReport:(id)sender{
	NSString *to			= @"adam@northisup.net";
	NSString *subject		= @"TvTaggr BUG: ";
	NSString *bodyString	= @"Summary:\nProvide a descriptive summary of the issue.\n\nSteps to Reproduce:\nIn numbered format, detail the exact steps taken to produce the bug.\n\nExpected Results:\nDescribe what you expected to happen when you executed the steps above.\n\nActual Results:\nExplain what actually occurred when steps above are executed.\n\nRegression:\nDescribe circumstances where the problem occurs or does not occur, such as software versions and/or hardware configurations.\n\nNotes:\nProvide additional information, such as references to related problems, workarounds and relevant attachments.\n\n\n(I will soon add a method to upload the movies files which break the program)";

	
	NSString *encodedSubject	= [NSString stringWithFormat:@"SUBJECT=%@", [subject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	NSString *encodedBody		= [NSString stringWithFormat:@"BODY=%@", [bodyString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
	NSString *encodedTo			= [to stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSString *encodedURLString	= [NSString stringWithFormat:@"mailto:%@?%@&%@", encodedTo, encodedSubject, encodedBody];
	NSURL *mailtoURL			= [NSURL URLWithString:encodedURLString];
	
	[[NSWorkspace sharedWorkspace] openURL:mailtoURL]; 
	
}

- (void) redrawTable{
	[tableView reloadData];
}
@end
