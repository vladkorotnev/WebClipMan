//
//  ARWebClip.m
//  WebclipMan
//
//  Created by Akasaka Ryuunosuke on 14/05/14.
//  Copyright (c) 2014 Akasaka Ryuunosuke. All rights reserved.
//

#import "ARWebClip.h"


@implementation ARWebClip

#define kClassicModeKey @"ClassicMode"
#define kFullScreenKey @"FullScreen"
#define kNoEffectKey @"IconIsPrecomposed"
#define kTitleKey @"Title"
#define kURLKey @"URL"
#define kOrientationsKey @"Orientations"
#define kStatusBarKey @"UIStatusBarStyle"
#define kIconIsScreenshotKey @"IconIsScreenshotBased"
#define kIsDirectKey @"AHDirectOpenEnabled"

+ (ARWebClip*) webclipWithDirectory: (NSString*)path {
    ARWebClip * me = [[ARWebClip alloc]init];
    if (me) {
        [me setPath:path];
        [me _read];
    }
    return me;
}
+ (ARWebClip*) newWebclip {
    ARWebClip * me = [[ARWebClip alloc]init];
    if (me) {
        [me setPath:[NSString stringWithFormat:@"/var/mobile/Library/WebClips/%@.webclip",[[NSUUID UUID] UUIDString]]];
        [[NSFileManager defaultManager]createDirectoryAtPath:me.path withIntermediateDirectories:true attributes:Nil error:nil];
        [me _mknew];
    }
    return me;
}
- (void) _read {
    NSDictionary *initialData = [NSDictionary dictionaryWithContentsOfFile:[self.path stringByAppendingPathComponent:@"Info.plist"]];
    NSLog(@"Reading initial data of %@: \n%@",self.path, initialData);
    NSLog(@"We are %@",self);
    self.innerData = [NSMutableDictionary new];
    for (NSString*k in initialData.allKeys) {
        [self.innerData setObject:initialData[k] forKey:k];
    }
    NSLog(@"mk mutable copy");
    self.title =self.innerData[kTitleKey];
    NSLog(@"Read title");
    self.url = self.innerData[kURLKey];
    NSLog(@"Read url");
    self.fullScreen = [self.innerData[kFullScreenKey] boolValue];
    NSLog(@"Read full");
    self.isClassic = [self.innerData[kClassicModeKey] boolValue];
    NSLog(@"Read classic");
    self.iconIsPrecomposed = [self.innerData[kNoEffectKey] boolValue];
    NSLog(@"Read no eff");
    self.isDirect = [self.innerData[kIsDirectKey] boolValue];
    NSLog(@"Read direct");
}
- (void) _mknew {
    self.innerData = [ @{
                    kClassicModeKey: [NSNumber numberWithBool:false],
                    kFullScreenKey: [NSNumber numberWithBool:true],
                    kNoEffectKey: [NSNumber numberWithBool:false],
                    kTitleKey: @"Untitled",
                    kURLKey: @"http://",
                    kOrientationsKey: [NSNumber numberWithInteger:0],
                    kStatusBarKey: @"UIStatusBarStyleGray",
                    kIconIsScreenshotKey:[NSNumber numberWithBool:false],
                    kIsDirectKey: [NSNumber numberWithBool:false]
                    } mutableCopy];
    self.fullScreen = true;
    self.title = @"";
    self.url = @"";
    [self setIcon:[UIImage imageNamed:@"tpl"]];
    [self _sync];
}
#define kOrientationIsDL 100500

- (void) _sync {
    NSLog(@"Write to %@",[self.path stringByAppendingPathComponent:@"Info.plist"]);
    self.innerData = [ @{
                         kClassicModeKey: [NSNumber numberWithBool:self.isClassic],
                         kFullScreenKey: [NSNumber numberWithBool:self.fullScreen],
                         kNoEffectKey: [NSNumber numberWithBool:self.iconIsPrecomposed],
                         kTitleKey: self.title,
                         kURLKey: self.url,
                         kOrientationsKey: [NSNumber numberWithInteger: (self.isDirect ? kOrientationIsDL : 0)],
                         kStatusBarKey: @"UIStatusBarStyleGray",
                         kIconIsScreenshotKey:[NSNumber numberWithBool:false],
                         kIsDirectKey: [NSNumber numberWithBool:self.isDirect]
                         } mutableCopy];
    [self.innerData writeToFile:[self.path stringByAppendingPathComponent:@"Info.plist"] atomically:false];
}

- (void) setIcon:(UIImage *)icon {
    NSLog(@"Write to %@",[self.path stringByAppendingPathComponent:@"icon.png"]);
    [UIImagePNGRepresentation(icon) writeToFile:[self.path stringByAppendingPathComponent:@"icon.png"] atomically:false];
}
#define kGCIconFormat 3
#define kSBIconFormat 2
- (UIImage*)iconAsAppIcon:(bool)asAppIcon {
    UIImage *ico = [UIImage imageWithContentsOfFile:[self.path stringByAppendingPathComponent:@"icon.png"]];
    if (asAppIcon)
        return [ico _applicationIconImageForFormat:kSBIconFormat precomposed:self.iconIsPrecomposed];
    return ico;
}
@end
