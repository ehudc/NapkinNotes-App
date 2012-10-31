//
//  NapkinNotesData.h
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//
// POINTERS FOR ALL TEXT-BASED DATA

#import <Foundation/Foundation.h>


@interface NapkinNotesData : NSObject {
    NSString *_title;
    NSString *_engText;
    NSString *_dateText;
}

@property (copy) NSString *title;

@property (copy) NSString *engText;

@property (copy) NSString *dateText;

- (id)initWithTitle:(NSString*)title engText:(NSString*)engText dateText:(NSString*)dateText;

@end
