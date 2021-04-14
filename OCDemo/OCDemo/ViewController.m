//
//  ViewController.m
//  OCDemo
//
//  Created by Jo on 2021/4/10.
//

#import "ViewController.h"
#import "Localization.h"
#import "LanguageTool.h"

@interface ViewController()

@property (weak) IBOutlet NSStackView *constStack;

@property (weak) IBOutlet NSStackView *identifierStack;

@property (weak) IBOutlet NSStackView *unlocalizedStack;

@property (weak) IBOutlet NSBox *constBox;

@property (weak) IBOutlet NSBox *identifierBox;

@property (weak) IBOutlet NSBox *unlocalizedBox;

@property (weak) IBOutlet NSPopUpButton *languagePop;

@property (nonatomic, copy) NSString *language;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.languagePop addItemsWithTitles:@[@"zh-Hans", @"en", @"ja", @"de"]];
    [self.languagePop selectItemWithTitle:self.language];
    
    self.constBox.title = LLC(lConstBoxNameKey, "");
    self.identifierBox.title = LLC(lIdentifierBoxNameKey, "");
    self.unlocalizedBox.title = LLC(lUnlocalizedBoxNameKey, "");

    NSArray <NSString *> *animals = @[
        LLC(lAnimalsDogNameKey, comment: @"狗"),
        LLC(lAnimalsCatNameKey, comment: @"猫"),
        LLC(lAnimalsSharkNameKey, comment: @"鲨鱼"),
        LLC(lAnimalsTigerNameKey, comment: @"老虎"),
        LLC(lAnimalsCheetahNameKey, comment: @"猎豹")
    ];
    
    NSArray <NSString *> *flowers = @[
        LLC(@"com.auu.localization.test.flowers.fragransNameKey", comment: @"桂花"),
        LLC(@"com.auu.localization.test.flowers.lilyNameKey", comment: @"百合花"),
        LLC(@"com.auu.localization.test.flowers.peonyNameKey", comment: @"牡丹花"),
        LLC(@"com.auu.localization.test.flowers.roseNameKey", comment: @"玫瑰"),
        LLC(@"com.auu.localization.test.flowers.sunflowerNameKey", comment: @"向日葵")
    ];
    
    NSArray <NSString *> *fruits = @[
        LLC(@"com.auu.localization.test.fruits.appleNameKey", @""),
        @"香蕉",
        @"菠萝",
        @"榴莲",
        LLC(@"com.auu.localization.test.fruits.cherryNameKey", @""),
    ];
    
    for (NSString *animal in animals) {
        [self.constStack addView:[NSTextField labelWithString:animal] inGravity:NSStackViewGravityTop];
    }
    
    for (NSString *flower in flowers) {
        [self.identifierStack addView:[NSTextField labelWithString:flower] inGravity:NSStackViewGravityTop];
    }
    
    for (NSString *fruit in fruits) {
        [self.unlocalizedStack addView:[NSTextField labelWithString:fruit] inGravity:NSStackViewGravityTop];
    }
}

- (IBAction)languagePopAction:(NSPopUpButton *)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = LLC(lAlertInfoNameKey, @"是否现在重启");
    [alert addButtonWithTitle:LLC(lAlertConfirmActionNameKey, @"确定")];
    [alert addButtonWithTitle:LLC(lAlertCancelActionName, @"取消")];
    
    if (alert.runModal == NSAlertFirstButtonReturn) {
        [[NSUserDefaults standardUserDefaults] setObject:@[sender.titleOfSelectedItem] forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSURL *bundleURL = [[NSBundle mainBundle] executableURL];
        if (bundleURL != nil) {
            [NSApp hide:nil];
            [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
            [[NSWorkspace sharedWorkspace] launchApplicationAtURL:bundleURL options:NSWorkspaceLaunchNewInstance configuration:nil error:nil];
        }
        [NSApp terminate:nil];
    } else {
        [self.languagePop selectItemWithTitle:self.language];
    }
}

- (NSString *)language {
    if (_language == nil) {
        
        _language = @"zh-Hans";
        
        NSArray <NSString *> *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        
        if (languages.count > 0) {
            NSString *localLang = languages.firstObject;
            for (NSString *lang in @[@"zh-Hans", @"en", @"ja", @"de"]) {
                if ([localLang hasPrefix:lang]) {
                    _language = lang;
                    break;
                }
            }
        }
    }
    
    return _language;
}

@end
