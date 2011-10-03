//
//  fb_connectViewController.m
//  fb-connect
//
//  Created by TopTier on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "fb_connectViewController.h"


@implementation fb_connectViewController

@synthesize wall;
@synthesize messageTableView;
@synthesize dicBundle;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    NSString *pathBundle = [[NSBundle mainBundle] pathForResource:@"facebook-connect" ofType:@"plist"];
    NSDictionary *tempBundle = [[NSDictionary alloc] initWithContentsOfFile:pathBundle]; 
    self.dicBundle = tempBundle;
    
    NSString *appId = [dicBundle objectForKey:@"appId"];
    NSArray *permissions = [dicBundle objectForKey:@"permissions"];
    
    //Asking for permission
    appDelegate = (fb_connectAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.facebook = [[Facebook alloc] initWithAppId:appId andDelegate:self];
    Facebook *fb = [appDelegate facebook];
    [fb  authorize:permissions];
    
    //Inititialize data siyrce
    self.wall = [[NSMutableArray alloc] init];
    
    [tempBundle release];
    [super viewDidLoad];
}



- (void)dealloc {
    [wall release];
    [dicBundle release];
    [super dealloc];
}

- (void)viewDidUnload
{
    self.messageTableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



//////////////*** Begin Facebook Events ****//////////
- (void) request: (FBRequest *)request didReceiveResponse: (NSURLResponse *)response {
    NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
    if (statusCode == 200) {
        NSString *url = [[response URL] absoluteString];
        NSLog(@"Response OK: %@", url);
    }
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    if ([result isKindOfClass:[NSDictionary class]]){
        if ([wall count] > 0){
            [self.wall removeAllObjects];
        }
        NSArray *data = (NSArray *)[result objectForKey:@"data"];
        for(NSDictionary *dic in data){
            NSString *message = [dic objectForKey:@"message"];    
            
            if (message != nil) {
                [wall addObject:message];
            }
            
        }
        [messageTableView reloadData];
        
    }

}

//Login Successfull
- (void)fbDidLogin {
    appDelegate = (fb_connectAppDelegate *)[[UIApplication sharedApplication] delegate];
    Facebook *facebookObj = [appDelegate facebook];
    
    NSString *graphApiPath = [dicBundle objectForKey:@"graphApiPath"];
    
    [facebookObj requestWithGraphPath:graphApiPath andDelegate:self];
}

//////////////*** End Facebook Events ****//////////


//Table View events

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [wall count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"CellId";
    //---try to get a reusable cell---
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    //---create new cell if no reusable cell is available---
    if (cell == nil) { 
        cell = [[[UITableViewCell alloc]
        initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    //---set the text to display for the cell---
    NSString *cellValue = [wall objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue; return cell;
}
//End table view events

@end
