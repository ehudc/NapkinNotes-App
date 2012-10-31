//
//  NapkinNotesDoc.h
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//
// POINTERS FOR ALL IMAGE-BASED DATA
// Forward declare NapkinNotesData.h, establish pointer to all text-based data
// Possible to combine this .h with NapkinNotesData ? For future edit.

#import <Foundation/Foundation.h>

@class NapkinNotesData;

@interface NapkinNotesDoc : NSObject
{
    NapkinNotesData *_data;
    UIImage *_thumbImage;
    UIImage *_fullImage;
    
    UIImage *_drawing;
}

@property (retain) NapkinNotesData *data;
@property (retain) UIImage *thumbImage;
@property (retain) UIImage *fullImage;

@property (retain) UIImage *drawing;



- (id)initWithTitle:(NSString*)title engText:(NSString*)engText thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage drawing:(UIImage *)drawing dateText:(NSString*)dateText;


@end
