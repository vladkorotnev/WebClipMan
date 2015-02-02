#line 1 "/Users/tigra/Desktop/Coding/WebclipMan/DirectOpener/DirectOpener/DirectOpener.xm"

#import <UIKit/UIKit.h>
#define kOrientationIsDL 100500

#include <substrate.h>
@class SBWebApplicationIcon; 
static void (*_logos_orig$_ungrouped$SBWebApplicationIcon$launchFromLocation$)(SBWebApplicationIcon*, SEL, int); static void _logos_method$_ungrouped$SBWebApplicationIcon$launchFromLocation$(SBWebApplicationIcon*, SEL, int); 

#line 5 "/Users/tigra/Desktop/Coding/WebclipMan/DirectOpener/DirectOpener/DirectOpener.xm"

static void _logos_method$_ungrouped$SBWebApplicationIcon$launchFromLocation$(SBWebApplicationIcon* self, SEL _cmd, int loc) {
    NSLog(@"Akasaka's Directlauncher 1.0 :3");
    NSLog(@"many thx 2 Arien :3");
    id webc = [self webClip];
    id info = [webc _info];
    if([info[@"Orientations"]integerValue] == kOrientationIsDL) {
        [[UIApplication sharedApplication]openURL: [NSURL URLWithString:info[@"URL"]]];
        return;
    }
    _logos_orig$_ungrouped$SBWebApplicationIcon$launchFromLocation$(self, _cmd, loc);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBWebApplicationIcon = objc_getClass("SBWebApplicationIcon"); MSHookMessageEx(_logos_class$_ungrouped$SBWebApplicationIcon, @selector(launchFromLocation:), (IMP)&_logos_method$_ungrouped$SBWebApplicationIcon$launchFromLocation$, (IMP*)&_logos_orig$_ungrouped$SBWebApplicationIcon$launchFromLocation$);}  }
#line 18 "/Users/tigra/Desktop/Coding/WebclipMan/DirectOpener/DirectOpener/DirectOpener.xm"
