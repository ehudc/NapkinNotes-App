//
//  NapkinNotesDoc.m
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//

#import "NapkinNotesDoc.h"
#import "NapkinNotesData.h"

@implementation NapkinNotesDoc
@synthesize data = _data;
@synthesize thumbImage = _thumbImage;
@synthesize fullImage = _fullImage;

@synthesize drawing = _drawing;


- (id)initWithTitle:(NSString*)title engText:(NSString*)engText thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage drawing:(UIImage *)drawing dateText:(NSString*)dateText
{
    {
        _data = [[NapkinNotesData alloc] initWithTitle:title engText:engText dateText:dateText];
        _thumbImage = [thumbImage retain];
        _fullImage = [fullImage retain];
        _drawing = [drawing retain];
    }
    return self;
}

- (void)dealloc {
    [_data release];
    _data = nil;   
    [_fullImage release];
    _fullImage = nil;
    [_thumbImage release];
    _thumbImage = nil;
    
    //ADDED
    [_drawing release];
    _drawing = nil;
    
    [super dealloc];
}

@end

