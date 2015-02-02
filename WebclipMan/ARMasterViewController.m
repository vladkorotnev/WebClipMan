//
//  ARMasterViewController.m
//  WebclipMan
//
//  Created by Akasaka Ryuunosuke on 14/05/14.
//  Copyright (c) 2014 Akasaka Ryuunosuke. All rights reserved.
//

#import "ARMasterViewController.h"

#import "ARDetailViewController.h"
#import "ARWebClip.h"
@interface ARMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation ARMasterViewController
#define FM [NSFileManager defaultManager]
- (void)awakeFromNib
{
    [super awakeFromNib];
}
- (IBAction)showInfo:(id)sender {
    [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"About WebclipMan", @"About window title") message:NSLocalizedString(@"Webclipman 1.0\nYou may need to respring after editing Webclips!\n© vladkorotnev/AkRyuu, 2014\nhttp://vladkorotnev.me\n\nSpecial thanks to:\nNaoki Sakata\nArien Hikarin", @"About text") delegate:self cancelButtonTitle:@"OK" otherButtonTitles: @"Respring", nil]show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex]isEqualToString:@"Respring"]) {
        system("killall SpringBoard");
    }
}
- (void)viewDidLoad
{
 
    [super viewDidLoad];


    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    _objects = [[NSMutableArray alloc] init];
  
}
- (void) viewWillAppear:(BOOL)animated {
    [_objects removeAllObjects];
    NSError *e=nil;
    for (NSString*dir in [FM contentsOfDirectoryAtPath:@"/var/mobile/Library/WebClips" error:&e]) {
        if ([dir hasSuffix:@".webclip"]) {
            ARWebClip * wc = [ARWebClip webclipWithDirectory:[@"/var/mobile/Library/WebClips" stringByAppendingPathComponent:dir]];
            NSLog(@"Found %@",dir);
            [_objects addObject:wc];
        }
    }
    NSLog(@"%@",e.localizedDescription);
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[ARWebClip newWebclip] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ARWebClip *object = _objects[indexPath.row];
    cell.textLabel.text = object.title;
    cell.detailTextLabel.text = object.url  ;
    cell.imageView.image = [object iconAsAppIcon:true];
    return cell;
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ARWebClip *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
