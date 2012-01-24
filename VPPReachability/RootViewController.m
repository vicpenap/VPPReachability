//
//  RootViewController.m
//  VPPLibraries
//
//  Created by Víctor on 24/10/11.
//  Copyright Víctor Pena Placer 2011. All rights reserved.
//

#import "RootViewController.h"
#import "VPPReachabilityHelper.h"

@implementation RootViewController

#define kNumberOfSections 1
enum kSections {
	kSectionInternetAvailable = 0
};

#define kNumberOfRowsInSectionInternetAvailable 1
enum kRowsInSectionInternetAvailable {
	kSectionInternetAvailableRowInternetStatus = 0
};

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	[[VPPReachabilityHelper sharedInstance] addDelegate:self];
    self.tableView.rowHeight = 60;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kNumberOfSections;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
		case kSectionInternetAvailable:
			return kNumberOfRowsInSectionInternetAvailable;
		default:
			break;
	}
	
	return 0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
		case kSectionInternetAvailable:
			return @"Internet status";
        default:
			break;
	}
	
	return nil;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	switch (indexPath.section) {
		case kSectionInternetAvailable:
			switch (indexPath.row) {
				case kSectionInternetAvailableRowInternetStatus:
					if ([[VPPReachabilityHelper sharedInstance] isInternetAvailable]) {
						cell.textLabel.text = @"Internet is available";
					}
					else {
						cell.textLabel.text = @"Internet isn't available";
					}
					cell.selectionStyle = UITableViewCellSelectionStyleNone;
					cell.detailTextLabel.text = @"Try changing your network settings...";
					break;
				default:
					break;
			}
			break;
        default:
			break;
	}

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[[VPPReachabilityHelper sharedInstance] removeDelegate:self];

    [super dealloc];
}

#pragma mark -
#pragma mark VPPReachabilityHelperDelegate implementation
- (void) internetAvailable:(BOOL)available {

	// in this case we don't care about the new internet status
	
	NSIndexPath *iPath = [NSIndexPath indexPathForRow:kSectionInternetAvailableRowInternetStatus inSection:kSectionInternetAvailable];
	[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:iPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end

