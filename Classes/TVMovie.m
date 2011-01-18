/*
 
 File: Bookmark.m
 
 Abstract: Simple model object that represents a web "bookmark" including an URL, its title, and the date on which the object was created.
 
 Version: 1.2
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by  Apple Inc. ("Apple") in consideration of your agreement to the following terms, and your use, installation, modification or redistribution of this Apple software constitutes acceptance of these terms.  If you do not agree with these terms, please do not use, install, modify or redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and subject to these terms, Apple grants you a personal, non-exclusive license, under Apple's copyrights in this original Apple software (the "Apple Software"), to use, reproduce, modify and redistribute the Apple Software, with or without modifications, in source and/or binary forms; provided that if you redistribute the Apple Software in its entirety and without modifications, you must retain this notice and the following text and disclaimers in all such redistributions of the Apple Software.  Neither the name, trademarks, service marks or logos of Apple Inc.  may be used to endorse or promote products derived from the Apple Software without specific prior written permission from Apple.  Except as expressly stated in this notice, no other rights or licenses, express or implied, are granted by Apple herein, including but not limited to any patent rights that may be infringed by your derivative works or by other works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2007 Apple Inc. All Rights Reserved.
 
 */


#import "TVMovie.h"


@implementation TVMovie

+ (NSNumber *) maxProgress {
	return [NSNumber numberWithInt:3];
}

#pragma mark ======== init method =========
/* 
 ** --------------------------------------------------------
 **  init method
 ** --------------------------------------------------------
 */
- init
{
	if (self = [super init])
	{
		progress = [NSNumber numberWithInt:0];
		maxProgress = [TVMovie maxProgress];
		title = @"new title";
		[self setCreationDate:[NSDate date]];
		/*
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
		
		properties = [[NSMutableDictionary alloc] initWithObjects:values
														  forKeys:keys];
		
		propertiesFetched = [[NSMutableDictionary alloc] initWithObjects:values
																 forKeys:keys];
		 */
	}
	return self;	
}



#pragma mark ======== Archiving and unarchiving methods =========
/* 
 ** --------------------------------------------------------
 **  Archiving and unarchiving methods
 ** --------------------------------------------------------

 For details, see:
 - NSCoding Protocol Reference
 - Archives and Serializations Programming Guide for Cocoa
 */

- (void)encodeWithCoder:(NSCoder *)coder 
{
    [coder encodeObject:[self title] forKey:@"title"];
    [coder encodeObject:[self creationDate] forKey:@"creationDate"];
    [coder encodeObject:[self URL] forKey:@"URL"];
}

- (id)initWithCoder:(NSCoder *)coder 
{
    if (self = [super init])
	{
        [self setTitle:[coder decodeObjectForKey:@"title"]];
        [self setCreationDate:[coder decodeObjectForKey:@"creationDate"]];
        [self setURL:[coder decodeObjectForKey:@"URL"]];
    }
    return self;
}



#pragma mark ======== Accessor and dealloc methods =========
/* 
 ** --------------------------------------------------------
 **  Standard accessor methods
 ** --------------------------------------------------------
 */
- (NSString *)title
{
    return title; 
}
- (void)setTitle:(NSString *)aTitle
{
    if (title != aTitle) {
        [title release];
        title = [aTitle copy];
    }
}


- (NSDate *)creationDate
{
    return creationDate; 
}
- (void)setCreationDate:(NSDate *)aCreationDate
{
    if (creationDate != aCreationDate) {
        [creationDate release];
        creationDate = [aCreationDate copy];
    }
}


- (NSURL *)URL
{
    return URL; 
}
- (void)setURL:(NSURL *)anURL
{
    if (URL != anURL) {
        [URL release];
        URL = [anURL copy];
    }
}

- (NSNumber *)progress{
	return progress;
}

- (void)bumpProgress{
	progress =[NSNumber numberWithInt:[progress intValue] + 1];
}

- (void)resetProgress{
	progress = [NSNumber numberWithInt:0];
}

- (void)doneProgress{
	progress = [TVMovie maxProgress];
}

/* 
 ** --------------------------------------------------------
 **  Standard dealloc method
 ** --------------------------------------------------------
 */

- (void)dealloc
{
    [title release];
    [creationDate release];
    [URL release];
    [super dealloc];
}


@end


