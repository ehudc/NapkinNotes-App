//
//  NapkinNotesAppDelegate.m
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//
// IMPORT DATA AND DOC FILES, ON LAUNCH LOAD NOTES WITH TEXT/IMAGE DATA

#import "NapkinNotesAppDelegate.h"
#import "NapkinNotesDoc.h"
#import "RootViewController.h"

@implementation NapkinNotesAppDelegate

@synthesize window;
@synthesize navigationController;

#pragma mark On Launch

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NapkinNotesDoc *note1 = [[[NapkinNotesDoc alloc] initWithTitle:@"Today's Whiteboard" engText:@"Today in class we discussed memory allocation. Remember to upload the whiteboard photo (below) to share with Dan."  thumbImage:[UIImage imageNamed:@"whiteboardThumb.jpg"] fullImage:[UIImage imageNamed:@"whiteboard.jpg"] drawing:nil dateText:@"2011-12-10"] autorelease];
    /*
    NapkinNotesDoc *note2 = [[[NapkinNotesDoc alloc] initWithTitle:@"2nd Note" engText:@"This is my 2nd note" thumbImage:[UIImage imageNamed:@"einThumb.jpg"] fullImage:[UIImage imageNamed:@"ein.jpg"] drawing:nil dateText:@"no date"] autorelease];
    */
    NapkinNotesDoc *note2 = [[[NapkinNotesDoc alloc] initWithTitle:@"check out this album!" engText:@"A new album from Nujabes, gotta check it out!" thumbImage:[UIImage imageNamed:@"nujabesThumb.jpg"] fullImage:[UIImage imageNamed:@"nujabesAlbumCover.jpg"] drawing:nil dateText:@"2011-12-10"] autorelease];

    
    NSMutableArray *notes = [NSMutableArray arrayWithObjects:note1, note2, nil];
    RootViewController *rootController = (RootViewController *) [navigationController.viewControllers objectAtIndex:0];
    rootController.notes = notes;
    
    
    // Add the navigation controller's view to the window and display.
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    return YES;
}


#pragma mark Extra

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}



- (void)dealloc
{
    [window release];
    [navigationController release];
    [super dealloc];
}

@end
