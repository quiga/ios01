//
//  QGPageOnePhotoList_TVC.m
//  assignmentFive
//
//  Created by Trollface on 2014.05.01..
//  Copyright (c) 2014 quiga. All rights reserved.
//

#import "QGPageOnePhotoList_TVC.h"
#import "MyFlickrFetch.h"
#import "QGImageController.h"


#define MAX_IMAGE_NUMBER 50

@interface QGPageOnePhotoList_TVC ()

@end

@implementation QGPageOnePhotoList_TVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}


- (IBAction)fetch
{
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height)];
    [MyFlickrFetch loadPhotos:self.place maxResults:MAX_IMAGE_NUMBER onCompletion:^(NSArray *photos, NSError *error) {
        if(error)
            NSLog(@"error loading photos");
        else{
            self.photos = photos;
            [self.refreshControl endRefreshing];
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetch];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_Photo" forIndexPath:indexPath];
    
    NSDictionary *photo = self.photos[indexPath.row];
    cell.textLabel.text = [MyFlickrFetch getTitleFromPhoto:photo];
    cell.detailTextLabel.text = [MyFlickrFetch getSubTitleFromPhoto:photo];
    
    return cell;
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
 */

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *index = [self.tableView indexPathForCell:sender];
    
    if([segue.identifier isEqualToString:@"Photo_Show"] && index){
        QGImageController *im = (QGImageController *)segue.destinationViewController;
        im.imageUrl = [MyFlickrFetch URLforPhoto: self.photos[index.row]];
        im.title = [MyFlickrFetch getTitleFromPhoto:self.photos[index.row]];
    }
}


@end
