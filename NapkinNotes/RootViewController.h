//
//  RootViewController.h
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//
// ROOT VIEW - MENU ITEMS, CREATING/DELETING NOTES

#import <UIKit/UIKit.h>

@class EditNotesViewController;

@interface RootViewController : UITableViewController {
    NSMutableArray *_notes;
    EditNotesViewController *_editBugViewController;
}

@property (retain) NSMutableArray *notes;

@property (retain) EditNotesViewController *editNotesViewController;
@end
