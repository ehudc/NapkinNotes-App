//
//  NapkinNotesAppDelegate.h
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//
// SETUP NAVIGATION BAR AT LAUNCH

#import <UIKit/UIKit.h>

@interface NapkinNotesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
