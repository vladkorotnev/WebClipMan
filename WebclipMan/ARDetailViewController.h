//
//  ARDetailViewController.h
//  WebclipMan
//
//  Created by Akasaka Ryuunosuke on 14/05/14.
//  Copyright (c) 2014 Akasaka Ryuunosuke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARWebClip.h"
@interface ARDetailViewController : UIViewController<UIImagePickerControllerDelegate>

@property (strong, nonatomic) ARWebClip *detailItem;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UISwitch *fullScreenSw;
@property (weak, nonatomic) IBOutlet UISwitch *classicModeSw;
@property (weak, nonatomic) IBOutlet UISwitch *precomposedSw;
@property (weak, nonatomic) IBOutlet UISwitch *directOpenSw;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
- (IBAction)didEndOnExit:(id)sender;
- (IBAction)didChange:(id)sender;

- (IBAction)changeIcon:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *iconView;

@end
