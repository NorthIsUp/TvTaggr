//
//  TVRageInterface.m
//  TvTaggr
//
//  Created by Adam Hitchcock on 12/9/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "TVRageInterface.h"


@implementation TVRageInterface
- init
{
	if (self = [super init])
	{
			}
	return self;	
}

- (NSDictionary*) retrieveDataForShow:(NSString*)name Episode:(NSString*)ep Season:(NSString*)season {
	NSString* dest;
	NSString* data;
	NSURL* url;

	dest = [NSString stringWithFormat:@"http://www.tvrage.com/quickinfo.php?show=%@&ep=%@x%@",	[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
																								[ep stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
																								[season stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	url = [NSURL URLWithString:dest];
	data = [NSString stringWithContentsOfURL:url];
	if([data hasPrefix:@"No Show Results Were Found For"]){
		return nil;
	}
	
	NSLog(@"url: %@ (%@)", url, dest);
	NSLog(@"data: %@", data);
	
	
	
	return [self parseData:data];
}

- (NSDictionary*)parseData:(NSString*)aData {
	NSMutableDictionary* data = [[NSMutableDictionary alloc] init];
	NSArray* rawData;
	NSArray* tmpA;
	rawData = [NSArray arrayWithArray:[aData componentsSeparatedByString:@"\n"]];
	for (NSString* d in rawData) {
		
		if([d hasPrefix:@"Episode Info"]) {
			tmpA = [[d stringByReplacingOccurrencesOfString:@"Episode Info@" withString:@""] componentsSeparatedByString:@"^"];
			NSLog(@"tmpA: %@", tmpA);
			NSString* prod = [[tmpA objectAtIndex:0] stringByReplacingOccurrencesOfString:@"x" withString:@""];
			NSString* ep = [[[tmpA objectAtIndex:0] componentsSeparatedByString:@"x"] objectAtIndex:0];
			NSString* se = [[[tmpA objectAtIndex:0] componentsSeparatedByString:@"x"] objectAtIndex:1];
			
			[data setObject:prod forKey:@"TVEpisode"];
			[data setObject:ep forKey:@"TVEpisodeNum"];
			[data setObject:se forKey:@"TVSeasonNum"];
			[data setObject:[tmpA objectAtIndex:1] forKey:@"title"];
			[data setObject:[tmpA objectAtIndex:2] forKey:@"year"];
			
		} else if([d hasPrefix:@"Network"]) {
			tmpA = [d componentsSeparatedByString:@"@"];
			NSString* net = [tmpA objectAtIndex:1];
			
			[data setObject:net forKey:@"TVNetwork"];
		} else if([d hasPrefix:@"Episode URL"]) {
			//fetch more data
		}
	}
	NSLog(@"%@", data);
	/*
	 Show Name@Frisky Dingo
	 Show URL@http://www.tvrage.com/Frisky_Dingo
	 Premiered@2006
	 Episode Info@01x01^Meet Killface^15/Oct/2006
	 Episode URL@http://www.tvrage.com/Frisky_Dingo/episodes/456369
	 Latest Episode@02x08^The Debate: Part Two^Oct/14/2007
	 Next Episode@02x09^TBA^2008
	 Country@USA
	 Status@Returning Series
	 Classification@Animation
	 Genres@Adult Cartoons | Action | Comedy | Sci-Fi
	 Network@adult swim
	 Airtime@Sunday, 12:00 am
	 */
	
	return data;
}
@end
