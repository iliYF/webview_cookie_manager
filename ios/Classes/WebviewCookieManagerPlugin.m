#import "WebviewCookieManagerPlugin.h"

@implementation WebviewCookieManagerPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"cookie_manager"
            binaryMessenger:[registrar messenger]];
  WebviewCookieManagerPlugin* instance = [[WebviewCookieManagerPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"clearCookies" isEqualToString:call.method]) {
    [self clearCookies:result];
  } else if ([@"setCookies" isEqualToString:call.method]) {
    [self setCookies:call result:result];
  } else if ([@"getCookies" isEqualToString:call.method]) {
    [self getCookies:call result:result];
  } else if ([@"hasCookies" isEqualToString:call.method]) {
    [self hasCookies:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)clearCookies:(FlutterResult)result {
  // TODO
  result(@(NO));
}

- (void)setCookies:(FlutterMethodCall *)call result:(FlutterResult)result {
  // TODO
  result(nil);
}


- (void)getCookies:(FlutterMethodCall *)call result:(FlutterResult)result {
  // TODO
  result(nil);
}

- (void)hasCookies:(FlutterResult)result {
  // TODO
  result(@(NO));
}

@end
