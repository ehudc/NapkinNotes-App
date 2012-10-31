//
//  EditNotesViewController.h
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//
// FUNCTIONS FOR THE APP
// SEE CORRESPONDING .xib VIEW

#import <UIKit/UIKit.h>

@class NapkinNotesDoc;

@interface EditNotesViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NapkinNotesDoc *_notesDoc;
    UITextField *_titleField;
    UITextView *_text;
    
    UILabel *_date;
    
    IBOutlet UIScrollView *scroller; 
    
    IBOutlet UIScrollView *miniScroll;
    
    IBOutlet UIImageView *_imageView;

    UIImagePickerController *_picker;
    
    IBOutlet UIView *secondView;
    
        
    CGPoint lastPoint;
	UIImageView *_drawImage;
	BOOL mouseSwiped;	
	int mouseMoved;
    UIButton *ClearButton;
    
}
@property (retain) NapkinNotesDoc *notesDoc;

@property (nonatomic, retain) UIView *secondView;

@property (nonatomic, retain) IBOutlet UIButton *ClearButton;

@property (retain) IBOutlet UIImageView *drawImage;

@property (retain) IBOutlet UITextField *titleField;

@property (retain) IBOutlet UITextView *text;

@property (retain) IBOutlet UILabel *date;

@property(nonatomic,retain) UIImageView *imageView;

// scrolling in the imageview, for when image is zoomed in
@property (nonatomic, retain) UIScrollView *miniScroll;

@property (retain) UIImagePickerController *picker; // pick image


- (IBAction)titleFieldValueChanged:(id)sender; // title text

- (IBAction)textViewValueChanged:(id)sender; // ADD THIS "engtext" INTO DOC & DATA - REPLACE RATING (FROM PT1)

- (IBAction)textFieldDoneEditing:(id)sender; // save text

- (IBAction)switchView:(id)sender; // flip to draw

- (IBAction)clickClear:(id)sender; // clear drawing

 
- (IBAction)getCameraPicture:(id)sender;
- (IBAction)selectExitingPicture:(id)sender;
- (IBAction)back:(id)sender;


@end

