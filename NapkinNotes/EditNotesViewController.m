//
//  EditNotesViewController.m
//  NapkinNotes
//
//  Created by Ehud Cohen on 11/8/11.
//

#import "UIImageExtras.h"

#import "NapkinNotesDoc.h"
#import "NapkinNotesData.h"

#import "EditNotesViewController.h"

@implementation EditNotesViewController

@synthesize notesDoc = _notesDoc;
@synthesize titleField = _titleField;
@synthesize text = _text;

@synthesize date = _date;

@synthesize imageView = _imageView;

@synthesize picker = _picker;


@synthesize miniScroll;

@synthesize secondView;

@synthesize ClearButton;

@synthesize drawImage = _drawImage;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark Did Load - Flip Button

- (void)viewDidLoad
{
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Flip to Draw" style:UIBarButtonItemStyleBordered target:self action:@selector(switchView:)] autorelease];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 950)];
    
    miniScroll.contentSize = _imageView.frame.size;
	[miniScroll addSubview:_imageView];
	miniScroll.minimumZoomScale = 1.0;
	miniScroll.maximumZoomScale = 5.0;
	miniScroll.delegate = self;
	//[miniScroll setZoomScale:miniScroll.maximumZoomScale];
        
    [super viewDidLoad];
    
     _drawImage = [[UIImageView alloc] initWithImage:nil];
	_drawImage.frame = secondView.frame;
	//[self.view addSubview:_drawImage];
    
    [secondView addSubview:_drawImage];

}

#pragma mark Switch Views

-(IBAction)switchView:(id)sender{
    
    /*
	EditImagesViewController *myViewController =
    [[EditImagesViewController alloc] initWithNibName:@"EditImagesViewController" bundle:nil];
	*/
    
	[UIView beginAnimations:@"flipview" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft 
						   forView:self.view cache:YES];
	
	[self.view addSubview:secondView];

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Flip to Front" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)] autorelease];
    
    
    //[self.navigationController pushViewController:myViewController animated:YES];
    //[EditNotesViewController release];
    
	[UIView commitAnimations];
	
}

-(IBAction)back:(id)sender{
	
	
	[UIView beginAnimations:@"flipview" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight 
						   forView:self.view.superview cache:YES];
	
	[secondView removeFromSuperview];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Flip to Draw" style:UIBarButtonItemStyleBordered target:self action:@selector(switchView:)] autorelease];
	
	[UIView commitAnimations];
    
}

#pragma mark Drawing


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 4) {
		_drawImage.image = nil;
		return;
	}
    
	lastPoint = [touch locationInView:secondView];
	lastPoint.y -= 20;
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];	
	CGPoint currentPoint = [touch locationInView:secondView];
	currentPoint.y -= 20;
	
	
	UIGraphicsBeginImageContext(secondView.frame.size);
	[_drawImage.image drawInRect:CGRectMake(0, 0, secondView.frame.size.width, secondView.frame.size.height)];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	_drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIImage *drawing = UIGraphicsGetImageFromCurrentImageContext();
    _notesDoc.drawing = drawing;
    
    
    
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
    // Double Tap to Clear //
    //
	// UITouch *touch = [touches anyObject];
    /*
	if ([touch tapCount] == 2) {
		_drawImage.image = nil;
		return;
	}
	*/
	
	if(!mouseSwiped) {
		UIGraphicsBeginImageContext(secondView.frame.size);
		[_drawImage.image drawInRect:CGRectMake(0, 0, secondView.frame.size.width, secondView.frame.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.0, 1.0);
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		CGContextFlush(UIGraphicsGetCurrentContext());
		_drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        
        
        UIImage *drawing = UIGraphicsGetImageFromCurrentImageContext();
        _notesDoc.drawing = drawing;
        
        
		UIGraphicsEndImageContext();
	}
}

- (IBAction)clickClear:(id)sender {
    
    _drawImage.image = nil;
    return;
}


#pragma mark Title Change

- (IBAction)titleFieldValueChanged:(id)sender {
    _notesDoc.data.title = _titleField.text;
}

#pragma mark Text Change

- (IBAction)textViewValueChanged:(id)sender
{
    _notesDoc.data.engText = _text.text; //ADD engtext INTO DOC AND DATA!!!!!
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    _notesDoc.data.engText = _text.text;
    return YES;
}

#pragma mark TitleEnd and TextEnd

-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}



- (void)dealloc
{
    [super dealloc];
    
    [_notesDoc release];
    _notesDoc = nil;
    [_titleField release];
    _titleField = nil;
    
    [_imageView release];
    _imageView = nil;

    
    [_text release];
    _text = nil;
    
    [_picker release];
    _picker = nil;
    
    [_drawImage release];
    _drawImage = nil;
    

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    //self.picker = nil;
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _imageView;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Inside viewDidUnload
    
    self.titleField = nil;
    self.imageView = nil;
    self.text = nil;
    
    self.date = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [self setClearButton:nil];
    
    _drawImage.image = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return YES;
    return NO;
}


#pragma mark - On open, set initial

- (void)viewWillAppear:(BOOL)animated
{    
    _titleField.text = _notesDoc.data.title;
    _imageView.image = _notesDoc.fullImage;
    
    _text.text = _notesDoc.data.engText;  
    
    _drawImage.image = _notesDoc.drawing;
    
    _date.text = _notesDoc.data.dateText;
    
    [super viewWillAppear:animated];
}


#pragma mark - Image Capture

// CAMERA CODE
-(IBAction)getCameraPicture:(id)sender
{
	self.picker = [[UIImagePickerController alloc] init];
	_picker.delegate = self;
	_picker.allowsEditing = YES;
	_picker.sourceType = UIImagePickerControllerSourceTypeCamera; //(sender == takePictureButton) ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	[self presentModalViewController:_picker animated:YES];
	[_picker release];
}


 // LIBRARY CODE
-(IBAction)selectExitingPicture:(id)sender
{
	if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
	{
		self.picker = [[UIImagePickerController alloc] init];
		_picker.delegate = self;
		_picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		[self presentModalViewController:_picker animated:YES];
        [_picker release];
	}
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {    
    
    //[self.navigationController presentModalViewController:_picker animated:NO];    
    
    [self dismissModalViewControllerAnimated:YES];
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage]; 
    UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
    _notesDoc.fullImage = fullImage;
    _notesDoc.thumbImage = thumbImage;
    _imageView.image = fullImage;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *) picker
{
	[picker dismissModalViewControllerAnimated:YES];
}


@end

