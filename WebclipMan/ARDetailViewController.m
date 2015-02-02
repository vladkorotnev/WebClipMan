//
//  ARDetailViewController.m
//  WebclipMan
//
//  Created by Akasaka Ryuunosuke on 14/05/14.
//  Copyright (c) 2014 Akasaka Ryuunosuke. All rights reserved.
//

#import "ARDetailViewController.h"

@interface ARDetailViewController ()
- (void)configureView;
@end

@implementation ARDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
   
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.titleField.text = (self.detailItem.title ? self.detailItem.title : @"");
        self.addressField.text = (self.detailItem.url ? self.detailItem.url : @"");
        self.fullScreenSw.on = self.detailItem.fullScreen;
        self.classicModeSw.on = self.detailItem.isClassic;
        self.precomposedSw.on = self.detailItem.iconIsPrecomposed;
        self.directOpenSw.on = self.detailItem.isDirect;
        UIImage*i = [self.detailItem iconAsAppIcon:true];
        if(i)[self.iconView setImage:i forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view1.layer.shadowColor = [[UIColor grayColor]CGColor];
    self.view1.layer.shadowOffset = CGSizeMake(1, 1);
    self.view1.layer.shadowOpacity = 0.5f;
    self.view1.layer.shadowRadius = 1.0f;
    self.view2.layer.shadowColor = [[UIColor grayColor]CGColor];
    self.view2.layer.shadowOffset = CGSizeMake(1, 1);
    self.view2.layer.shadowOpacity = 0.5f;
    self.view2.layer.shadowRadius = 1.0f;
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didEndOnExit:(id)sender {
    [self didChange:sender];
}
- (void) viewWillDisappear:(BOOL)animated {
    [self didChange:nil];
}
- (IBAction)didChange:(id)sender {
    NSLog(@"ch %@",self.detailItem);
    if (self.detailItem) {
        self.detailItem.title = self.titleField.text;
        self.detailItem.url = self.addressField.text;
        self.detailItem.fullScreen = self.fullScreenSw.on;
        self.detailItem.isClassic = self.classicModeSw.on;
        self.detailItem.iconIsPrecomposed = self.precomposedSw.on;
        self.detailItem.isDirect = self.directOpenSw.on;
        [self.detailItem _sync];
    }
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage*pick = [info valueForKey:UIImagePickerControllerEditedImage];
    if (self.detailItem) {
        [self.detailItem setIcon:pick];
        [self didChange:nil];
           [self.iconView setImage:[self.detailItem iconAsAppIcon:true] forState:UIControlStateNormal];
    }
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)changeIcon:(id)sender {
    NSLog(@"Change icon");
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
        
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [imagePicker setAllowsEditing:YES];
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    
}
@end
