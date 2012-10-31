//
//  RootViewController.m
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//

#import "RootViewController.h"
#import "NapkinNotesDoc.h"
#import "NapkinNotesData.h"

#import "EditNotesViewController.h"


@implementation RootViewController


@synthesize notes = _notes;

@synthesize editNotesViewController = _editNotesViewController;


- (void)viewDidLoad
{
    self.title = @"Napkin Notes";

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"New Note" 
                style:UIBarButtonItemStyleBordered target:self 
                                                action:@selector(addTapped:)] autorelease];
    
}


 - (void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];

     [self.tableView reloadData];
 }

#pragma mark Table View Organization

// Override to allow other orientations besides default
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {

    //return YES;
    return NO;
}

// Number of sections in table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _notes.count;
}


// Customize appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Cell Data:

    NapkinNotesDoc *doc = [_notes objectAtIndex:indexPath.row];
    cell.textLabel.text = doc.data.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = doc.thumbImage;
    
    return cell;
}

#pragma mark Delete Note

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {        
        [_notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }  
}


#pragma mark New Note With Date And Time

- (void)addTapped:(id)sender 
{
    NSDate *now = [NSDate date];
    NSLog(@"now: %@", now); //full date
    NSString *strDate = [[NSString alloc] initWithFormat:@"%@",now];
    
    // FOLLOWING CODE CAUSES EXCEPTION, FIX
    /*
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YY/MM/dd HH:mm:ss"];
    [dateFormatter setLocale:nil];
    NSString *dateString = [dateFormatter stringFromDate:now];
    */
    
    NSArray *arr = [strDate componentsSeparatedByString:@" "];
    NSString *str1;
    NSString *str2;
    str1 = [arr objectAtIndex:0];
    str2 = [arr objectAtIndex:1];
    NSLog(@"strdate: %@",str1);    
    
    //dateText:str1
    
    NapkinNotesDoc *newDoc = [[[NapkinNotesDoc alloc] initWithTitle:@"Title" engText:@"Text:" thumbImage:nil fullImage:nil drawing:nil dateText:@"2011-12-14"] autorelease];
    
    [_notes addObject:newDoc];

    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_notes.count-1 inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:YES];
    
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}


#pragma mark Row Re-ordering

// Determine whether row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// Process row move, update data model to correct the item indices.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath 
	  toIndexPath:(NSIndexPath *)toIndexPath {
	NSString *item = [[_notes objectAtIndex:fromIndexPath.row] retain];

	[item release];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_editNotesViewController == nil) 
    {
        self.editNotesViewController = [[[EditNotesViewController alloc] initWithNibName:@"EditNotesViewController" bundle:[NSBundle mainBundle]] autorelease];        
    }
    NapkinNotesDoc *doc = [_notes objectAtIndex:indexPath.row];
    _editNotesViewController.notesDoc = doc;
    [self.navigationController pushViewController:_editNotesViewController animated:YES]; 
    
}

#pragma mark Memory Handling

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    self.editNotesViewController = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [super dealloc];
    
    [_notes release];
    _notes = nil;
    
    [_editNotesViewController release];
    _editNotesViewController = nil;
    
}

@end
