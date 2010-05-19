//
//  MobileFlashView.m
//  MobileFlash
//
//  Created by Steven Troughton-Smith on 10/02/2010.
//	Pretty much all code cribbed from ClickToFlash for proof-of-concept

#import "MobileFlashView.h"

@class DOMElement;

@interface MobileFlashView (Internal)
- (id)_initWithArguments:(NSDictionary *)arguments;
@end

@implementation MobileFlashView

@synthesize container;

-(void)drawRect:(CGRect)rect
{
	[[UIColor redColor] set];
	
	UIRectFill(rect);
	
	[[UIColor whiteColor] set];
	
	[@"Flash goes here..." drawInRect:[self bounds] withFont:[UIFont boldSystemFontOfSize:16.0]];
}

- (NSString*) flashvarWithName: (NSString*) argName
{
    return [ _flashVars objectForKey: argName ];
}

- (void) _convertElementForMP4: (DOMElement*) element
{
	
	DOMElement* newElement = (DOMElement*) [ [self container] cloneNode: NO ];

	
	NSString *videoId = [ self flashvarWithName: @"video_id" ];
	NSString *videoHash = [ self flashvarWithName: @"t" ];
	
    NSString* video_id =  videoId;
    NSString* video_hash = videoHash;
    
    NSString* src = [ NSString stringWithFormat: @"http://www.youtube.com/get_video?fmt=18&video_id=%@&t=%@",
					 video_id, video_hash ];
    
    [ element setAttribute: @"src" value: src ];
    [ element setAttribute: @"type" value: @"video/mp4" ];
    [ element setAttribute: @"scale" value: @"aspect" ];
    [ element setAttribute: @"autoplay" value: @"true" ];
    [ element setAttribute: @"cache" value: @"false" ];
	
    if( ! [ element hasAttribute: @"width" ] )
        [ element setAttribute: @"width" value: @"640" ];
	
    if( ! [ element hasAttribute: @"height" ] )
		[ element setAttribute: @"height" value: @"500" ];
	
    [ element setAttribute: @"flashvars" value: nil ];
	
	
}

// WebPlugInViewFactory protocol
// The principal class of the plug-in bundle must implement this protocol.

+ (UIView *)plugInViewWithArguments:(NSDictionary *)newArguments
{
	
	//NSLog(@"IPAD WEB VIEW ARGS = %@", [newArguments description]);

	NSDictionary *pluginDict = [newArguments objectForKey:@"WebPlugInAttributesKey"];
	
	NSString *flashURL = [pluginDict objectForKey:@"src"];
	
    return [[[self alloc] _initWithArguments:newArguments] autorelease];
}

// WebPlugIn informal protocol

- (void)webPlugInInitialize
{
    // This method will be only called once per instance of the plug-in object, and will be called
    // before any other methods in the WebPlugIn protocol.
    // You are not required to implement this method.  It may safely be removed.
	
	NSLog(@"MobileSafariPlugin demo plugin loaded");
}

- (void)webPlugInStart
{
    // The plug-in usually begins drawing, playing sounds and/or animation in this method.
    // You are not required to implement this method.  It may safely be removed.
}

- (void)webPlugInStop
{
    // The plug-in normally stop animations/sounds in this method.
    // You are not required to implement this method.  It may safely be removed.
}

- (void)webPlugInDestroy
{
    // Perform cleanup and prepare to be deallocated.
    // You are not required to implement this method.  It may safely be removed.
}

- (void)webPlugInSetIsSelected:(BOOL)isSelected
{
    // This is typically used to allow the plug-in to alter its appearance when selected.
    // You are not required to implement this method.  It may safely be removed.
}

- (id)objectForWebScript
{
    // Returns the object that exposes the plug-in's interface.  The class of this object can implement
    // methods from the WebScripting informal protocol.
    // You are not required to implement this method.  It may safely be removed.
    return self;
}

#define CTFForEachObject( Type, varName, container ) \
NSEnumerator* feoEnum_##__LINE__ = [ container objectEnumerator ]; \
Type* varName; \
while( ( varName = [ feoEnum_##__LINE__ nextObject ] ) )

- (NSDictionary*) _flashVarDictionary: (NSString*) flashvarString
{
    NSMutableDictionary* flashVarsDictionary = [ NSMutableDictionary dictionary ];
    
    NSArray* args = [ flashvarString componentsSeparatedByString: @"&" ];
    
    CTFForEachObject( NSString, oneArg, args ) {
        NSRange sepRange = [ oneArg rangeOfString: @"=" ];
        if( sepRange.location != NSNotFound ) {
            NSString* key = [ oneArg substringToIndex: sepRange.location ];
            NSString* val = [ oneArg substringFromIndex: NSMaxRange( sepRange ) ];
            
            [ flashVarsDictionary setObject: val forKey: key ];
        }
    }
    
    return flashVarsDictionary;
}
@end

@implementation MobileFlashView (Internal)

- (id)_initWithArguments:(NSDictionary *)newArguments
{
    if (!(self = [super init]))
        return nil;
	
	return self;
	
	/* Specific C-T-F plugin code has been broken in final 3.2 SDK; will fix later */
	
	/*
	self.container = [newArguments objectForKey:@"WebPlugInContainingElementKey"];
	NSLog(@"FOUND FLASH = %@", [self.container description]);
	
	
	NSString* flashvars = [[newArguments objectForKey:@"WebPlugInAttributesKey"] objectForKey: @"flashvars" ];
	

	if( flashvars != nil )
		_flashVars = [ [ self _flashVarDictionary: flashvars ] retain ];
	
	
	DOMElement* newElement = (DOMElement*) [ [self container] cloneNode: NO ];
    
    [ self _convertElementForMP4: newElement ];
	
	[[[self container] parentNode] replaceChild:newElement oldChild:[self container]];
    [self setContainer:nil];

    
    return self;
	 */
}

@end
