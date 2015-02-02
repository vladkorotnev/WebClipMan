//
//  ARWebClip.h
//  WebclipMan
//
//  Created by Akasaka Ryuunosuke on 14/05/14.
//  Copyright (c) 2014 Akasaka Ryuunosuke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ARWebClip : NSObject
+ (ARWebClip*) webclipWithDirectory: (NSString*)path;
+ (ARWebClip*) newWebclip;
- (void) _sync;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* url;
@property (nonatomic) bool fullScreen;
@property (nonatomic) NSString* path;
@property (nonatomic, setter = setClassic:) bool isClassic;
@property (nonatomic) bool iconIsPrecomposed;
@property (nonatomic) bool isDirect;
- (void) setIcon: (UIImage*)icon;
- (UIImage*) iconAsAppIcon: (bool)asAppIcon;
@property (nonatomic) NSMutableDictionary *innerData;
@end
@interface UIImage (priv)
-(UIImage*)_applicationIconImageForFormat:(int)format precomposed:(BOOL)precomposed;
@end