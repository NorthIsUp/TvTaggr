//
//  AtomicParsleyController.m
//  TVShowNamer
//
//  Created by Adam Hitchcock on 10/19/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "AtomicParsleyController.h"


@implementation AtomicParsleyController
- (id)init {
    self = [super init];
	return self;
}

- (id)initWithGrowler:(TVGrowlController*) aGrowler {
    self = [super init];
	growler = aGrowler;
	return self;
}

- (NSString*) runAPWithArgs: (NSArray *) args{
//	NSLog(@"runAPWithArgs");
//	NSLog(@"args: %@", args);
//	
	NSTask* ap;
	
	ap = [[NSTask alloc] init];
	NSPipe *pipe=[[NSPipe alloc] init];
    NSFileHandle *handle;
	NSString* string;
	NSString* apPath = [[NSBundle mainBundle] pathForResource:@"AtomicParsley"
													   ofType:@""];
	
//	[[NSNotificationCenter defaultCenter] addObserver:self
//											 selector:@selector(finishedRun:)
//												 name:NSTaskDidTerminateNotification
//											   object:[NSDictionary dictionaryWithObjectsAndKeys:
//													   ap, @"task",
//													   args, @"args"]];
	
	[ap setLaunchPath:apPath];
	[ap setStandardOutput:pipe];
	[ap setStandardError:pipe];
	[ap setArguments:args];

	[ap launch];

	handle = [pipe fileHandleForReading];
	string = [[NSString alloc] initWithData:[handle readDataToEndOfFile]
								   encoding:NSUTF8StringEncoding]; // convert NSData -> NSString

//	NSLog(@"------recieved data: %@", string);
//	NSLog(@"waiting for exit");
	[ap waitUntilExit];
//	[ap terminate];
	return string;	
}

- (NSString*) runAPWithArgs: (NSArray *) args onFile: (NSString *) file{
	return [self runAPWithArgs:[[NSArray arrayWithObject:file] arrayByAddingObjectsFromArray:args]];
}

- (id) setMovieFile: (NSString *) file{
	return nil;
}

- (id) retreiveTagData{
	return nil;
}

- (id) applyNewTagData{
	return nil;
}

- (id) applyToBatchOfMovies: (NSDictionary *) movies{
	return nil;	
}



- (void)finishedRun:(NSNotification *)aNotification {
	NSTask* ap = [[aNotification object] objectForKey:@"task"];
//	NSArray* args = [[aNotification object] objectForKey:@"args"];
//	NSLog(@"finished");
//	[growler growlWithTitle:@"Metadata Committed"
//				description:[args objectAtIndex:0]
//		   notificationName:MOVIE_DONE_SINGLE];
	if(ap != nil)
		[ap autorelease]; // Don't forget to clean up memory
}

@end
