//
//  QGPageOne_TVC.m
//  assignmentFive
//
//  Created by Trollface on 2014.05.01..
//  Copyright (c) 2014 quiga. All rights reserved.
//

#import "QGPageOne_TVC.h"
#import "MyFlickrFetch.h"
#import "QGPageOnePhotoList_TVC.h"

@interface QGPageOne_TVC ()

@property (nonatomic, strong) NSDictionary *placesByCountry;
@property (nonatomic, strong) NSArray *countryList;

- (NSDictionary*) getPlace:(NSIndexPath *)index;

@end

@implementation QGPageOne_TVC

- (NSDictionary*) getPlace:(NSIndexPath *)index{
    return self.placesByCountry[self.countryList[index.section]][index.row];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [refreshControl addTarget:self action:@selector(fetch) forControlEvents:UIControlEventTouchDown];
        [self setRefreshControl:refreshControl];
    }
    return self;
}

- (IBAction)fetch{
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height)];
    
    [MyFlickrFetch loadPlaces:^(NSArray *places, NSError *error) {
        if(error)
            NSLog(@"error loading");
        else{
            self.places = places;
            [self.refreshControl endRefreshing];
        }
    }];
    
    
}

- (void)setPlaces:(NSArray *)places{
    if(_places == places) return;
    _places = [MyFlickrFetch sortByPlace:places];
    self.placesByCountry =  [MyFlickrFetch getPlacesByCountryList:_places];
    self.countryList = [MyFlickrFetch getCountryListFromPlaces:self.placesByCountry];
    
    [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.countryList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.placesByCountry[self.countryList[section]] count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell_Place";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSDictionary *item = [self getPlace:indexPath];
    cell.textLabel.text = [MyFlickrFetch getTitleFromPlace:item];
    cell.detailTextLabel.text = [MyFlickrFetch getSubTitleFromPlace:item];
    
    return cell;
}


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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *index = [self.tableView indexPathForCell:sender];
    if([segue.identifier isEqualToString:@"Place_Show"] && index){
        
        QGPageOnePhotoList_TVC *item = (QGPageOnePhotoList_TVC *)segue.destinationViewController;
        
        item.place = [self getPlace:index];
        item.title = [MyFlickrFetch getTitleFromPlace:[self getPlace:index]];
    }
    
}


@end
