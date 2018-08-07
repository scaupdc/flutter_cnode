#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "MMScanViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* scanChannel = [FlutterMethodChannel methodChannelWithName:@"scaupdc.github.io/scan" binaryMessenger:controller];
    
    [scanChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"invokeScan" isEqualToString:call.method]) {
            MMScanViewController *vc = [[MMScanViewController alloc] initWithQrType:MMScanTypeQrCode onFinish:^(NSString *_result, NSError *error) {
                if (error) {
                    result(@"error");
                } else {
                    result(_result);
                }
            }];
            [controller presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
