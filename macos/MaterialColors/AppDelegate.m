#import "AppDelegate.h"

#import "RCTBridge.h"
#import "RCTJavaScriptLoader.h"
#import "RCTRootView.h"
#import <Cocoa/Cocoa.h>

@interface AppDelegate() <RCTBridgeDelegate>

@end

@implementation AppDelegate

-(id)init
{
    if(self = [super init]) {
        NSRect contentSize = NSMakeRect(100, 20, 200, 515); // initial size of main NSWindow

        self.window = [[NSWindow alloc] initWithContentRect:contentSize
                                                  styleMask:NSTitledWindowMask | NSFullSizeContentViewWindowMask | NSMiniaturizableWindowMask | NSClosableWindowMask
                                                    backing:NSBackingStoreBuffered
                                                      defer:NO];
        NSWindowController *windowController = [[NSWindowController alloc] initWithWindow:self.window];
      
        [[self window] setTitleVisibility:NSWindowTitleHidden];
        [[self window] setTitlebarAppearsTransparent:YES];
        [[self window] setAppearance:[NSAppearance appearanceNamed:NSAppearanceNameAqua]];

        [windowController setShouldCascadeWindows:NO];
        [windowController setWindowFrameAutosaveName:@"MaterialColors"];

        [windowController showWindow:self.window];

        [self setUpApplicationMenu];
    }
    return self;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
  return YES;
}

- (void)applicationDidFinishLaunching:(__unused NSNotification *)aNotification
{

    _bridge = [[RCTBridge alloc] initWithDelegate:self
                                              launchOptions:nil];

    RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:_bridge
                                                     moduleName:@"MaterialColors"
                                              initialProperties:nil];



    [self.window setContentView:rootView];
}


- (NSURL *)sourceURLForBridge:(__unused RCTBridge *)bridge
{
    NSURL *sourceURL;

#if DEBUG
    sourceURL = [NSURL URLWithString:@"http://localhost:8081/index.macos.bundle?platform=macos&dev=true"];
#else
    sourceURL = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif

    return sourceURL;
}

- (void)loadSourceForBridge:(RCTBridge *)bridge
                  withBlock:(RCTSourceLoadBlock)loadCallback
{
    [RCTJavaScriptLoader loadBundleAtURL:[self sourceURLForBridge:bridge]
                              onComplete:loadCallback];
}


- (void)setUpApplicationMenu
{
    NSMenuItem *containerItem = [[NSMenuItem alloc] init];
    NSMenu *rootMenu = [[NSMenu alloc] initWithTitle:@"" ];
    [containerItem setSubmenu:rootMenu];
    [rootMenu addItemWithTitle:@"Quit MaterialColors" action:@selector(terminate:) keyEquivalent:@"q"];
    [[NSApp mainMenu] addItem:containerItem];
}

- (id)firstResponder
{
    return [self.window firstResponder];
}

@end
