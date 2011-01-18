//
//  NPEPreferencePaneController.m
//  TvTaggr
//
//  Created by Adam Hitchcock on 12/1/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "NPEPreferencePaneController.h"

@implementation NPEPreferencePaneController

- (id) initWithNib:(NSString *)nibName dictionary:(NSDictionary *)dictionary controller:(id)controller{
    
    if(! (self = [super init])) return nil;
	
    _nibName = nibName;
    _paneName = [dictionary objectForKey:PANE_NAME_KEY];
    _iconPath = [dictionary objectForKey:ICON_PATH_KEY];
    _toolTip = [dictionary objectForKey:TOOL_TIP_KEY];
	
    NSAssert(_nibName && _paneName && _iconPath && _toolTip,
             @"Dictionary does not contain a nibName, paneName, iconPath, or toolTip entry.");
	
    [_nibName retain];
    [_paneName retain];
    [_iconPath retain];
    [_toolTip retain];
	
    _helpAnchor = [[dictionary objectForKey:HELP_ANCHOR_KEY] retain];
    
    _allowsHorizontalResizing = [@"YES" isEqualToString:[dictionary objectForKey:ALLOWS_HORIZONTAL_RESIZING_KEY]];
    _allowsVerticalResizing = [@"YES" isEqualToString:[dictionary objectForKey:ALLOWS_VERTICAL_RESIZING_KEY]];
	
    _controller = [controller retain];
	
    return self;
}

- (void) dealloc{
    [_nibName release];
    [_paneName release];
    [_iconPath release];
    [_toolTip release];
    [_paneIcon release];
    [_helpAnchor release];
    [_controller release];
    [super dealloc];
}

- (id) controller{ return _controller; }

- (void) showWarningAlert:(NSError *) error{
    NSAssert(_prefsView != nil, @"prefsView was nil");
    NSAlert *alert = [NSAlert alertWithError:error];
    if(_helpAnchor != nil){
        [alert setShowsHelp:YES];
        [alert setHelpAnchor:_helpAnchor];
    }
	
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert beginSheetModalForWindow:[_prefsView window]
                      modalDelegate:self
                     didEndSelector:nil
                        contextInfo:nil];
}

- (IBAction) showHelp:(id) sender{
    NSAssert(_helpAnchor, @"Help anchor was not set");
    [[NSHelpManager sharedHelpManager] openHelpAnchor:_helpAnchor inBook:nil];
}

- (NSView *)paneView{
    BOOL loaded = YES;
    
    if(! _prefsView) loaded = [NSBundle loadNibNamed:_nibName owner:self];
    
    if(loaded) return _prefsView;
    
    return nil;
}


- (NSString *)paneName{ return _paneName; }


- (NSImage *)paneIcon{
    if(_paneIcon == nil){
        _paneIcon = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] 
															 pathForImageResource:_iconPath]];
    }
    return _paneIcon;
}

- (NSString *)paneToolTip{ return _toolTip; }

- (BOOL)allowsHorizontalResizing{ return _allowsHorizontalResizing; }

- (BOOL)allowsVerticalResizing{ return _allowsVerticalResizing; }

@end