//
//  NapkinNotesData.m
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//

#import "NapkinNotesData.h"

@implementation NapkinNotesData

@synthesize title = _title;
@synthesize engText = _engText;
@synthesize dateText = _dateText;

- (id)initWithTitle:(NSString*)title engText:(NSString*)engText dateText:(NSString*)dateText
{
    if ((self = [super init])) {
        _title = [title copy];
        _engText = engText;
        _dateText = dateText;
    }
    return self;
}

- (void)dealloc {
    [_title release];
    _title = nil;    
    [super dealloc];
}

@end
