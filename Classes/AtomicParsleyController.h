//
//  AtomicParsleyController.h
//  TVShowNamer
//
//  Created by Adam Hitchcock on 10/19/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TVGrowlController.h"

@interface AtomicParsleyController : NSObject {
	NSString* fileLocation;
	NSString* argv;
	TVGrowlController* growler;
}

- (NSString*) runAPWithArgs: (NSArray *) args;
- (NSString*) runAPWithArgs: (NSArray *) args onFile: (NSString *) file;
- (id) setMovieFile: (NSString *) file;

- (id) retreiveTagData;
- (id) retreiveArtwork: (NSString *) path;
- (id) applyNewTagData;
- (id) applyToBatchOfMovies: (NSDictionary *) movies;


@end
