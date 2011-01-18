//
//  TVRageInterface.h
//  TvTaggr
//
//  Created by Adam Hitchcock on 12/9/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TVRageInterface : NSObject {
}

- (NSDictionary*) retrieveDataForShow:(NSString*)name Episode:(NSString*)ep Season:(NSString*)season;

@end
