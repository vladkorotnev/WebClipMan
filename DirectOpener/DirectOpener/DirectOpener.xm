
#import <UIKit/UIKit.h>
#define kOrientationIsDL 100500

%hook SBWebApplicationIcon
-(void)launchFromLocation:(int)loc {
    NSLog(@"Akasaka's Directlauncher 1.0 :3");
    NSLog(@"many thx 2 Arien :3");
    id webc = [self webClip];
    id info = [webc _info];
    if([info[@"Orientations"]integerValue] == kOrientationIsDL) {
        [[UIApplication sharedApplication]openURL: [NSURL URLWithString:info[@"URL"]]];
        return;
    }
    %orig;
}
%end