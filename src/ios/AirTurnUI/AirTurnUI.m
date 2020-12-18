#import "AirTurnUI.h"
#import <AirTurnInterface/AirTurnKeyboardManager.h>

//
//  UIActivityIndicatorView(iOSVersionSupport).h
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface UIActivityIndicatorView(iOSVersionSupport)

+ (UIActivityIndicatorView *)standardActivityIndicatorView;

@end

NS_ASSUME_NONNULL_END


//
//  UIActivityIndicatorView(iOSVersionSupport).m
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


@implementation UIActivityIndicatorView(iOSVersionSupport)

+ (UIActivityIndicatorView *)standardActivityIndicatorView {
    UIActivityIndicatorView *activityIndicator;
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if(@available(iOS 13, *)) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    } else
    #endif
    {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 130000
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
#endif
    }
    return activityIndicator;
}

@end


//
//  UIColor(iOSVersionSupport).h
//  AirTurnExample
//
//  Created by Nick Brook on 02/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface UIColor(iOSVersionSupport)

@property(class, readonly) UIColor *standardTextColor;
@property(class, readonly) UIColor *disabledColor;

@end

NS_ASSUME_NONNULL_END


//
//  UIColor(iOSVersionSupport).m
//  AirTurnExample
//
//  Created by Nick Brook on 02/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


@implementation UIColor(iOSVersionSupport)

+ (instancetype)standardTextColor {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if(@available(iOS 13, *)) {
        return [UIColor labelColor];
    } else
#endif
    {
        return [UIColor blackColor];
    }
}

+ (instancetype)disabledColor {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if(@available(iOS 13, *)) {
        return [UIColor placeholderTextColor];
    } else
#endif
    {
        return [UIColor grayColor];
    }
}

@end


//
//  UITableViewCell(AccessoryViewAdditions).h
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell(AccessoryViewAdditions)

- (void)setAccessoryViews:(nullable NSArray<UIView *> *)views;

@end

NS_ASSUME_NONNULL_END


//
//  UITableViewCell(AccessoryViewAdditions).m
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


@implementation UITableViewCell(AccessoryViewAdditions)

- (void)setAccessoryViews:(NSArray<UIView *> *)views {
    if(views.count == 0) {
        self.accessoryView = nil;
        return;
    }
    UIView *outer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    [outer setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [outer setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [outer setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [outer setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    UIView *lastView = nil;
    for(UIView *v in views) {
        v.translatesAutoresizingMaskIntoConstraints = NO;
        [outer addSubview:v];
        if(!lastView) {
            [outer addConstraint:[NSLayoutConstraint constraintWithItem:outer attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:views[0] attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        }
        [outer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=0-[v]->=0-|" options:0 metrics:nil views:@{@"v":v}]];
        [outer addConstraint:[NSLayoutConstraint constraintWithItem:outer attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        if(lastView) {
            [outer addConstraint:[NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeLeft multiplier:1 constant:-8]];
        }
        [v setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [v setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [v setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [v setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        lastView = v;
    }
    [outer addConstraint:[NSLayoutConstraint constraintWithItem:outer attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:lastView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];

    outer.translatesAutoresizingMaskIntoConstraints = NO;
    [outer setNeedsLayout];
    [outer layoutIfNeeded];
    [outer sizeToFit];
    self.accessoryView = outer;
    outer.translatesAutoresizingMaskIntoConstraints = YES;
}

@end



//
//  NonTruncatedDetailTableViewCell.h
//  AirTurnExample
//
//  Created by Nick Brook on 05/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface NonTruncatedDetailTableViewCell : UITableViewCell

@end

NS_ASSUME_NONNULL_END


//
//  NonTruncatedDetailTableViewself.m
//  AirTurnExample
//
//  Created by Nick Brook on 05/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


@implementation NonTruncatedDetailTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    // adjust text sizes to make detail always fully visible
    CGRect detailFrame = self.detailTextLabel.frame;
    [self.detailTextLabel sizeToFit];
    CGFloat difference = self.detailTextLabel.frame.size.width - detailFrame.size.width;
    detailFrame.origin.x -= difference;
    detailFrame.size.width = self.detailTextLabel.frame.size.width;
    self.detailTextLabel.frame = detailFrame;
    CGRect textFrame = self.textLabel.frame;
    textFrame.size.width -= difference;
    self.textLabel.frame = textFrame;
}

@end


//
//  AirTurnUILocalizedString.m
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


NSBundle * _Nonnull AirTurnUIBundle;

#define AirTurnUILocalizedString(key, comment) \
[AirTurnUIBundle localizedStringForKey:(key) value:@"" table:@"AirTurnUI"]

__attribute__((constructor)) static void AirTurnUILocalizedStringInitialize() {
    AirTurnUIBundle = [NSBundle bundleWithIdentifier:@"AirTurnUI"];
    if(AirTurnUIBundle == nil) {
        AirTurnUIBundle = [NSBundle mainBundle];
    }
}


//
//  AirTurnViewManager(KeyDescriptions).h
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface AirTurnViewManager(KeyDescriptions)

+ (NSString *)keyDescriptionFromKeyCode:(AirTurnKeyCode)keyCode;

@end

NS_ASSUME_NONNULL_END


//
//  AirTurnViewManager(KeyDescriptions).m
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


@implementation AirTurnViewManager(KeyDescriptions)

+ (NSString *)keyDescriptionFromKeyCode:(AirTurnKeyCode)keyCode {
    static NSDictionary<NSNumber *, NSString *> *codes = nil;
    if(codes == nil) {
        codes = @{
            @(AirTurnKeyCodeUnknown): NSLocalizedString(@"Unknown", @"Unknown key pressed"),
            @(AirTurnKeyCodeA): NSLocalizedString(@"A", @"A key pressed"),
            @(AirTurnKeyCodeB): NSLocalizedString(@"B", @"B key pressed"),
            @(AirTurnKeyCodeC): NSLocalizedString(@"C", @"C key pressed"),
            @(AirTurnKeyCodeD): NSLocalizedString(@"D", @"D key pressed"),
            @(AirTurnKeyCodeE): NSLocalizedString(@"E", @"E key pressed"),
            @(AirTurnKeyCodeF): NSLocalizedString(@"F", @"F key pressed"),
            @(AirTurnKeyCodeG): NSLocalizedString(@"G", @"G key pressed"),
            @(AirTurnKeyCodeH): NSLocalizedString(@"H", @"H key pressed"),
            @(AirTurnKeyCodeI): NSLocalizedString(@"I", @"I key pressed"),
            @(AirTurnKeyCodeJ): NSLocalizedString(@"J", @"J key pressed"),
            @(AirTurnKeyCodeK): NSLocalizedString(@"K", @"K key pressed"),
            @(AirTurnKeyCodeL): NSLocalizedString(@"L", @"L key pressed"),
            @(AirTurnKeyCodeM): NSLocalizedString(@"M", @"M key pressed"),
            @(AirTurnKeyCodeN): NSLocalizedString(@"N", @"N key pressed"),
            @(AirTurnKeyCodeO): NSLocalizedString(@"O", @"O key pressed"),
            @(AirTurnKeyCodeP): NSLocalizedString(@"P", @"P key pressed"),
            @(AirTurnKeyCodeQ): NSLocalizedString(@"Q", @"Q key pressed"),
            @(AirTurnKeyCodeR): NSLocalizedString(@"R", @"R key pressed"),
            @(AirTurnKeyCodeS): NSLocalizedString(@"S", @"S key pressed"),
            @(AirTurnKeyCodeT): NSLocalizedString(@"T", @"T key pressed"),
            @(AirTurnKeyCodeU): NSLocalizedString(@"U", @"U key pressed"),
            @(AirTurnKeyCodeV): NSLocalizedString(@"V", @"V key pressed"),
            @(AirTurnKeyCodeW): NSLocalizedString(@"W", @"W key pressed"),
            @(AirTurnKeyCodeX): NSLocalizedString(@"X", @"X key pressed"),
            @(AirTurnKeyCodeY): NSLocalizedString(@"Y", @"Y key pressed"),
            @(AirTurnKeyCodeZ): NSLocalizedString(@"Z", @"Z key pressed"),
            @(AirTurnKeyCode1): NSLocalizedString(@"1", @"1 key pressed"),
            @(AirTurnKeyCode2): NSLocalizedString(@"2", @"2 key pressed"),
            @(AirTurnKeyCode3): NSLocalizedString(@"3", @"3 key pressed"),
            @(AirTurnKeyCode4): NSLocalizedString(@"4", @"4 key pressed"),
            @(AirTurnKeyCode5): NSLocalizedString(@"5", @"5 key pressed"),
            @(AirTurnKeyCode6): NSLocalizedString(@"6", @"6 key pressed"),
            @(AirTurnKeyCode7): NSLocalizedString(@"7", @"7 key pressed"),
            @(AirTurnKeyCode8): NSLocalizedString(@"8", @"8 key pressed"),
            @(AirTurnKeyCode9): NSLocalizedString(@"9", @"9 key pressed"),
            @(AirTurnKeyCode0): NSLocalizedString(@"0", @"0 key pressed"),
            @(AirTurnKeyCodeBackslash): NSLocalizedString(@"Backslash", @"Backslash key pressed"),
            @(AirTurnKeyCodeNonUSPound): NSLocalizedString(@"NonUSPound", @"NonUSPound key pressed"),
            @(AirTurnKeyCodeComma): NSLocalizedString(@"Comma", @"Comma key pressed"),
            @(AirTurnKeyCodeEqual): NSLocalizedString(@"Equal", @"Equal key pressed"),
            @(AirTurnKeyCodeGrave): NSLocalizedString(@"Grave", @"Grave key pressed"),
            @(AirTurnKeyCodeLeftBracket): NSLocalizedString(@"Left Bracket", @"Left Bracket key pressed"),
            @(AirTurnKeyCodeRightBracket): NSLocalizedString(@"Right Bracket", @"Right Bracket key pressed"),
            @(AirTurnKeyCodeMinus): NSLocalizedString(@"Minus", @"Minus key pressed"),
            @(AirTurnKeyCodePeriod): NSLocalizedString(@"Period", @"Period key pressed"),
            @(AirTurnKeyCodeQuote): NSLocalizedString(@"Quote", @"Quote key pressed"),
            @(AirTurnKeyCodeSemicolon): NSLocalizedString(@"Semicolon", @"Semicolon key pressed"),
            @(AirTurnKeyCodeSlash): NSLocalizedString(@"Slash", @"Slash key pressed"),
            @(AirTurnKeyCodeCapsLock): NSLocalizedString(@"Slash", @"Slash key pressed"),
            @(AirTurnKeyCodeForwardDelete): NSLocalizedString(@"Forward Delete", @"Forward Delete key pressed"),
            @(AirTurnKeyCodeDelete): NSLocalizedString(@"Delete", @"Delete key pressed"),
            @(AirTurnKeyCodeUpArrow): NSLocalizedString(@"Up Arrow", @"Up Arrow key pressed"),
            @(AirTurnKeyCodeRightArrow): NSLocalizedString(@"Right Arrow", @"Right Arrow key pressed"),
            @(AirTurnKeyCodeDownArrow): NSLocalizedString(@"Down Arrow", @"Down Arrow key pressed"),
            @(AirTurnKeyCodeLeftArrow): NSLocalizedString(@"Left Arrow", @"Left Arrow key pressed"),
            @(AirTurnKeyCodeHome): NSLocalizedString(@"Home", @"Home key pressed"),
            @(AirTurnKeyCodeEnd): NSLocalizedString(@"End", @"End key pressed"),
            @(AirTurnKeyCodePageUp): NSLocalizedString(@"Page Up", @"Page Up key pressed"),
            @(AirTurnKeyCodePageDown): NSLocalizedString(@"Page Down", @"Page Down key pressed"),
            @(AirTurnKeyCodeReturn): NSLocalizedString(@"Return", @"Return key pressed"),
            @(AirTurnKeyCodeEscape): NSLocalizedString(@"Escape", @"Escape key pressed"),
            @(AirTurnKeyCodeSpace): NSLocalizedString(@"Space", @"Space key pressed"),
            @(AirTurnKeyCodeTab): NSLocalizedString(@"Tab", @"Tab key pressed"),
            @(AirTurnKeyCodeF1): NSLocalizedString(@"F1", @"F1 key pressed"),
            @(AirTurnKeyCodeF2): NSLocalizedString(@"F2", @"F2 key pressed"),
            @(AirTurnKeyCodeF3): NSLocalizedString(@"F3", @"F3 key pressed"),
            @(AirTurnKeyCodeF4): NSLocalizedString(@"F4", @"F4 key pressed"),
            @(AirTurnKeyCodeF5): NSLocalizedString(@"F5", @"F5 key pressed"),
            @(AirTurnKeyCodeF6): NSLocalizedString(@"F6", @"F6 key pressed"),
            @(AirTurnKeyCodeF7): NSLocalizedString(@"F7", @"F7 key pressed"),
            @(AirTurnKeyCodeF8): NSLocalizedString(@"F8", @"F8 key pressed"),
            @(AirTurnKeyCodeF9): NSLocalizedString(@"F9", @"F9 key pressed"),
            @(AirTurnKeyCodeF10): NSLocalizedString(@"F10", @"F10 key pressed"),
            @(AirTurnKeyCodeF11): NSLocalizedString(@"F11", @"F11 key pressed"),
            @(AirTurnKeyCodeF12): NSLocalizedString(@"F12", @"F12 key pressed"),
            @(AirTurnKeyCodeF13): NSLocalizedString(@"F13", @"F13 key pressed"),
            @(AirTurnKeyCodeF14): NSLocalizedString(@"F14", @"F14 key pressed"),
            @(AirTurnKeyCodeF15): NSLocalizedString(@"F15", @"F15 key pressed"),
            @(AirTurnKeyCodeF16): NSLocalizedString(@"F16", @"F16 key pressed"),
            @(AirTurnKeyCodeF17): NSLocalizedString(@"F17", @"F17 key pressed"),
            @(AirTurnKeyCodeF18): NSLocalizedString(@"F18", @"F18 key pressed"),
            @(AirTurnKeyCodeF19): NSLocalizedString(@"F19", @"F19 key pressed"),
            @(AirTurnKeyCodeF20): NSLocalizedString(@"F20", @"F20 key pressed"),
            @(AirTurnKeyCodeF21): NSLocalizedString(@"F21", @"F21 key pressed"),
            @(AirTurnKeyCodeF22): NSLocalizedString(@"F22", @"F22 key pressed"),
            @(AirTurnKeyCodeF23): NSLocalizedString(@"F23", @"F23 key pressed"),
            @(AirTurnKeyCodeF24): NSLocalizedString(@"F24", @"F24 key pressed"),
            @(AirTurnKeyCodePrintScreen): NSLocalizedString(@"Print Screen", @"Print Screen key pressed"),
            @(AirTurnKeyCodeScrollLock): NSLocalizedString(@"Scroll lock", @"Scroll lock key pressed"),
            @(AirTurnKeyCodePause): NSLocalizedString(@"Pause", @"Pause key pressed"),
            @(AirTurnKeyCodeInsert): NSLocalizedString(@"Insert", @"Insert key pressed"),
            @(AirTurnKeyCodeNonUSBackslash): NSLocalizedString(@"NonUSBackslash", @"NonUSBackslash key pressed"),
            @(AirTurnKeyCodeApplication): NSLocalizedString(@"Application", @"Application key pressed"),
            @(AirTurnKeyCodePower): NSLocalizedString(@"Power", @"Power key pressed"),
            @(AirTurnKeyCodeExecute): NSLocalizedString(@"Execute", @"Execute key pressed"),
            @(AirTurnKeyCodeHelp): NSLocalizedString(@"Help", @"Help key pressed"),
            @(AirTurnKeyCodeMenu): NSLocalizedString(@"Menu", @"Menu key pressed"),
            @(AirTurnKeyCodeSelect): NSLocalizedString(@"Select", @"Select key pressed"),
            @(AirTurnKeyCodeStop): NSLocalizedString(@"Stop", @"Stop key pressed"),
            @(AirTurnKeyCodeAgain): NSLocalizedString(@"Again", @"Again key pressed"),
            @(AirTurnKeyCodeUndo): NSLocalizedString(@"Undo", @"Undo key pressed"),
            @(AirTurnKeyCodeCut): NSLocalizedString(@"Cut", @"Cut key pressed"),
            @(AirTurnKeyCodeCopy): NSLocalizedString(@"Copy", @"Copy key pressed"),
            @(AirTurnKeyCodePaste): NSLocalizedString(@"Paste", @"Paste key pressed"),
            @(AirTurnKeyCodeFind): NSLocalizedString(@"Find", @"Find key pressed"),
            @(AirTurnKeyCodeMute): NSLocalizedString(@"Mute", @"Mute key pressed"),
            @(AirTurnKeyCodeVolumeUp): NSLocalizedString(@"Volume Up", @"Volume Up key pressed"),
            @(AirTurnKeyCodeVolumeDown): NSLocalizedString(@"Volume Down", @"Volume Down key pressed"),
            @(AirTurnKeyCodeLockingCapsLock): NSLocalizedString(@"Locking Caps Lock", @"Locking Caps Lock key pressed"),
            @(AirTurnKeyCodeLockingNumLock): NSLocalizedString(@"Locking Num Lock", @"Locking num lock key pressed"),
            @(AirTurnKeyCodeLockingScrollLock): NSLocalizedString(@"Locking Scroll Lock", @"Locking Scroll Lock key pressed"),
            @(AirTurnKeyCodeInternational1): NSLocalizedString(@"International1", @"International1 key pressed"),
            @(AirTurnKeyCodeInternational2): NSLocalizedString(@"International2", @"International2 key pressed"),
            @(AirTurnKeyCodeInternational3): NSLocalizedString(@"International3", @"International3 key pressed"),
            @(AirTurnKeyCodeInternational4): NSLocalizedString(@"International4", @"International4 key pressed"),
            @(AirTurnKeyCodeInternational5): NSLocalizedString(@"International5", @"International5 key pressed"),
            @(AirTurnKeyCodeInternational6): NSLocalizedString(@"International6", @"International6 key pressed"),
            @(AirTurnKeyCodeInternational7): NSLocalizedString(@"International7", @"International7 key pressed"),
            @(AirTurnKeyCodeInternational8): NSLocalizedString(@"International8", @"International8 key pressed"),
            @(AirTurnKeyCodeInternational9): NSLocalizedString(@"International9", @"International9 key pressed"),
            @(AirTurnKeyCodeLANG1): NSLocalizedString(@"LANG1", @"LANG1 key pressed"),
            @(AirTurnKeyCodeLANG2): NSLocalizedString(@"LANG2", @"LANG2 key pressed"),
            @(AirTurnKeyCodeLANG3): NSLocalizedString(@"LANG3", @"LANG3 key pressed"),
            @(AirTurnKeyCodeLANG4): NSLocalizedString(@"LANG4", @"LANG4 key pressed"),
            @(AirTurnKeyCodeLANG5): NSLocalizedString(@"LANG5", @"LANG5 key pressed"),
            @(AirTurnKeyCodeLANG6): NSLocalizedString(@"LANG6", @"LANG6 key pressed"),
            @(AirTurnKeyCodeLANG7): NSLocalizedString(@"LANG7", @"LANG7 key pressed"),
            @(AirTurnKeyCodeLANG8): NSLocalizedString(@"LANG8", @"LANG8 key pressed"),
            @(AirTurnKeyCodeLANG9): NSLocalizedString(@"LANG9", @"LANG9 key pressed"),
            @(AirTurnKeyCodeAlternateErase): NSLocalizedString(@"AlternateErase", @"AlternateErase key pressed"),
            @(AirTurnKeyCodeSysReqOrAttention): NSLocalizedString(@"SysReq/Attention", @"SysReq/Attention key pressed"),
            @(AirTurnKeyCodeCancel): NSLocalizedString(@"Cancel", @"Cancel key pressed"),
            @(AirTurnKeyCodeClear): NSLocalizedString(@"Clear", @"Clear key pressed"),
            @(AirTurnKeyCodePrior): NSLocalizedString(@"Prior", @"Prior key pressed"),
            @(AirTurnKeyCodeReturn2): NSLocalizedString(@"Return", @"Return key pressed"),
            @(AirTurnKeyCodeSeparator): NSLocalizedString(@"Separator", @"Separator key pressed"),
            @(AirTurnKeyCodeOut): NSLocalizedString(@"Out", @"Out key pressed"),
            @(AirTurnKeyCodeOper): NSLocalizedString(@"Oper", @"Oper key pressed"),
            @(AirTurnKeyCodeClearOrAgain): NSLocalizedString(@"Clear/Again", @"Clear/Again key pressed"),
            @(AirTurnKeyCodeCrSelOrProps): NSLocalizedString(@"CrSel/Props", @"CrSel/Props key pressed"),
            @(AirTurnKeyCodeExSel): NSLocalizedString(@"ExSel", @"ExSel key pressed"),
            @(AirTurnKeyCodeLeftControl): NSLocalizedString(@"Left Control", @"Left Control key pressed"),
            @(AirTurnKeyCodeLeftShift): NSLocalizedString(@"Left Shift", @"Left Shift key pressed"),
            @(AirTurnKeyCodeLeftAlt): NSLocalizedString(@"Left Alt", @"Left Alt key pressed"),
            @(AirTurnKeyCodeLeftGUI): NSLocalizedString(@"Left GUI", @"Left GUI key pressed"),
            @(AirTurnKeyCodeRightControl): NSLocalizedString(@"Right Control", @"Right Control key pressed"),
            @(AirTurnKeyCodeRightShift): NSLocalizedString(@"Right Shift", @"Right Shift key pressed"),
            @(AirTurnKeyCodeRightAlt): NSLocalizedString(@"Right Alt", @"Right Alt key pressed"),
            @(AirTurnKeyCodeRightGUI): NSLocalizedString(@"Right GUI", @"Right GUI key pressed"),
            @(AirTurnKeyCodeKeypadNumLock): NSLocalizedString(@"Keypad NumLock or Clear", @"Keypad NumLock or Clear key pressed"),
            @(AirTurnKeyCodeKeypadSlash): NSLocalizedString(@"Keypad /", @"Keypad / key pressed"),
            @(AirTurnKeyCodeKeypadAsterisk): NSLocalizedString(@"Keypad *", @"Keypad * key pressed"),
            @(AirTurnKeyCodeKeypadHyphen): NSLocalizedString(@"Keypad -", @"Keypad - key pressed"),
            @(AirTurnKeyCodeKeypadPlus): NSLocalizedString(@"Keypad +", @"Keypad + key pressed"),
            @(AirTurnKeyCodeKeypadEnter): NSLocalizedString(@"Keypad Enter", @"Keypad Enter key pressed"),
            @(AirTurnKeyCodeKeypad1): NSLocalizedString(@"Keypad 1 or End", @"Keypad 1 or End key pressed"),
            @(AirTurnKeyCodeKeypad2): NSLocalizedString(@"Keypad 2 or Down Arrow", @"Keypad 2 or Down Arrow key pressed"),
            @(AirTurnKeyCodeKeypad3): NSLocalizedString(@"Keypad 3 or Page Down", @"Keypad 3 or Page Down key pressed"),
            @(AirTurnKeyCodeKeypad4): NSLocalizedString(@"Keypad 4 or Left Arrow", @"Keypad 4 or Left Arrow key pressed"),
            @(AirTurnKeyCodeKeypad5): NSLocalizedString(@"Keypad 5", @"Keypad 5 key pressed"),
            @(AirTurnKeyCodeKeypad6): NSLocalizedString(@"Keypad 6 or Right Arrow", @"Keypad 6 or Right Arrow key pressed"),
            @(AirTurnKeyCodeKeypad7): NSLocalizedString(@"Keypad 7 or Home", @"Keypad 7 or Home key pressed"),
            @(AirTurnKeyCodeKeypad8): NSLocalizedString(@"Keypad 8 or Up Arrow", @"Keypad 8 or Up Arrow key pressed"),
            @(AirTurnKeyCodeKeypad9): NSLocalizedString(@"Keypad 9 or Page Up", @"Keypad 9 or Page Up key pressed"),
            @(AirTurnKeyCodeKeypad0): NSLocalizedString(@"Keypad 0 or Insert", @"Keypad 0 or Insert key pressed"),
            @(AirTurnKeyCodeKeypadPeriod): NSLocalizedString(@"Keypad . or Delete", @"Keypad . or Delete key pressed"),
            @(AirTurnKeyCodeKeypadEqualSign): NSLocalizedString(@"Keypad =", @"Keypad = key pressed"),
            @(AirTurnKeyCodeKeypadComma): NSLocalizedString(@"Keypad ,", @"Keypad , key pressed"),
            @(AirTurnKeyCodeKeypadEqualSignAS400): NSLocalizedString(@"Keypad =", @"Keypad = key pressed")
        };
    }
    return codes[@(keyCode)];
}


@end


//
//  AirTurnUIKeyboardEventTracker.h
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface AirTurnUIKeyboardEventTracker : NSObject

@property(nonatomic, readonly, class) AirTurnKeyCode lastKeyEvent;

@end

NS_ASSUME_NONNULL_END


//
//  AirTurnUIKeyboardEventTracker.m
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


static AirTurnKeyCode LastKeyEvent = 0;

@implementation AirTurnUIKeyboardEventTracker

+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pedalPressed:) name:AirTurnPedalPressNotification object:nil];
}

+ (void)pedalPressed:(NSNotification *)note {
    NSNumber *num = note.userInfo[AirTurnKeyCodeKey];
    if(num == nil) return;
    LastKeyEvent = num.integerValue;
}

+ (AirTurnKeyCode)lastKeyEvent {
    return LastKeyEvent;
}

@end


//
//  AirTurnUIAppActionMappingTableViewController.h
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@class AirTurnUIAppActionMappingTableViewController;

/// The delegate for the App action mapping controller
@protocol AirTurnUIAppActionMappingDelegate <NSObject>

/// The user selected an action in the mapping controller
/// @param appActionController The mapping controller
- (void)appActionMappingDidSelectAction:(AirTurnUIAppActionMappingTableViewController *)appActionController;

@end

/// A table view controller for displaying a list for actions and allowing the user to select an action
@interface AirTurnUIAppActionMappingTableViewController : UITableViewController

/**
 A dictionary of digital app action identifiers (keys) and their associated human readable text labels. The localized version of the text labels will be used in the UI.
 */
@property(class, nonatomic, strong, nullable) NSDictionary<AirTurnAppAction, NSString *> *digitalAppActions;

/**
 A dictionary of analog app action identifiers (keys) and their associated human readable text labels. The localized version of the text labels will be used in the UI.
 */
@property(class, nonatomic, strong, nullable) NSDictionary<AirTurnAppAction, NSString *> *analogAppActions;

/// The currently selected App action
@property(nonatomic, strong, nullable) AirTurnAppAction selectedAppAction;

/// If YES, the VC displays digital app actions, otherwise displays analog app actions
@property(nonatomic, readonly) BOOL digital;

/// The port this VC is used to select an action for
@property(nonatomic, readonly) AirTurnPort port;

/// The VC delegate
@property(nonatomic, weak) id<AirTurnUIAppActionMappingDelegate> delegate;

/// Create an app action mapping controller
/// @param style The table view style to use
/// @param digital Determines if the mapping controller is for digital app actions or analog app actions
/// @param port Determines the port the mapping controller is used for
- (instancetype)initWithStyle:(UITableViewStyle)style digital:(BOOL)digital port:(AirTurnPort)port;

@end

NS_ASSUME_NONNULL_END


//
//  AirTurnUIAppActionMappingTableViewController.m
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


static NSArray<AirTurnAppAction> *DigitalAppActionIdentifiersSorted = nil;
static NSDictionary<AirTurnAppAction,NSString *> *DigitalAppActions = nil;
static NSArray<AirTurnAppAction> *AnalogAppActionIdentifiersSorted = nil;
static NSDictionary<AirTurnAppAction,NSString *> *AnalogAppActions = nil;

@interface AirTurnUIAppActionMappingTableViewController ()

@property(nonatomic, assign) BOOL digital;
@property(nonatomic, assign) AirTurnPort port;

@property(nonatomic, readonly) NSArray<AirTurnAppAction> *appActionIdentifiersSorted;
@property(nonatomic, readonly) NSDictionary<AirTurnAppAction,NSString *> *appActions;

@end

@implementation AirTurnUIAppActionMappingTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style digital:(BOOL)digital port:(AirTurnPort)port
{
    self = [super initWithStyle:style];
    if (self) {
        self.digital = digital;
        self.port = port;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.preferredContentSize = self.tableView.contentSize;
}

- (NSArray<AirTurnAppAction> *)appActionIdentifiersSorted {
    return self.digital ? DigitalAppActionIdentifiersSorted : AnalogAppActionIdentifiersSorted;
}

- (NSDictionary<AirTurnAppAction,NSString *> *)appActions {
    return self.digital ? DigitalAppActions : AnalogAppActions;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appActions.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuse = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if(cell == nil) {
        cell = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    
    if(indexPath.row == 0) {
        cell.textLabel.text = AirTurnUILocalizedString(@"None", @"None");
        cell.accessoryType = self.selectedAppAction == nil ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else {
        AirTurnAppAction action = self.appActionIdentifiersSorted[indexPath.row-1];
        NSString *key = self.appActions[action];
        cell.textLabel.text = [NSBundle.mainBundle localizedStringForKey:key value:@"" table:nil];
        cell.accessoryType = [self.selectedAppAction isEqual:action] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    #if TARGET_OS_MACCATALYST
        // prevent keyboard navigation on macOS catalyst (https://stackoverflow.com/questions/61147893/how-to-disable-default-keyboard-navigation-in-mac-catalyst-app)
        [tableView performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0.1];
    #endif
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AirTurnAppAction previous = _selectedAppAction;
    _selectedAppAction = indexPath.row == 0 ? nil : self.appActionIdentifiersSorted[indexPath.row-1];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    UITableViewCell *cell2 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:previous ? [self.appActionIdentifiersSorted indexOfObject:previous] + 1 : 0 inSection:0]];
    cell2.accessoryType = UITableViewCellAccessoryNone;
    [self.delegate appActionMappingDidSelectAction:self];
}

+ (void)setDigitalAppActions:(NSDictionary<AirTurnAppAction,NSString *> *)appActions {
    AirTurnManager.sharedManager.digitalAppActions = appActions ? [NSSet setWithArray:appActions.allKeys] : nil;
    DigitalAppActions = appActions;
    DigitalAppActionIdentifiersSorted = [appActions.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

+ (NSDictionary<AirTurnAppAction,NSString *> *)digitalAppActions {
    return DigitalAppActions;
}

+ (void)setAnalogAppActions:(NSDictionary<AirTurnAppAction,NSString *> *)appActions {
    AirTurnManager.sharedManager.analogAppActions = appActions ? [NSSet setWithArray:appActions.allKeys] : nil;
    AnalogAppActions = appActions;
    AnalogAppActionIdentifiersSorted = [appActions.allKeys sortedArrayUsingSelector:@selector(compare:)];
}

+ (NSDictionary<AirTurnAppAction,NSString *> *)analogAppActions {
    return AnalogAppActions;
}

@end


//
//  AirTurnDeviceTableViewController.m
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


static NSString * const AutomaticKeyboardManagementUserDefaultKey = @"AirTurnAutomaticKeyboardManagement";

typedef NS_ENUM(uint8_t, DeviceSection) {
    DeviceSectionForget = 0,
    DeviceSectionDigitalPorts = 1,
    DeviceSectionAnalogPorts = 2,
    DeviceSectionKeyboardManagement = 2,
};

#define ANALOG_INDICATOR_WIDTH 2

static NSDictionary<NSNumber *, NSDictionary<NSNumber *, NSString *> *> * _Nonnull PortTitleMappings;

static BOOL DisplayActionsInPopover = NO;

@interface AirTurnUIDeviceTableViewController () <AirTurnUIAppActionMappingDelegate>

@property (nonatomic, assign) BOOL isKeyboard;
@property (nonatomic, strong) AirTurnPeripheral *peripheral;

@property (nonatomic, readonly) id<AirTurnDeviceProtocol> device;

@property (nonatomic, strong) UISwitch *automaticKeyboardManagementSwitch;

@property (nonatomic, strong) UILabel *KeyboardKeyInfoTableFooter;

@property (nonatomic, assign) CGFloat maxAnalogIndicatorConstraintValue;
@property (nonatomic, strong) NSMutableArray<NSLayoutConstraint *> *analogIndicatorViewConstraints;
@property (nonatomic, strong) NSMutableArray<UIView *> *analogIndicatorViews;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSTimer *> *portFadeDelayTimers;

@end

@implementation AirTurnUIDeviceTableViewController

+ (void)initialize
{
    if (self == [AirTurnUIDeviceTableViewController class]) {
        PortTitleMappings = @{
        @(AirTurnInputTypeDualPedal) : @{
                @(AirTurnPort1): AirTurnUILocalizedString(@"Left Pedal", @"Port 1 title for PED/PEDpro"),
                @(AirTurnPort3): AirTurnUILocalizedString(@"Right Pedal", @"Port 3 title for PED/PEDpro"),
                @(AirTurnPort6): AirTurnUILocalizedString(@"Keyboard Button", @"Port 6 title for PED/PEDpro"),
                },
        @(AirTurnInputTypeManyPedal) : @{
                @(AirTurnPort1): AirTurnUILocalizedString(@"Pedal 1", @"Port 1 title for Many pedal devices"),
                @(AirTurnPort2): AirTurnUILocalizedString(@"Pedal 3", @"Port 2 title for Many pedal devices"),
                @(AirTurnPort3): AirTurnUILocalizedString(@"Pedal 2", @"Port 3 title for Many pedal devices"),
                @(AirTurnPort4): AirTurnUILocalizedString(@"Pedal 4", @"Port 4 title for Many pedal devices"),
                @(AirTurnPort5): AirTurnUILocalizedString(@"Pedal 5", @"Port 5 title for Many pedal devices"),
                @(AirTurnPort6): AirTurnUILocalizedString(@"Pedal 6", @"Port 6 title for Many pedal devices"),
                @(AirTurnPort7): AirTurnUILocalizedString(@"Pedal 7", @"Port 7 title for Many pedal devices"),
                @(AirTurnPort8): AirTurnUILocalizedString(@"Pedal 8", @"Port 8 title for Many pedal devices"),
                },
        @(AirTurnInputTypeButton) : @{
                @(AirTurnPort1): AirTurnUILocalizedString(@"Up", @"Port 1 title for directional pad devices"),
                @(AirTurnPort2): AirTurnUILocalizedString(@"Left", @"Port 2 title for directional pad devices"),
                @(AirTurnPort3): AirTurnUILocalizedString(@"Down", @"Port 3 title for directional pad devices"),
                @(AirTurnPort4): AirTurnUILocalizedString(@"Right", @"Port 4 title for directional pad devices"),
                @(AirTurnPort5): AirTurnUILocalizedString(@"Enter", @"Port 5 title for directional pad devices"),
                @(AirTurnPort6): AirTurnUILocalizedString(@"Keyboard", @"Port 6 title for directional pad devices"),
                },
        @(AirTurnInputTypePortsAndPad) : @{
                @(AirTurnPort1): AirTurnUILocalizedString(@"Switch 1", @"Port 1 title for ports and pad devices"),
                @(AirTurnPort2): AirTurnUILocalizedString(@"Switch 2", @"Port 2 title for ports and pad devices"),
                @(AirTurnPort3): AirTurnUILocalizedString(@"Switch 3", @"Port 3 title for ports and pad devices"),
                @(AirTurnPort4): AirTurnUILocalizedString(@"Switch 4", @"Port 4 title for ports and pad devices"),
                @(AirTurnPort5): AirTurnUILocalizedString(@"Switch 5", @"Port 5 title for ports and pad devices"),
                @(AirTurnPort6): AirTurnUILocalizedString(@"Switch 6", @"Port 6 title for ports and pad devices"),
                @(AirTurnPort7): AirTurnUILocalizedString(@"Switch 7", @"Port 7 title for ports and pad devices"),
                @(AirTurnPort8): AirTurnUILocalizedString(@"Switch 8", @"Port 8 title for ports and pad devices"),
        },
        @(AirTurnInputTypeSwitch) : @{
                @(AirTurnPort1): AirTurnUILocalizedString(@"Switch 1", @"Port 1 title for Switch devices"),
                @(AirTurnPort2): AirTurnUILocalizedString(@"Switch 3", @"Port 2 title for Switch devices"),
                @(AirTurnPort3): AirTurnUILocalizedString(@"Switch 2", @"Port 3 title for Switch devices"),
                @(AirTurnPort4): AirTurnUILocalizedString(@"Switch 4", @"Port 4 title for Switch devices"),
                @(AirTurnPort5): AirTurnUILocalizedString(@"Switch 5", @"Port 5 title for Switch devices"),
                @(AirTurnPort6): AirTurnUILocalizedString(@"Switch 6", @"Port 6 title for Switch devices"),
                @(AirTurnPort7): AirTurnUILocalizedString(@"Switch 7", @"Port 7 title for Switch devices"),
                @(AirTurnPort8): AirTurnUILocalizedString(@"Switch 8", @"Port 8 title for Switch devices"),
                },
        @(AirTurnInputTypePort) : @{
                @(AirTurnPort1): AirTurnUILocalizedString(@"Port 1", @"Port 1 title for Port devices"),
                @(AirTurnPort2): AirTurnUILocalizedString(@"Port 2", @"Port 2 title for Port devices"),
                @(AirTurnPort3): AirTurnUILocalizedString(@"Port 3", @"Port 3 title for Port devices"),
                @(AirTurnPort4): AirTurnUILocalizedString(@"Port 4", @"Port 4 title for Port devices"),
                @(AirTurnPort5): AirTurnUILocalizedString(@"Port 5", @"Port 5 title for Port devices"),
                @(AirTurnPort6): AirTurnUILocalizedString(@"Port 6", @"Port 6 title for Port devices"),
                @(AirTurnPort7): AirTurnUILocalizedString(@"Port 7", @"Port 7 title for Port devices"),
                @(AirTurnPort8): AirTurnUILocalizedString(@"Port 8", @"Port 8 title for Port devices"),
                }
        };
    }
}

+ (BOOL)isKeyboardManagementEnabled {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    return [AirTurnKeyboardManager automaticKeyboardManagementAvailable] && ([defaults objectForKey:AutomaticKeyboardManagementUserDefaultKey] == nil || [defaults boolForKey:AutomaticKeyboardManagementUserDefaultKey]);
}

+ (BOOL)displayActionsInPopover {
    return DisplayActionsInPopover;
}

+ (void)setDisplayActionsInPopover:(BOOL)displayActionsInPopover {
    DisplayActionsInPopover = displayActionsInPopover;
}

- (instancetype)initIsKeyboard:(BOOL)isKeyboard peripheral:(nullable AirTurnPeripheral *)peripheral
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        NSAssert(isKeyboard || peripheral, @"Either isKeyboard must be YES or a peripheral must be provided");
        self.isKeyboard = isKeyboard;
        self.peripheral = peripheral;
        
        self.portFadeDelayTimers = [NSMutableDictionary dictionaryWithCapacity:AirTurnPortMaxNumberOfPorts];
        self.analogIndicatorViews = [NSMutableArray arrayWithCapacity:AirTurnPortMaxNumberOfPorts];
        self.analogIndicatorViewConstraints = [NSMutableArray arrayWithCapacity:AirTurnPortMaxNumberOfPorts];
        
        if(self.isKeyboard) {
            self.KeyboardKeyInfoTableFooter = [UILabel new];
            self.KeyboardKeyInfoTableFooter.font = [UIFont systemFontOfSize:18];
            self.KeyboardKeyInfoTableFooter.textColor = [UIColor grayColor];
            self.KeyboardKeyInfoTableFooter.textAlignment = NSTextAlignmentCenter;
            [self updatePedalPressed];
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(automaticKeyboardManagementChanged) name:AirTurnAutomaticKeyboardManagementEnabledChangedNotification object:nil];
        } else {
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(analogValueChanged:) name:AirTurnAnalogPortValueChangeNotification object:self.peripheral];
            [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(connectionStateChanged:) name:AirTurnConnectionStateChangedNotification object:self.peripheral];
        }
        
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(airTurnPedalPress:) name:AirTurnPedalPressNotification object:self.isKeyboard ? nil : self.peripheral];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    if(self.isKeyboard) {
        self.automaticKeyboardManagementSwitch = [[UISwitch alloc] init];
        self.automaticKeyboardManagementSwitch.accessibilityLabel = @"AirTurn automatic keyboard management enable switch";
        [self.automaticKeyboardManagementSwitch addTarget:self action:@selector(automaticKeyboardManagementSwitchChange) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat cellWidth = self.view.bounds.size.width;
    if(@available(iOS 11, *)) {
        cellWidth -= self.view.safeAreaInsets.left + self.view.safeAreaInsets.right;
    }
    CGFloat newWidth = cellWidth - ANALOG_INDICATOR_WIDTH;
    if(self.maxAnalogIndicatorConstraintValue > 0) {
        for(NSLayoutConstraint *c in self.analogIndicatorViewConstraints) {
            c.constant *= newWidth / self.maxAnalogIndicatorConstraintValue;
        }
    }
    self.maxAnalogIndicatorConstraintValue = newWidth;
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.portFadeDelayTimers.allValues makeObjectsPerformSelector:@selector(invalidate)];
    [self.portFadeDelayTimers removeAllObjects];
    [super viewDidDisappear:animated];
}

- (id<AirTurnDeviceProtocol>)device {
    return self.isKeyboard ? AirTurnViewManager.sharedViewManager : self.peripheral;
}

- (void)updatePedalPressed {
    if(!self.isKeyboard) {
        return;
    }
    NSString *string = [AirTurnViewManager keyDescriptionFromKeyCode:AirTurnUIKeyboardEventTracker.lastKeyEvent];
    if(string == nil) {
        self.KeyboardKeyInfoTableFooter.text = nil;
        return;
    }
    
    self.KeyboardKeyInfoTableFooter.text = [NSString stringWithFormat:AirTurnUILocalizedString(@"Last key pressed: %@", @"Device footer view for BT-105 indicating last key pressed"), string];
    [self.KeyboardKeyInfoTableFooter sizeToFit];
    self.tableView.tableFooterView = self.KeyboardKeyInfoTableFooter;
}

- (void)connectionStateChanged:(NSNotification *)notification {
    [self.tableView reloadData];
}

- (void)analogValueChanged:(NSNotification *)notification {
    AirTurnPort port = [notification.userInfo[AirTurnPortNumberKey] integerValue];
    AirTurnPortValue val = [notification.userInfo[AirTurnAnalogPortValueKey] shortValue];
    NSInteger offset = port - AirTurnPortMinimum;
    if(offset >= self.analogIndicatorViews.count) {
        return;
    }
    UIView *v = self.analogIndicatorViews[offset];
    v.alpha = 0.8f;
    NSLayoutConstraint *c = self.analogIndicatorViewConstraints[offset];
    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        c.constant = - self.maxAnalogIndicatorConstraintValue * val / AirTurnPortValueMax;
        if(v.window) {
            [v.superview layoutIfNeeded];
        }
    } completion:nil];
    [UIView animateWithDuration:1 delay:0.5 options:0 animations:^{
        v.alpha = 0;
    } completion:nil];
}

- (void)airTurnPedalPress:(NSNotification *)notification {
    NSInteger row = self.isKeyboard ? [notification.userInfo[AirTurnPortNumberKey] integerValue] - AirTurnPortMinimum : [self.peripheral.physicalDigitalPortOrder indexOfObject:notification.userInfo[AirTurnPortNumberKey]];
    if(row > [self.tableView numberOfRowsInSection:DeviceSectionDigitalPorts]) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:DeviceSectionDigitalPorts];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.portFadeDelayTimers[@(row)] invalidate];
    self.portFadeDelayTimers[@(row)] = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(portFadeEvent:) userInfo:nil repeats:NO];
    
    [self updatePedalPressed];
}

- (void)portFadeEvent:(NSTimer *)timer {
    NSNumber *key = [self.portFadeDelayTimers allKeysForObject:timer].firstObject;
    if(key == nil) { return; }
    [timer invalidate];
    [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:key.integerValue inSection:DeviceSectionDigitalPorts] animated:YES];
    [self.portFadeDelayTimers removeObjectForKey:key];
}

- (void)automaticKeyboardManagementChanged {
    self.automaticKeyboardManagementSwitch.on = AirTurnKeyboardManager.sharedManager.automaticKeyboardManagementEnabled;
}

- (void)automaticKeyboardManagementSwitchChange {
    AirTurnKeyboardManager.sharedManager.automaticKeyboardManagementEnabled = self.automaticKeyboardManagementSwitch.on;
    [[NSUserDefaults standardUserDefaults] setBool:self.automaticKeyboardManagementSwitch.on forKey:AutomaticKeyboardManagementUserDefaultKey];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger num = 0;
    num++; // forget
    if(self.isKeyboard) {
        num++; // digital ports
        if(AirTurnKeyboardManager.automaticKeyboardManagementAvailable) {
            num++; // automatic keyboard management
        }
    } else { // AirDirect
        if(self.peripheral.state == AirTurnConnectionStateReady) {
            num++; // digital ports
            if(self. self.peripheral.numberOfAnalogPortsAvailable > 0) {
                num++; // analog ports
            }
        }
    }
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch((DeviceSection)section) {
        case DeviceSectionForget:
            return 1;
        case DeviceSectionDigitalPorts:
            return self.isKeyboard ? 6 : self.peripheral.numberOfDigitalPortsAvailable;
        case DeviceSectionAnalogPorts:
            return self.isKeyboard ? 1 : self.peripheral.numberOfAnalogPortsAvailable;
        default:
            NSAssert(false, @"Invalid section");
    }
}

- (AirTurnPort)digitalPortForRow:(NSInteger)row {
    if(self.isKeyboard) {
        return row + AirTurnPortMinimum;
    }
    if(row > self.peripheral.physicalDigitalPortOrder.count) {
        return AirTurnPortInvalid;
    }
    return [self.peripheral.physicalDigitalPortOrder[row] integerValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NSString *reuseIdentifier;
    
    switch(indexPath.section) {
        case DeviceSectionForget:
            reuseIdentifier = @"Forget";
            cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            if(cell == nil) {
                cell = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
                cell.textLabel.text = AirTurnUILocalizedString(@"Forget this AirTurn", @"Cell label for forgetting an AirTurn");
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
                cell.textLabel.textColor = cell.textLabel.tintColor;
            }
            break;
        case DeviceSectionDigitalPorts: {
            BOOL hasAppActions = AirTurnUIAppActionMappingTableViewController.digitalAppActions.count > 0;
            reuseIdentifier = [NSString stringWithFormat:@"Digital.%ld.%d", (long)indexPath.row, hasAppActions];
            cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
            AirTurnPort port = [self digitalPortForRow:indexPath.row];
            if(cell == nil) {
                cell = [UITableViewCell.alloc initWithStyle:hasAppActions ? UITableViewCellStyleValue1 : UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
                cell.accessoryType = hasAppActions ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
                cell.textLabel.text = PortTitleMappings[@(self.isKeyboard ? AirTurnInputTypePort : self.peripheral.inputType)][@(port)];
            }
            if(hasAppActions) {
                AirTurnAppAction identifier = [self.device actionForPort:port digital:YES];
                cell.detailTextLabel.text = [NSBundle.mainBundle localizedStringForKey:AirTurnUIAppActionMappingTableViewController.digitalAppActions[identifier] value:@"" table:nil];
            }
        } break;
        case DeviceSectionAnalogPorts:
            if(self.isKeyboard) {
                reuseIdentifier = @"AutomaticKeyboardManagement";
                cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
                if(cell == nil) {
                    cell = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
                    cell.textLabel.text = AirTurnUILocalizedString(@"Force Keyboard", @"Cell label for the keyboard management toggle");
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                [self.automaticKeyboardManagementSwitch removeFromSuperview];
                cell.accessoryView = self.automaticKeyboardManagementSwitch;
                self.automaticKeyboardManagementSwitch.on = AirTurnKeyboardManager.sharedManager.automaticKeyboardManagementEnabled;
            } else {
                BOOL hasAppActions = AirTurnUIAppActionMappingTableViewController.analogAppActions.count > 0;
                reuseIdentifier = [NSString stringWithFormat:@"Analog.%ld.%d", (long)indexPath.row, hasAppActions];
                cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
                cell.accessoryType = AirTurnUIAppActionMappingTableViewController.analogAppActions ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
                if(cell == nil) {
                    cell = [UITableViewCell.alloc initWithStyle:hasAppActions ? UITableViewCellStyleValue1 : UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
                    cell.accessoryType = hasAppActions ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
                    cell.textLabel.text = [NSString stringWithFormat:AirTurnUILocalizedString(@"Input %ld", @"Analog input number"), (long)(indexPath.row + 1)];
                    UIView *indicator = UIView.new;
                    indicator.translatesAutoresizingMaskIntoConstraints = NO;
                    indicator.alpha = 0;
                    indicator.backgroundColor = indicator.tintColor;
                    [cell addSubview:indicator];
                    NSLayoutConstraint *leftConstraint;
                    if(@available(iOS 9, *)) {
                        NSLayoutAnchor *anchor;
                        if(@available(iOS 11, *)) {
                            anchor = cell.safeAreaLayoutGuide.leftAnchor;
                        } else {
                            anchor = cell.leftAnchor;
                        }
                        leftConstraint = [anchor constraintEqualToAnchor:indicator.leftAnchor constant:0];
                        [NSLayoutConstraint activateConstraints:@[
                            leftConstraint,
                            [cell.topAnchor constraintEqualToAnchor:indicator.topAnchor],
                            [cell.bottomAnchor constraintEqualToAnchor:indicator.bottomAnchor],
                            [indicator.widthAnchor constraintEqualToConstant:ANALOG_INDICATOR_WIDTH]
                        ]];
                    } else {
                        leftConstraint = [NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
                        [NSLayoutConstraint activateConstraints:@[
                            leftConstraint,
                            [NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                            [NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                            [NSLayoutConstraint constraintWithItem:indicator attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:ANALOG_INDICATOR_WIDTH]
                        ]];
                    }
                    self.analogIndicatorViewConstraints[indexPath.row] = leftConstraint;
                    self.analogIndicatorViews[indexPath.row] = indicator;
                }
                
                if(hasAppActions) {
                    AirTurnAppAction identifier = [self.device actionForPort:indexPath.row + AirTurnPortMinimum digital:NO];
                    cell.detailTextLabel.text = [NSBundle.mainBundle localizedStringForKey:AirTurnUIAppActionMappingTableViewController.analogAppActions[identifier] value:@"" table:nil];
                }
            }
            break;
        default:break;
    }
    
    if(cell == nil) {
        cell = UITableViewCell.new;
    }
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch((DeviceSection)section) {
        case DeviceSectionDigitalPorts:
            if(AirTurnUIAppActionMappingTableViewController.digitalAppActions) {
                if(self.peripheral.numberOfAnalogPortsAvailable) {
                    return AirTurnUILocalizedString(@"Digital input actions", @"Digital ports section title when app actions available");
                } else {
                    return AirTurnUILocalizedString(@"Input actions", @"Ports section title when app actions available");
                }
            } else {
                if(self.peripheral.numberOfAnalogPortsAvailable) {
                    return AirTurnUILocalizedString(@"Digital inputs", @"Digital ports section title");
                } else {
                    return AirTurnUILocalizedString(@"Inputs", @"Ports section title");
                }
            }
            break;
        case DeviceSectionAnalogPorts:
            if(self.isKeyboard) {
                return nil;
            }
            if(AirTurnUIAppActionMappingTableViewController.digitalAppActions) {
                return AirTurnUILocalizedString(@"Analog input actions", @"Analog ports section title when app actions available");
            } else {
                return AirTurnUILocalizedString(@"Analog inputs", @"Analog ports section title");
            }
            break;
        default:
            return nil;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch((DeviceSection)section) {
        case DeviceSectionDigitalPorts:
            return AirTurnUILocalizedString(@"Pressing an input on your AirTurn will highlight it in the list above", @"Digital input section footer");
        case DeviceSectionAnalogPorts:
            if(self.isKeyboard) {
                return AirTurnUILocalizedString(@"If on, the on screen keyboard will be forced on screen when a text box is active even though an external \"keyboard\" (the AirTurn) is connected", @"Keyboard management footer");
            } else {
                return AirTurnUILocalizedString(@"Moving an input on your AirTurn will highlight it in the list above", @"Analog input section footer");
            }
            break;
        default:
            return nil;
    }
    return nil;
}

- (void)presentControllerForPort:(AirTurnPort)port digital:(BOOL)digital cell:(UITableViewCell *)cell {
    AirTurnUIAppActionMappingTableViewController *controller = [AirTurnUIAppActionMappingTableViewController.alloc initWithStyle:DisplayActionsInPopover ? UITableViewStylePlain : UITableViewStyleGrouped digital:digital port:port];
    controller.selectedAppAction = [self.device actionForPort:port digital:digital];
    controller.title = [NSString stringWithFormat:AirTurnUILocalizedString(@"%@ action", @"Port action configuration title"), cell.textLabel.text];
    controller.delegate = self;
    if(DisplayActionsInPopover) {
        controller.modalPresentationStyle = UIModalPresentationPopover;
        controller.popoverPresentationController.sourceView = cell.superview;
        controller.popoverPresentationController.sourceRect = cell.frame;
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    #if TARGET_OS_MACCATALYST
        // prevent keyboard navigation on macOS catalyst (https://stackoverflow.com/questions/61147893/how-to-disable-default-keyboard-navigation-in-mac-catalyst-app)
        [tableView performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0.1];
    #endif
    switch((DeviceSection)indexPath.section) {
        case DeviceSectionForget:
            [self.navigationController popViewControllerAnimated:YES];
            [self.delegate deviceForget:self];
            break;
        case DeviceSectionDigitalPorts: {
            AirTurnPort port = [self digitalPortForRow:indexPath.row];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [self presentControllerForPort:port digital:YES cell:cell];
            return;
        }
        case DeviceSectionAnalogPorts: {
            if(!self.isKeyboard) {
                AirTurnPort port = indexPath.row - AirTurnPortMinimum;
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                [self presentControllerForPort:port digital:NO cell:cell];
                return;
            }
        } break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)appActionMappingDidSelectAction:(AirTurnUIAppActionMappingTableViewController *)appActionController {
    if(DisplayActionsInPopover) {
        [appActionController dismissViewControllerAnimated:YES completion:nil];
    }
    [self.device setAction:appActionController.selectedAppAction forPort:appActionController.port digital:appActionController.digital];
    [self.tableView reloadData];
}

@end


//
//  AirTurnUIController.m
//  AirTurnExample
//
//  Created by Nick Brook on 01/03/2014.
//
//

@import AirTurnInterface;

typedef NS_ENUM(uint8_t, UISection) {
    UISectionEnable,
    UISectionAddedDevices,
    UISectionOtherDevices,
    UISectionAddKeyboard
};

/**
 Error handling results
 */
typedef NS_ENUM(NSUInteger, AirTurnErrorHandlingResult) {
    AirTurnErrorHandlingResultNotHandled,
    AirTurnErrorHandlingResultNoError,
    AirTurnErrorHandlingResultAlert,
    AirTurnErrorHandlingResultModelNotSupported,
};

/**
 Contexts in which errors can occur
 */
typedef NS_ENUM(NSUInteger, AirTurnErrorContext) {
    /**
     No error context
     */
    AirTurnErrorContextNone,
    /**
     An error while occurring
     */
    AirTurnErrorContextConnecting,
};

#define FIRST_SECTION SECTION_ENABLE
#define LAST_SECTION SECTION_SWITCH_MODE

static NSString * const EnabledUserDefaultKey = @"AirTurnEnabled";
static NSString * const AirDirectAirTurnsEnabled = @"AirDirectAirTurnsEnabled";
static NSString * const KeyboardAirTurnEnabled = @"KeyboardAirTurnEnabled";

static NSString * const LastFirmwareUpdateVersionUserDefaultKey = @"LastFirmwareUpdateVersion";

static NSString * const AirTurnUIShouldRestoreUserInfoKey = @"AirTurnUIRestoreState";

static NSString * const ModernConnectionModeName = @"AirDirect";
static NSString * const LegacyConnectionModeName = @"Keyboard";

static NSString * const ModeSwitchInfoURL = @"https://www.airturn.com/framework/info/";
static NSString * const ModeSwitchInfoLoadNotification = @"Loaded";
static NSString * const ModeSwitchInfoTypeNotification = @"Type";
static NSString * const ModeSwitchInfoTypeNotificationContentAirDirect = @"AirDirect";
static NSString * const ModeSwitchInfoTypeNotificationContentKeyboard = @"Keyboard";

static NSString * const AppLinkURL = @"https://www.airturn.com/appLink/";

static BOOL hasFirstKeyWindow = NO;

@interface AirTurnUITableViewController () <AirTurnUIDeviceDelegate>

@property(nonatomic, readonly) BOOL viewVisible;

@property(nonatomic, assign) AirTurnCentralState previousCentralState;

@property(nonatomic, assign) BOOL scanning;

@property(nonatomic, strong) UITableViewCell *enableCell;
@property(nonatomic, strong) UISwitch *enableSwitch;

@property(nonatomic, strong) UITableViewCell *scanningCell;

@property(nonatomic, strong) UITableViewHeaderFooterView *deviceHeaderView;
@property(nonatomic, strong) UIActivityIndicatorView *deviceHeaderSpinner;

@property(nonatomic, strong) UIBarButtonItem *infoButton;

@property(nonatomic, readonly) BOOL shouldPerformAirDirectTableChange;

@property(nonatomic, assign) BOOL keyboardAdded;

@property(nonatomic, strong) NSMutableArray<AirTurnPeripheral *> *addedDevices;
@property(nonatomic, strong) NSMutableArray<AirTurnPeripheral *> *otherDevices;

@property(nonatomic, assign) BOOL supportKeyboard;
@property(nonatomic, assign) BOOL supportAirDirect;
@property(nonatomic, assign) BOOL AirDirectAvailable;

@property(nonatomic, readonly) BOOL isPoweredOn;

@property(nonatomic, strong) NSMutableDictionary<NSNumber *, NSTimer *> *pedalFadeDelayTimers;

- (IBAction)dismiss:(id)sender;

@end

@implementation AirTurnUITableViewController


+ (void)load {
    @autoreleasepool {
        NSNumber *n = [[NSBundle mainBundle] objectForInfoDictionaryKey:AirTurnUIShouldRestoreUserInfoKey];
        BOOL restoreEnabledState = n == nil || n.boolValue;
        // register for App loaded to spin up AirTurn classes if AirTurn support has previously been enabled
        if(restoreEnabledState && [[NSUserDefaults standardUserDefaults] boolForKey:EnabledUserDefaultKey]) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowDidBecomeKey) name:UIWindowDidBecomeKeyNotification object:nil];
        }
    }
}


+ (void)windowDidBecomeKey {
#if DEBUG
    NSLog(@"Starting AirTurnUI...");
#endif
	hasFirstKeyWindow = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeKeyNotification object:nil];
    if([NSUserDefaults.standardUserDefaults boolForKey:EnabledUserDefaultKey]) {
        if([NSUserDefaults.standardUserDefaults boolForKey:AirDirectAirTurnsEnabled]) {
            AirTurnCentral.sharedCentral.enabled = YES;
        }
        if([NSUserDefaults.standardUserDefaults boolForKey:KeyboardAirTurnEnabled]) {
            AirTurnViewManager.sharedViewManager.enabled = YES;
            if([AirTurnKeyboardManager sharedManager]) {
                [self keyboardManagerReady];
            } else {
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardManagerReady) name:AirTurnKeyboardManagerReadyNotification object:nil];
            }
        }
    }
}

+ (void)keyboardManagerReady {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AirTurnKeyboardManagerReadyNotification object:nil];
    [AirTurnKeyboardManager sharedManager].automaticKeyboardManagementEnabled = AirTurnUIDeviceTableViewController.isKeyboardManagementEnabled;
}


- (instancetype)initSupportingKeyboardAirTurn:(BOOL)keyboard AirDirectAirTurn:(BOOL)AirDirect {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self) {
        _displayEnableToggle = YES;
        _supportKeyboard = keyboard;
        _supportAirDirect = AirDirect;
        _maxNumberOfAirDirectAirTurns = 0;
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _displayEnableToggle = YES;
        _supportAirDirect = YES;
        _supportKeyboard = YES;
        _maxNumberOfAirDirectAirTurns = 0;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _displayEnableToggle = YES;
        _supportAirDirect = YES;
        _supportKeyboard = YES;
        _maxNumberOfAirDirectAirTurns = 0;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    @throw([NSException exceptionWithName:@"AirTurnInvalidInit" reason:@"Please use -initSupportingHIDAirTurn:BTLEAirTurn: or use in Interface Builder" userInfo:nil]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    if(self.tableView.style != UITableViewStyleGrouped)
        @throw([NSException exceptionWithName:@"AirTurnInvalidTableStyle" reason:@"Please set the table view style to grouped in interface builder" userInfo:nil]);
    [self setup];
}

- (void)setup {
    
    NSAssert(floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_8_0, @"This version of the framework only supports iOS 8.0 and higher");
    
    if(!_supportKeyboard && !_supportAirDirect) {
        @throw([NSException exceptionWithName:@"AirTurnInvalidInit" reason:@"Please initialise the class setting Keyboard and/or AirDirect support true" userInfo:nil]);
    }
    
    self.previousCentralState = [AirTurnCentral sharedCentral].state;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 25;
    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 25;
    
    self.pedalFadeDelayTimers = [NSMutableDictionary dictionaryWithCapacity:AirTurnPortMaxNumberOfPorts + 1];
    
    self.keyboardAdded = [NSUserDefaults.standardUserDefaults boolForKey:KeyboardAirTurnEnabled];
    
    self.navigationItem.title = AirTurnUILocalizedString(@"AirTurn", @"AirTurn title");
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.infoButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    [self.navigationItem setRightBarButtonItem:self.infoButton animated:NO];
    
    self.enableSwitch = [[UISwitch alloc] init];
    self.enableSwitch.accessibilityLabel = @"AirTurn enable switch";
    self.enableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    self.enableCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.enableCell.accessoryView = self.enableSwitch;
    self.enableCell.textLabel.text = AirTurnUILocalizedString(@"AirTurn Support", @"Text to display next to the enable AirTurn switch");
    
    {
        UIActivityIndicatorView *scanningSpinner = UIActivityIndicatorView.standardActivityIndicatorView;
        [scanningSpinner startAnimating];
        
        self.scanningCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        self.scanningCell.selectionStyle = UITableViewCellSelectionStyleNone;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
        if(@available(iOS 13, *)) {
            self.scanningCell.textLabel.textColor = [UIColor placeholderTextColor];
        } else
#endif
        {
            self.scanningCell.textLabel.textColor = [UIColor lightGrayColor];
        }
        self.scanningCell.accessoryView = scanningSpinner;
        self.scanningCell.textLabel.text = AirTurnUILocalizedString(@"Scanning...", @"Text to display in the placeholder for the list of devices when none have been found");
    }
    
    UILabel *tableFooter = [UILabel new];
    tableFooter.font = [UIFont systemFontOfSize:12];
    tableFooter.textColor = [UIColor grayColor];
    tableFooter.textAlignment = NSTextAlignmentLeft;
    tableFooter.text = [NSString stringWithFormat:AirTurnUILocalizedString(@"AirTurnUI Version %@", @"AirTurn UI footer version text"), AirTurnManager.sharedManager.version];
    [tableFooter sizeToFit];
    CGRect tableFooterFrame = tableFooter.frame;
    UIView *tableFooterView = UIView.new;
    [tableFooterView addSubview:tableFooter];
    CGRect tableFooterViewFrame = tableFooterFrame;
    tableFooterFrame.origin.y += 20;
    tableFooter.frame = tableFooterFrame;
    tableFooterViewFrame.size.height += 20;
    tableFooterViewFrame.origin.x += self.tableView.separatorInset.left;
    tableFooterView.frame = tableFooterViewFrame;
    self.tableView.tableFooterView = tableFooterView;
    
    // setup device list header view
    UITableViewHeaderFooterView *v = [[UITableViewHeaderFooterView alloc] init];
    v.textLabel.numberOfLines = 0;
    v.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.deviceHeaderView = v;
    UILabel *l = [[UILabel alloc] init];
    l.font = [UIFont systemFontOfSize:13];
    l.textColor = [UIColor colorWithRed:109.0f/255.0f green:109.0f/255.0f blue:114.0f/255.0f alpha:1.0f];
    l.text = AirTurnUILocalizedString(@"Add AirDirect AirTurn", @"The text in the heading above the list of devices that can be added").uppercaseString;
    [l setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIActivityIndicatorView *av = self.deviceHeaderSpinner = UIActivityIndicatorView.standardActivityIndicatorView;
    [av startAnimating];
    [av setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [v.contentView addSubview:l];
    [v.contentView addSubview:av];
    
    // constraints
    NSDictionary *d = @{@"l":l,@"av":av};
    if(@available(iOS 11, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [v.contentView.safeAreaLayoutGuide.leftAnchor constraintEqualToAnchor:l.leftAnchor constant:-self.tableView.separatorInset.left],
            [av.leftAnchor constraintEqualToSystemSpacingAfterAnchor:l.rightAnchor multiplier:1],
        ]];
    } else if(@available(iOS 9, *)) {
        [NSLayoutConstraint activateConstraints:@[
            [v.contentView.leftAnchor constraintEqualToAnchor:l.leftAnchor constant:-self.tableView.separatorInset.left],
            [av.leftAnchor constraintEqualToAnchor:l.rightAnchor constant:8],
        ]];
    } else {
        [NSLayoutConstraint activateConstraints:@[
            [NSLayoutConstraint constraintWithItem:l attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:self.tableView.separatorInset.left],
            [NSLayoutConstraint constraintWithItem:av attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:l attribute:NSLayoutAttributeRight multiplier:1 constant:8]
        ]];
    }
    [v.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15.5@999-[l]-6.5-|" options:0 metrics:nil views:d]];
    [v.contentView addConstraint:[NSLayoutConstraint constraintWithItem:l attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:av attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    
    if(_supportAirDirect) {
        [self generateDevicesLists];
    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    // enabled toggle setup
    _enabled = !_displayEnableToggle || [NSUserDefaults.standardUserDefaults boolForKey:EnabledUserDefaultKey] || ([AirTurnCentral initialized] && [AirTurnCentral sharedCentral].enabled) || ([AirTurnViewManager initialized] && [AirTurnViewManager sharedViewManager].enabled);
    self.enableSwitch.on = _enabled;
    [self applyEnabled];
    
    [nc addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [nc addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];
    
    // add event listener after intialising
    [self.enableSwitch addTarget:self action:@selector(enableSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    // other event listeners
    [nc addObserver:self selector:@selector(stateChanged:) name:AirTurnCentralStateChangedNotification object:nil];
    [nc addObserver:self selector:@selector(deviceDiscovered:) name:AirTurnDiscoveredNotification object:nil];
    [nc addObserver:self selector:@selector(deviceLost:) name:AirTurnLostNotification object:nil];
    [nc addObserver:self selector:@selector(connectionStateChanged:) name:AirTurnConnectionStateChangedNotification object:nil];
    [nc addObserver:self selector:@selector(didDisconnect:) name:AirTurnDidDisconnectNotification object:nil];
    [nc addObserver:self selector:@selector(deviceUpdatedName:) name:AirTurnDidUpdateNameNotification object:nil];
    [nc addObserver:self selector:@selector(deviceUpdatedBatteryLevel:) name:AirTurnDidUpdateBatteryLevelNotification object:nil];
    [nc addObserver:self selector:@selector(deviceUpdatedChargingState:) name:AirTurnDidUpdateChargingStateNotification object:nil];
    [nc addObserver:self selector:@selector(deviceUpdatedMode:) name:AirTurnDidUpdateCurrentModeNotification object:nil];
    [nc addObserver:self selector:@selector(failedToConnect:) name:AirTurnDidFailToConnectNotification object:nil];
    [nc addObserver:self selector:@selector(airTurnAdded:) name:AirTurnAddedNotification object:nil];
    [nc addObserver:self selector:@selector(airTurnRemoved:) name:AirTurnRemovedNotification object:nil];
    [nc addObserver:self selector:@selector(pedalPressed:) name:AirTurnPedalPressNotification object:nil];
    
    // set AirDirect mode after registering for notifications so we get alerted of any changes immediately
    if(hasFirstKeyWindow) {
        [self applicationDidFinishLaunching:nil];
    } else {
        [nc addObserver:self selector:@selector(applicationDidFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentSize"]) {
        // dispatch async otherwise can cause issues when inserting and removing rows
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setPreferredContentSize:self.contentSize];
        });
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)viewWillAppear:(BOOL)animated {
    _viewVisible = YES;
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    if(_supportAirDirect && [AirTurnCentral initialized]) {
        AirTurnCentralState state = [AirTurnCentral sharedCentral].state;
        if(state == AirTurnCentralStateConnected || state == AirTurnCentralStateDisconnected) {
            self.scanning = YES;
        }
    }
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    _viewVisible = NO;
    if(_supportAirDirect && [AirTurnCentral initialized]) {
        self.scanning = NO;
    }
    [self.pedalFadeDelayTimers.allValues makeObjectsPerformSelector:@selector(invalidate)];
    [self.pedalFadeDelayTimers removeAllObjects];
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    UIView *footer = self.tableView.tableFooterView;
    CGRect footerFrame = footer.frame;
    footerFrame.origin.x = self.tableView.separatorInset.left;
    footer.frame = footerFrame;
    [self setPreferredContentSize:self.contentSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Properties

- (CGSize)contentSize {
    CGSize size = self.tableView.contentSize;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if(@available(iOS 11, *)) {
        insets = self.tableView.safeAreaInsets;
    }
    size.width = size.width - insets.left - insets.right;
    size.width = MIN(MAX(320, size.width), 450);
    return size;
}

- (void)generateOtherDevices {
    if(AirTurnCentral.sharedCentral.scanning) {
        NSMutableSet *otherDevices = AirTurnCentral.sharedCentral.discoveredAirTurns.mutableCopy;
        [otherDevices minusSet:AirTurnCentral.sharedCentral.storedAirTurns];
        [otherDevices minusSet:AirTurnCentral.sharedCentral.connectedAirTurns];
        [otherDevices minusSet:AirTurnCentral.sharedCentral.connectingAirTurns];
        self.otherDevices = otherDevices.allObjects.mutableCopy;
    } else {
        [self.otherDevices removeAllObjects];
    }
}

- (void)generateDevicesLists {
    [self generateOtherDevices];
    NSMutableSet *added = [NSMutableSet setWithCapacity:AirTurnCentral.sharedCentral.storedAirTurns.count + AirTurnCentral.sharedCentral.connectedAirTurns.count];
    [added addObjectsFromArray:AirTurnCentral.sharedCentral.storedAirTurns.allObjects];
    [added addObjectsFromArray:AirTurnCentral.sharedCentral.connectedAirTurns.allObjects];
    [added addObjectsFromArray:AirTurnCentral.sharedCentral.connectingAirTurns.allObjects];
    self.addedDevices = added.allObjects.mutableCopy;
}

- (BOOL)AirDirectAvailable {
    return _supportAirDirect && AirTurnCentral.sharedCentral.state != AirTurnCentralStateUnsupported && AirTurnCentral.sharedCentral.state != AirTurnCentralStateUnauthorized;
}

- (void)setScanning:(BOOL)scanning {
    if(!self.AirDirectAvailable) return;
    [AirTurnCentral sharedCentral].scanning = scanning;
    [self generateOtherDevices];
    NSInteger devicesSection = [self realSectionForCodeSection:UISectionOtherDevices];
    if(self.tableView.numberOfSections > devicesSection && self.viewVisible) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:devicesSection] withRowAnimation:UITableViewRowAnimationNone];
        scanning && self.otherDevices.count > 0 ? [self.deviceHeaderSpinner startAnimating] : [self.deviceHeaderSpinner stopAnimating];
    }
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    if(self.enableSwitch.on != _enabled) {
        self.enableSwitch.on = enabled;
    }
    [[NSUserDefaults standardUserDefaults] setBool:_enabled forKey:EnabledUserDefaultKey];
    [self applyEnabled];
}

- (void)updateKeyboardEnabled {
    BOOL KeyboardEnabled = _enabled && _supportKeyboard && _keyboardAdded;
    if(KeyboardEnabled || [AirTurnViewManager initialized]) {
        [AirTurnViewManager sharedViewManager].enabled = KeyboardEnabled;
        [AirTurnKeyboardManager sharedManager].automaticKeyboardManagementEnabled = KeyboardEnabled && AirTurnUIDeviceTableViewController.isKeyboardManagementEnabled;
    }
}

- (void)applyEnabled {
    [self animateTableChanges];
    [self updateKeyboardEnabled];
    BOOL AirDirectEnabled = _enabled && _supportAirDirect;
    if(AirDirectEnabled || [AirTurnCentral initialized]) {
        AirTurnCentral.sharedCentral.enabled = AirDirectEnabled;
    }
#if TARGET_OS_SIMULATOR
    [self addMockPeripheral];
#endif
}

#if TARGET_OS_SIMULATOR
- (void)addMockPeripheral {
    if(_enabled && _supportAirDirect && [AirTurnCentral sharedCentral].discoveredAirTurns.count == 0) {
        [[AirTurnCentral sharedCentral] discoverMockPeripheralModel:AirTurnDeviceTypePED];
        [[AirTurnCentral sharedCentral] discoverMockPeripheralModel:AirTurnDeviceTypePEDpro];
        [[AirTurnCentral sharedCentral] discoverMockPeripheralModel:AirTurnDeviceTypeVirtualAirTurn];
        [[AirTurnCentral sharedCentral] discoverMockPeripheralModel:AirTurnDeviceTypeDIGIT3];
        [[AirTurnCentral sharedCentral] discoverMockPeripheralModel:AirTurnDeviceTypeBT200];
        [[AirTurnCentral sharedCentral] discoverMockPeripheralModel:AirTurnDeviceTypeBT200S_2];
        [[AirTurnCentral sharedCentral] discoverMockPeripheralModel:AirTurnDeviceTypeBT200S_4];
        [[AirTurnCentral sharedCentral] discoverMockPeripheralModel:AirTurnDeviceTypeBT200S_6];
        [[AirTurnCentral sharedCentral] discoverMockPeripheralModel:AirTurnDeviceTypeQUAD200];
    }
}
#endif

- (void)setDisplayEnableToggle:(BOOL)displayEnableToggle {
    if(_displayEnableToggle == displayEnableToggle) return;
    _displayEnableToggle = displayEnableToggle;
    [self animateTableChanges];
}

- (void)animateTableChanges {
    if(!self.viewVisible) return;
    NSInteger diff = [self numberOfSectionsInTableView:self.tableView] - self.tableView.numberOfSections;
    if(diff < 0) {
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.tableView.numberOfSections + diff, -diff)] withRowAnimation:UITableViewRowAnimationFade];
    } else if(diff > 0) {
        [self.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.tableView.numberOfSections, diff)] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        [self.tableView reloadData];
    }
}

- (BOOL)isPoweredOn {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    if(!_supportAirDirect) return YES;
    return AirTurnCentral.sharedCentral.state != AirTurnCentralStatePoweredOff;
#endif
}


- (void)presentAlert:(UIAlertController *)alertController presentGlobally:(BOOL)presentGlobally animated:(BOOL)animated {
    if(!alertController) { return; }
    if(self.viewLoaded && self.view.window) {
        if([self.presentedViewController isKindOfClass:[UIAlertController class]]) {
            [self.presentedViewController dismissViewControllerAnimated:NO completion:^{
                [self presentAlert:alertController presentGlobally:presentGlobally animated:NO];
            }];
            return;
        }
        [self presentViewController:alertController animated:animated completion:nil];
    } else if(presentGlobally) {
        // display alert in a new window
        UIWindow *alertWindow = [UIWindow new];
        alertWindow.windowLevel = UIWindowLevelAlert;
        alertWindow.backgroundColor = nil;
        alertWindow.opaque = NO;
        UIViewController *rvc = [[UIViewController alloc] init];
        rvc.view.backgroundColor = nil;
        rvc.view.opaque = NO;
        alertWindow.rootViewController = rvc;
        alertWindow.frame = [UIScreen mainScreen].bounds;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:animated completion:nil];
    }
}

- (void)presentAlert:(UIAlertController *)alertController presentGlobally:(BOOL)presentGlobally animated:(BOOL)animated fromPeripheral:(AirTurnPeripheral *)peripheral {
    alertController.message = [NSString stringWithFormat:@"%@: %@", peripheral.name, alertController.message];
    [self presentAlert:alertController presentGlobally:presentGlobally animated:animated];
}

- (AirTurnErrorHandlingResult)handleError:(nullable NSError *)error context:(AirTurnErrorContext)context peripheral:(AirTurnPeripheral *)peripheral {
    if(!error) {
        return AirTurnErrorHandlingResultNoError;
    }
    UIAlertController *ac = nil;
    AirTurnErrorHandlingResult result = [AirTurnUITableViewController handleError:error context:context peripheral:peripheral alertController:&ac dismissHandler:nil];
    if(ac) {
        [self presentViewController:ac animated:YES completion:nil];
    }
    return result;
}

- (AirTurnErrorHandlingResult)handleError:(nullable NSError *)error peripheral:(AirTurnPeripheral *)peripheral {
    return [self handleError:error context:AirTurnErrorContextNone peripheral:peripheral];
}

- (NSArray<AirTurnPeripheral *> *)peripherals {
    return self.otherDevices;
}

+ (NSDictionary<AirTurnAppAction,NSString *> *)digitalAppActions {
    return AirTurnUIAppActionMappingTableViewController.digitalAppActions;
}

+ (void)setDigitalAppActions:(NSDictionary<AirTurnAppAction,NSString *> *)appActions {
    AirTurnUIAppActionMappingTableViewController.digitalAppActions = appActions;
}

+ (NSDictionary<NSNumber *,AirTurnAppAction> *)digitalAppActionDefaultMapping {
    return AirTurnManager.sharedManager.digitalAppActionDefaultMapping;
}

+ (void)setDigitalAppActionDefaultMapping:(NSDictionary<NSNumber *,AirTurnAppAction> *)digitalAppActionDefaultMapping {
    AirTurnManager.sharedManager.digitalAppActionDefaultMapping = digitalAppActionDefaultMapping;
}

+ (NSDictionary<AirTurnAppAction,NSString *> *)analogAppActions {
    return AirTurnUIAppActionMappingTableViewController.analogAppActions;
}

+ (void)setAnalogAppActions:(NSDictionary<AirTurnAppAction,NSString *> *)appActions {
    AirTurnUIAppActionMappingTableViewController.analogAppActions = appActions;
}

#pragma mark - Notifications

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    // ensure user defaults always persist
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillTerminate:(NSNotification *)notification {
    // ensure user defaults always persist
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)shouldPerformAirDirectTableChange {
    return self.viewVisible && self.isPoweredOn && _supportAirDirect && _enabled;
}

+ (void)goToSettings {
    if(@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:(NSURL * _Nonnull)[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_10_0
        [[UIApplication sharedApplication] openURL:(NSURL * _Nonnull)[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
#endif
    }
}

- (void)stateChanged:(NSNotification *)n {
    AirTurnCentralState state = [AirTurnCentral sharedCentral].state;
    if(self.previousCentralState < AirTurnCentralStateDisconnected && state >= AirTurnCentralStateDisconnected) {
        for(AirTurnPeripheral *p in [AirTurnCentral sharedCentral].discoveredAirTurns) {
            if(![self.otherDevices containsObject:p]) {
                [self.otherDevices addObject:p];
            }
        }
    } else if(self.previousCentralState >= AirTurnCentralStateDisconnected && state < AirTurnCentralStateDisconnected) {
        [self.otherDevices removeAllObjects];
    }
    
    // check if enable cell not displayed and we are powered on
    if(state != AirTurnCentralStatePoweredOff && !self.enableCell.window) {
        [self.tableView reloadData];
    }
    switch(state) {
        case AirTurnCentralStateDisconnected:
        case AirTurnCentralStateConnected:
            if(_supportAirDirect && _enabled && self.viewVisible) {
                // view is visible, airturn is enabled, btle is supported, so start scanning if not already
                self.scanning = YES;
            }
            [self.tableView reloadData];
            break;
        case AirTurnCentralStatePoweredOff:
            [self.tableView reloadData];
            break;
        case AirTurnCentralStateDisabled:
            [self animateTableChanges];
            break;
        case AirTurnCentralStateResetting:
        case AirTurnCentralStateUnknown:
            // do nothing
            break;
        case AirTurnCentralStateUnauthorized:
            [self animateTableChanges];
            break;
        case AirTurnCentralStateUnsupported:
#if TARGET_OS_SIMULATOR
            [self addMockPeripheral];
#else
            [self animateTableChanges];
#endif
            break;
    }
}

- (void)_deviceDiscovered:(AirTurnPeripheral *)p {
    NSInteger section = [self realSectionForCodeSection:UISectionOtherDevices];
    NSInteger index = [self.otherDevices indexOfObject:p];
    if(index != NSNotFound) { // already discovered, just reload table cell in case bonding state has changed
        if(self.tableView.numberOfSections > section) {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
        }
        return;
    }
    [self.otherDevices addObject:p];
    index = self.otherDevices.count-1;
    
    if(!self.shouldPerformAirDirectTableChange) return;
    
    [self.deviceHeaderSpinner startAnimating];
    
    if(self.tableView.window != nil && self.tableView.numberOfSections > section) {
        // if only 1 device, just reload searching row
        if(self.otherDevices.count <= 1) {
            if([self shouldPerformPeripheralCountAdjustment:0 section:section]) {
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
            }
        } else {
            if([self shouldPerformPeripheralCountAdjustment:1 section:section]) {
                [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:section]] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    }
}

- (void)deviceDiscovered:(NSNotification *)n {
    AirTurnPeripheral *p = n.userInfo[AirTurnPeripheralKey];
    [self _deviceDiscovered:p];
}

- (void)deviceChangeNotification:(NSNotification *)n {
    if(!self.shouldPerformAirDirectTableChange) return;
    AirTurnPeripheral *p = n.object;
    [self reloadRowForPeripheral:p];
}

- (void)deviceUpdatedName:(NSNotification *)n {
    [self deviceChangeNotification:n];
}

- (void)deviceUpdatedBatteryLevel:(NSNotification *)n {
    [self deviceChangeNotification:n];
}

- (void)deviceUpdatedChargingState:(NSNotification *)n {
    [self deviceChangeNotification:n];
}

- (void)deviceUpdatedMode:(NSNotification *)n {
    [self deviceChangeNotification:n];
}

- (void)_deviceLost:(AirTurnPeripheral *)p {
    NSInteger index = [self.otherDevices indexOfObject:p];
    if(index == NSNotFound) return;
    [self.otherDevices removeObject:p];
    if(!self.shouldPerformAirDirectTableChange) return;
    NSInteger section = [self realSectionForCodeSection:UISectionOtherDevices];
    if(self.tableView.window != nil && self.tableView.numberOfSections > section) {
        if(self.otherDevices.count == 0) {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
            [self.deviceHeaderSpinner stopAnimating];
        } else {
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:section]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (void)deviceLost:(NSNotification *)n {
    AirTurnPeripheral *p = n.userInfo[AirTurnPeripheralKey];
    [self _deviceLost:p];
}

- (void)connectionCompleteForPeripheral:(AirTurnPeripheral *)peripheral {
    
}

- (void)connectionStateChanged:(NSNotification *)n {
    if(!_supportAirDirect || !_enabled) {
        return;
    }
    AirTurnPeripheral *p = n.userInfo[AirTurnPeripheralKey];
    if(p == nil) {
        if(self.keyboardAdded && ![n.userInfo[AirTurnConnectionModeAirDirectKey] boolValue]) { // keyboard
            if(self.viewVisible) {
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:[self realSectionForCodeSection:UISectionAddedDevices]]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
        return;
    }
    switch(p.state) {
        case AirTurnConnectionStateReady: {
            if(self.checkForFirmwareUpdates && p.deviceType != AirTurnDeviceTypeVirtualAirTurn) {
                
                NSString * lastCheckedKey = [NSString stringWithFormat:@"%@.%@", LastFirmwareUpdateVersionUserDefaultKey, p.identifier];
                NSString * lastChecked = [[NSUserDefaults standardUserDefaults] stringForKey:lastCheckedKey];
                [p checkForFirmwareUpdate:^(EDSemver * newVersion) {
                    if(newVersion == nil || (lastChecked != nil && [[EDSemver semverWithString:lastChecked] isEqual:newVersion])) {
                        return;
                    }
                    // update available
                    [[NSUserDefaults standardUserDefaults] setObject:newVersion.description forKey:lastCheckedKey];
                    UIAlertController *ac = [UIAlertController alertControllerWithTitle:AirTurnUILocalizedString(@"Update available", @"Update available alert title") message:[NSString stringWithFormat:AirTurnUILocalizedString(@"A device update is available for the connected AirTurn \"%@\". You can update your AirTurn to get the latest features and fixes in the AirTurn App", @"Update available message"), p.name] preferredStyle:UIAlertControllerStyleAlert];
                    [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"Not now", @"Update available not now dismiss button") style:UIAlertActionStyleCancel handler:nil]];
                    UIAlertAction *goToAppAction = [UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"Go to App", @"Update available go to App dismiss button") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if(@available(iOS 10.0, *)) {
                            [[UIApplication sharedApplication] openURL:(NSURL * _Nonnull)[NSURL URLWithString:AppLinkURL] options:@{} completionHandler:nil];
                        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_10_0
                            [[UIApplication sharedApplication] openURL:(NSURL * _Nonnull)[NSURL URLWithString:AppLinkURL]];
#endif
                        }
                    }];
                    [ac addAction:goToAppAction];
                    if (@available(iOS 9.0, *)) {
                        [ac setPreferredAction:goToAppAction];
                    }
                    
                    [self presentAlert:ac presentGlobally:YES animated:YES];
                    
                }];
            }
            [self connectionCompleteForPeripheral:p];
            if(![self.addedDevices containsObject:p]) {
                [self.otherDevices removeObject:p];
                [self.addedDevices addObject:p];
                [self.tableView reloadData];
                return;
            }
        } break;
        default: break;
    }
    [self reloadRowForPeripheral:p];
}

+ (AirTurnErrorHandlingResult)handleError:(nullable NSError *)error context:(AirTurnErrorContext)context peripheral:(nullable AirTurnPeripheral *)peripheral alertController:(UIAlertController * _Nullable * _Nullable)alertController dismissHandler:(void (^ __nullable)(UIAlertAction *action))dismissHandler {
    if(!error) {
        return AirTurnErrorHandlingResultNoError;
    }
    AirTurnErrorHandlingResult result = AirTurnErrorHandlingResultNotHandled;
    UIAlertController *ac = nil;
    NSString *errorTitle = nil;
    NSString *errorMessage = nil;
    NSError *underlyingError = error.userInfo[NSUnderlyingErrorKey];
    NSString *errorContext = nil;
    BOOL tryAgain = YES;
    BOOL contactSupport = YES;
    BOOL toggleBluetooth = NO;
    BOOL removePairing = NO;
    BOOL addActions = YES;
    switch (context) {
        case AirTurnErrorContextNone:
            break;
        case AirTurnErrorContextConnecting:
            errorContext = AirTurnUILocalizedString(@"connecting", @"Connecting context");
            break;
    }
    if([error.domain isEqualToString:AirTurnCentralErrorDomain]) {
        switch ((AirTurnCentralError)error.code) {
            case AirTurnCentralErrorUnhandled:
                errorMessage = AirTurnUILocalizedString(@"Unhandled error", @"Unhandled central error message");
                break;
            case AirTurnCentralErrorUnexpectedUnresolvable:
                errorMessage = AirTurnUILocalizedString(@"Unexpected error which can't be resolved", @"Unexpected unresolvable central error message");
                break;
            case AirTurnCentralErrorConnectingTimedOut:
                errorMessage = AirTurnUILocalizedString(@"Timed out", @"Connecting timed out peripheral error message");
                break;
            case AirTurnCentralErrorConnectionTimedOut:
                errorMessage = AirTurnUILocalizedString(@"Connection timed out", @"connection timed out central error message");
                break;
            case AirTurnCentralErrorNotConnected:
                errorMessage = AirTurnUILocalizedString(@"The device is not connected", @"Not connected central error message");
                tryAgain = NO;
                break;
            case AirTurnCentralErrorNotReady:
                errorMessage = AirTurnUILocalizedString(@"The device is not ready", @"Not ready central error message");
                tryAgain = NO;
                break;
            case AirTurnCentralErrorPeripheralDisconnected:
                errorMessage = AirTurnUILocalizedString(@"The device disconnected while performing the action", @"Disconnected central error message");
                break;
            case AirTurnCentralErrorPeripheralNotPaired:
                errorMessage = AirTurnUILocalizedString(@"The device failed to pair. Try again, or forget the device in iOS Settings > Bluetooth", @"Not paired central error message");
                tryAgain = NO;
                break;
        }
    }
    else if([error.domain isEqualToString:AirTurnPeripheralErrorDomain]) {
        switch ((AirTurnPeripheralError)error.code) {
            case AirTurnPeripheralErrorUnhandled:
                errorMessage = AirTurnUILocalizedString(@"Unhandled error", @"Unhandled peripheral error message");
                break;
            case AirTurnPeripheralErrorUnexpectedUnresolvable:
                errorMessage = AirTurnUILocalizedString(@"Unexpected error which can't be resolved", @"Unexpected unresolvable peripheral error message");
                break;
                
            case AirTurnPeripheralErrorConnectionTimedOut:
                errorMessage = AirTurnUILocalizedString(@"Connection timed out", @"Connection timed out peripheral error message");
                break;
            case AirTurnPeripheralErrorNotConnected:
                errorMessage = AirTurnUILocalizedString(@"The device is not connected", @"Not connected peripheral error message");
                tryAgain = NO;
                break;
            case AirTurnPeripheralErrorNotReady:
                errorMessage = AirTurnUILocalizedString(@"The device is not ready", @"Not ready central error message");
                tryAgain = NO;
                break;
            case AirTurnPeripheralErrorPeripheralDisconnected:
                errorMessage = AirTurnUILocalizedString(@"The device disconnected while performing the action", @"Disconnected peripheral error message");
                break;
            case AirTurnPeripheralErrorPeripheralNotPaired:
                errorMessage = AirTurnUILocalizedString(@"The device failed to pair. Try again, or forget the device in iOS Settings > Bluetooth", @"Not paired peripheral error message");
                tryAgain = NO;
                break;
            case AirTurnPeripheralErrorOperationCancelled:
                errorMessage = AirTurnUILocalizedString(@"The operation was cancelled", @"Operation cancelled peripheral error message");
                break;
            case AirTurnPeripheralErrorAttributeWriteTooLarge:
                errorMessage = AirTurnUILocalizedString(@"Internal error: attribute write too large", @"Write too large peripheral error message");
                break;
            case AirTurnPeripheralErrorAttributeWriteFailedTryLater:
                errorMessage = AirTurnUILocalizedString(@"Internal error: write failed", @"Attribute write failed peripheral error message");
                break;
            case AirTurnPeripheralErrorMissingServices:
                errorMessage = AirTurnUILocalizedString(@"Missing services", @"Missing services peripheral error message");
                break;
            case AirTurnPeripheralErrorATTErrorDiscoveringServices:
                errorMessage = AirTurnUILocalizedString(@"Error discovering the device services", @"Service discovery peripheral error message");
                break;
            case AirTurnPeripheralErrorMissingCharacteristics:
                errorMessage = AirTurnUILocalizedString(@"Missing characteristics", @"Missing characteristics peripheral error message");
                break;
            case AirTurnPeripheralErrorATTErrorDiscoveringCharacteristics:
                errorMessage = AirTurnUILocalizedString(@"Error discovering the device characteristics", @"Characteristic discovery peripheral error message");
                break;
            case AirTurnPeripheralErrorInvalidData:
                errorMessage = AirTurnUILocalizedString(@"Invalid data", @"Invalid data peripheral error message");
                if(context == AirTurnErrorContextConnecting) {
                    tryAgain = NO;
                    toggleBluetooth = YES;
                }
                break;
            case AirTurnPeripheralErrorIncompatibleModel:
                errorTitle = AirTurnUILocalizedString(@"Model not supported!", @"Model not supported error title");
                errorMessage = AirTurnUILocalizedString(@"The model of device connected is not supported by this App. Try updating the App and reconnecting", @"Model not supported error message");
                tryAgain = NO;
                contactSupport = NO;
                result = AirTurnErrorHandlingResultModelNotSupported;
                break;
            case AirTurnPeripheralErrorDiscoveryTimedOut:
                errorMessage = AirTurnUILocalizedString(@"Discovery timed out", @"Discovery timed out peripheral error message");
                tryAgain = NO;
                toggleBluetooth = YES;
                break;
            case AirTurnPeripheralErrorUnsupportedFeature:
                errorMessage = AirTurnUILocalizedString(@"This action is unsupported on this device", @"Unsupported feature peripheral error message");
                tryAgain = NO;
                break;
            case AirTurnPeripheralErrorInvalidState:
                errorMessage = AirTurnUILocalizedString(@"The AirTurn is in an invalid state to perform this action", @"Invalid state peripheral error message");
                break;
        }
    }
    if(result == AirTurnErrorHandlingResultNotHandled) {
        if(errorMessage) {
            result = AirTurnErrorHandlingResultAlert;
        } else {
            errorTitle = AirTurnUILocalizedString(@"Unknown error!", @"Unknown error title");
            errorMessage = [NSString stringWithFormat:AirTurnUILocalizedString(@"An unknown error occurred. If this keeps happening, try updating the App or contact support. (%@)", @"Unknown error message"), error.description];
            tryAgain = NO;
            contactSupport = NO;
        }
    }
    if(errorMessage && alertController) {
        if(errorTitle == nil) {
            errorTitle = AirTurnUILocalizedString(@"Error!", @"Default error title");
        }
        if(errorContext) {
            errorMessage = [errorMessage stringByAppendingFormat:AirTurnUILocalizedString(@" when %@", @"Error message context format"), errorContext];
        }
        if(tryAgain) {
            errorMessage = [errorMessage stringByAppendingString:AirTurnUILocalizedString(@". Try again", @"Try again error message suffix")];
        } else if(toggleBluetooth) {
            errorMessage = [errorMessage stringByAppendingString:AirTurnUILocalizedString(@". Try toggling Bluetooth off and on, either from control centre (swipe up from the bottom of your screen) or iOS settings", @"Toggle bluetooth suggestion message")];
        }
        if(contactSupport) {
            errorMessage = [errorMessage stringByAppendingString:AirTurnUILocalizedString(@". If the problem continues to occur, contact AirTurn support", @"Contact support error message suffix")];
        }
        if(underlyingError) {
            errorMessage = [errorMessage stringByAppendingFormat:AirTurnUILocalizedString(@" (Underlying error: %@)", @"Underlying error message suffix"), underlyingError];
        }
        ac = [UIAlertController alertControllerWithTitle:errorTitle message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
        if(addActions) {
            [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"Dismiss", @"Error dismiss button") style:UIAlertActionStyleCancel handler:dismissHandler]];
            if(removePairing) {
                UIAlertAction *a = [UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"iOS Settings", @"iOS settings alert button") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self goToSettings];
                    if(dismissHandler) {
                        dismissHandler(action);
                    }
                }];
                [ac addAction:a];
                if (@available(iOS 9.0, *)) {
                    ac.preferredAction = a;
                }
            }
        }
        *alertController = ac;
    }
    return result;
}

- (void)presentConnectionProblemAlertForPeripheral:(AirTurnPeripheral *)peripheral {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:AirTurnUILocalizedString(@"Problem connecting", @"Problem connecting error title") message:[NSString stringWithFormat:AirTurnUILocalizedString(@"There was a problem connecting to %1$@. This usually happens if you reset your AirTurn to delete the pairing without resetting the pairing in iOS, or have just updated the firmware. To delete the pairing, go in to iOS settings > Bluetooth > %1$@ (tap (i)) > Forget This Device, toggle Bluetooth off and on, then try connecting again in this App by tapping the alert icon next to the AirTurn and then 'Reconnect'", @"Problem connecting error message"), peripheral.name] preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"Dismiss", @"Dismiss button title") style:UIAlertActionStyleCancel handler:nil]];
    [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"iOS Settings", @"iOS settings alert button") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:(NSURL * _Nonnull)[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_10_0
            [[UIApplication sharedApplication] openURL:(NSURL * _Nonnull)[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
#endif
        }
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"Reconnect", @"Button to initiate reconnection") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[AirTurnCentral sharedCentral] connectToAirTurn:peripheral];
        
    }]];
    [self presentAlert:ac presentGlobally:NO animated:YES];
}

- (void)didDisconnect:(NSNotification *)n {
    AirTurnPeripheral *p = n.userInfo[AirTurnPeripheralKey];
    if(p != nil) {
        if(p.lastConnectionFailed) {
            [self presentConnectionProblemAlertForPeripheral:p];
            // peripheral state change notification may occur before lastConnectionFailed is set, so reload row
            [self reloadRowForPeripheral:p];
        }
    }
}

- (void)movePeripheral:(AirTurnPeripheral *)p toAdded:(BOOL)toAdded {
    NSMutableArray *source = toAdded ? _otherDevices : _addedDevices;
    NSMutableArray *dest = toAdded ? _addedDevices : _otherDevices;
    if(self.viewVisible) {
        [self.tableView beginUpdates];
    }
    NSInteger sourceSection = [self realSectionForCodeSection:toAdded ? UISectionOtherDevices : UISectionAddedDevices];
    NSInteger destSection = [self realSectionForCodeSection:toAdded ? UISectionAddedDevices : UISectionOtherDevices];
    [source removeObject:p];
    [dest addObject:p];
    if(self.viewVisible) {
        if(dest.count == 1 && (!toAdded || !self.keyboardAdded)) {
            // remove placeholder row from dest
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:destSection]] withRowAnimation:UITableViewRowAnimationNone];
        }
        NSInteger sourceRow = (!toAdded && self.keyboardAdded ? 1 : 0) + source.count;
        NSInteger destRow = (toAdded && self.keyboardAdded ? 1 : 0) + dest.count - 1;
        // move row
        [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:sourceRow inSection:sourceSection] toIndexPath:[NSIndexPath indexPathForRow:destRow inSection:destSection]];
        if(source.count == 0 && (toAdded || !self.keyboardAdded)) {
            // add placeholder row
            [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:sourceSection]] withRowAnimation:UITableViewRowAnimationNone];
        }
        [self.tableView endUpdates];
    }
}

- (void)failedToConnect:(NSNotification *)n {
    if(!self.shouldPerformAirDirectTableChange) return;
    NSError *error = n.userInfo[AirTurnErrorKey];
    AirTurnPeripheral *p = n.userInfo[AirTurnPeripheralKey];
    
    if(AirTurnCentral.sharedCentral.storedAirTurns.count == 0) {
        [NSUserDefaults.standardUserDefaults setBool:NO forKey:AirDirectAirTurnsEnabled];
    }
    
    if(![AirTurnCentral.sharedCentral.storedAirTurns containsObject:p] && [self.addedDevices containsObject:p]) {
        [self movePeripheral:p toAdded:NO];
        return;
    }
    
    [self reloadRowForPeripheral:p];
    
    if(p.lastConnectionFailed) {
        [self presentConnectionProblemAlertForPeripheral:p];
    } else {
        [self handleError:error context:AirTurnErrorContextConnecting peripheral:p];
    }
}

- (void)connectionTimeout:(NSTimer *)timer {
    AirTurnPeripheral *p = timer.userInfo;
    [[AirTurnCentral sharedCentral] cancelAirTurnConnection:p];
    if(!self.shouldPerformAirDirectTableChange) {
        return;
    }
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:AirTurnUILocalizedString(@"AirTurn", @"Product name") message:AirTurnUILocalizedString(@"Connection to the AirTurn timed out.  Please check the device is on and in range.  Otherwise please try forgetting the device from iOS Bluetooth settings", @"Connection timed out message") preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"Dismiss", @"Dismiss button title") style:UIAlertActionStyleCancel handler:nil]];
    [self presentAlert:ac presentGlobally:NO animated:YES];
    [self reloadRowForPeripheral:p];
}

- (void)airTurnAdded:(NSNotification *)notification {
    
}

- (void)airTurnRemoved:(NSNotification *)notification {
    
}

- (void)pedalPressed:(NSNotification *)notification {
    NSInteger row = 0;
    if([notification.userInfo[AirTurnConnectionModeAirDirectKey] boolValue]) {
        row = [self.addedDevices indexOfObject:notification.userInfo[AirTurnPeripheralKey]];
        if(self.keyboardAdded) {
            row++;
        }
    } else {
        row = 0;
    }
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:[self realSectionForCodeSection:UISectionAddedDevices]];
    [self.tableView selectRowAtIndexPath:indexpath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.pedalFadeDelayTimers[@(row)] invalidate];
    self.pedalFadeDelayTimers[@(row)] = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(portFadeEvent:) userInfo:nil repeats:NO];
}

- (void)portFadeEvent:(NSTimer *)timer {
    NSNumber *key = [self.pedalFadeDelayTimers allKeysForObject:timer].firstObject;
    if(key == nil) { return; }
    [timer invalidate];
    [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:key.integerValue inSection:[self realSectionForCodeSection:UISectionAddedDevices]] animated:YES];
    [self.pedalFadeDelayTimers removeObjectForKey:key];
}

#pragma mark - Table view data source

/**
 Gets the actual section number from the 'code' section number provided
 
 @param section the section number to translate
 
 @return the real section number to reload etc.
 */
- (NSInteger)realSectionForCodeSection:(UISection)section {
    return section + section - [self codeSectionForRealSection:section];
}

/**
 Gets the 'code' section number, i.e. the section number used in switches and logic, from the actual section number requested
 
 @param section section number requested
 
 @return 'code' section number
 */
- (UISection)codeSectionForRealSection:(NSInteger)section { // increment section by 1 if these specific conditions
    if(self.isPoweredOn) {
        if(!_displayEnableToggle) { // advance past enable toggle
            section++;
        }
        if(!_supportAirDirect && section >= UISectionOtherDevices) {
            section++;
        }
    }
    return (UISection)section;
}

// Attempts to work around crashes caused by mismatching number of sections/rows
- (BOOL)shouldPerformPeripheralCountAdjustment:(NSInteger)difference section:(NSInteger)section {
    if(!self.viewVisible || !_enabled) {
        return NO;
    }
    NSInteger tableSectionsDifference = [self numberOfSectionsInTableView:self.tableView] - [self.tableView numberOfSections];
    if(tableSectionsDifference != 0) {
        [self.tableView reloadData];
        return NO;
    }
    if(self.tableView.numberOfSections <= section) {
        [self.tableView reloadData];
        return NO;
    }
    NSInteger peripheralRowsDifference = [self tableView:self.tableView numberOfRowsInSection:section] - [self.tableView numberOfRowsInSection:section];
    if(peripheralRowsDifference != difference) {
        [self.tableView reloadData];
        return NO;
    }
    return YES;
}

- (void)reloadRowForPeripheral:(AirTurnPeripheral *)peripheral {
    if(!self.viewVisible || !_enabled || !_supportAirDirect) {
        return;
    }
    NSInteger r = [self.otherDevices indexOfObject:peripheral];
    BOOL isAdded = r == NSNotFound;
    if(isAdded) {
        r = [self.addedDevices indexOfObject:peripheral];
        if(r == NSNotFound) {
            return;
        }
    }
    NSInteger section = [self realSectionForCodeSection:isAdded ? UISectionAddedDevices : UISectionOtherDevices];
    if(![self shouldPerformPeripheralCountAdjustment:0 section:section]) return;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:isAdded && self.keyboardAdded ? r + 1 : r inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if((!_supportKeyboard && !_supportAirDirect) || !self.isPoweredOn) {
        // unsupported or powered off cell
        return 1;
    }
    // Return the number of sections.
    NSInteger sections = 0;
    if(_displayEnableToggle) {
        sections++;
    }
    if(_enabled) {
        sections++; // added
        if(_supportAirDirect) {
            sections++; // airdirect
        }
        if(_supportKeyboard && !self.keyboardAdded) {
            sections++; // add keyboard
        }
    }
    if(sections == 0) {
        sections = 1; // show the unavailable row
    }
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch ([self codeSectionForRealSection:section]) {
        case UISectionEnable: // enable cell or not available
            return 1;
        case UISectionAddedDevices: // added devices list
            return self.addedDevices.count ? self.addedDevices.count + (self.keyboardAdded ? 1 : 0) : 1;
        case UISectionOtherDevices: // other devices list
            return self.AirDirectAvailable && self.otherDevices.count ? self.otherDevices.count : 1;
        case UISectionAddKeyboard:
            return 1;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case UISectionAddedDevices:
            return AirTurnUILocalizedString(@"Added to App", @"Heading for AirTurns connected to the App");
        default:
            break;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch ([self codeSectionForRealSection:section]) {
        case UISectionOtherDevices:
            if(_enabled && _supportAirDirect) {
                self.scanning && self.otherDevices.count > 0 ? [self.deviceHeaderSpinner startAnimating] : [self.deviceHeaderSpinner stopAnimating];
                return self.deviceHeaderView;
            }
            break;
        default:
            break;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch ([self codeSectionForRealSection:section]) {
        case UISectionOtherDevices:
            if(_supportAirDirect && self.AirDirectAvailable) {
                return AirTurnUILocalizedString(@"For BT200(S), PED(pro), DIGIT3 and QUAD200 ensure the AirTurn is in mode 1 and not connected to another device, then you can select it in the list above", @"AirDirect other devices footer text");
            }
            break;
        case UISectionAddKeyboard:
            return AirTurnUILocalizedString(@"Add \"Keyboard AirTurn\" for BT-105, DIGIT, DIGIT2, QUAD and STOMP 6 support", @"Add keyboard airturn footer text");
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(@available(iOS 11, *)) {
        return UITableViewAutomaticDimension;
    }
    // hack for iOS 10.3
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)[self tableView:tableView viewForFooterInSection:section];
    if(v == nil) {
        NSString * text = [self tableView:self.tableView titleForFooterInSection:section];
        if(text == nil) { return UITableViewAutomaticDimension; }
        NSMutableParagraphStyle *style = NSMutableParagraphStyle.new;
        style.lineBreakMode = NSLineBreakByWordWrapping;
        CGRect rect = [text boundingRectWithSize:CGSizeMake(self.contentSize.width - (self.tableView.separatorInset.left * 2), 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13], NSParagraphStyleAttributeName: style} context:nil];
        return (CGFloat)(ceil(rect.size.height) + 25);
    }
    if(![v isKindOfClass:[UITableViewHeaderFooterView class]]) { return UITableViewAutomaticDimension; }
    v.textLabel.numberOfLines = 0;
    v.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [v setNeedsLayout];
    [v layoutIfNeeded];
    CGSize s = [v.textLabel sizeThatFits:CGSizeMake(self.tableView.bounds.size.width-40, 0)];
    return s.height + 19;
}

- (UITableViewCell *)unavailableCell {
    NSString * reuseID;
    switch(AirTurnCentral.sharedCentral.state) {
        case AirTurnCentralStatePoweredOff: reuseID = @"poweredOff"; break;
        case AirTurnCentralStateUnsupported: reuseID = @"unsupported"; break;
        case AirTurnCentralStateUnauthorized: reuseID = @"unauthorized"; break;
        default: return UITableViewCell.new;
    }
    // not available
    UITableViewCell *c = [self.tableView dequeueReusableCellWithIdentifier:reuseID];
    if(!c) {
        c = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        c.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        c.textLabel.numberOfLines = 0;
        
        NSString *text;
        switch(AirTurnCentral.sharedCentral.state) {
            case AirTurnCentralStatePoweredOff:
                text = AirTurnUILocalizedString(@"Bluetooth is powered off, tap here to go to iOS Settings", @"Bluetooth powered off message");
                c.selectionStyle = UITableViewCellSelectionStyleDefault;
                c.textLabel.textColor = c.textLabel.tintColor;
                break;
            case AirTurnCentralStateUnsupported:
                text = [NSString stringWithFormat:AirTurnUILocalizedString(@"%@ is not supported on this device, set your AirTurn to mode 2+ and connect in iOS settings", @"AirDirect unavailable text"), ModernConnectionModeName];
                c.selectionStyle = UITableViewCellSelectionStyleNone;
                c.textLabel.textColor = UIColor.disabledColor;
                break;
            case AirTurnCentralStateUnauthorized: {
                NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
                if(appName == nil) {
                    appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
                }
                text = [NSString stringWithFormat:AirTurnUILocalizedString(@"%@ requires permission to use Bluetooth to directly connect to AirTurns. Tap here to go to iOS settings to enable permission", @"AirDirect unauthorized text"), appName];
                c.selectionStyle = UITableViewCellSelectionStyleDefault;
                c.textLabel.textColor = c.textLabel.tintColor;
            } break;
            default: break;
        }
        c.textLabel.text = text;
    }
    return c;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [NSString stringWithFormat:AirTurnUILocalizedString(@"%1$@ is not supported in this App. You can connect %1$@ AirTurns in modes 2+", @"AirDirect unsupported text"), ModernConnectionModeName];
    
    static UIImage *disclosureImage = nil;
    if(!disclosureImage) {
        UITableViewCell *tempc = [UITableViewCell new];
        tempc.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [tempc layoutIfNeeded];
        for (UIView *v in tempc.subviews) {
            if([v isKindOfClass:[UIButton class]]) {
                for (UIView *v2 in v.subviews) {
                    if([v2 isKindOfClass:[UIImageView class]]) {
                        disclosureImage = [(UIImageView *)v2 image];
                        break;
                    }
                }
            }
            if(disclosureImage) break;
        }
        if(!disclosureImage) {
            disclosureImage = [UIImage new];
        }
    }
    switch([self codeSectionForRealSection:indexPath.section]) {
        case UISectionEnable: {// enable switch
            BOOL poweredOn = self.isPoweredOn;
            BOOL supported = _supportAirDirect || _supportKeyboard;
            if(poweredOn && supported) {
                if(_displayEnableToggle) {
                    return self.enableCell;
                } else {
                    // we would have no cells to display since no AirDirect and no force keyboard toggle
                    UITableViewCell *c = [self.tableView dequeueReusableCellWithIdentifier:@"airturnEnabled"];
                    if(!c) {
                        c = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"airturnEnabled"];
                        c.textLabel.textColor = [UIColor darkGrayColor];
                        c.selectionStyle = UITableViewCellSelectionStyleNone;
                        c.textLabel.text = AirTurnUILocalizedString(@"AirTurn support is enabled", @"AirTurn no toggle enabled message");
                    }
                    return c;
                }
            }
            
            return [self unavailableCell];
        }
        case UISectionAddedDevices: {// devices list
            UITableViewCell *c;
            if(self.addedDevices.count == 0 && !self.keyboardAdded) {
                NSString *reuse = @"addDevice";
                c = [tableView dequeueReusableCellWithIdentifier:reuse];
                if(!c) {
                    c = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
                    c.textLabel.text = AirTurnUILocalizedString(@"No AirTurns connected", @"No AirTurns connected cell text");
                    c.textLabel.textColor = UIColor.disabledColor;
                    c.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                return c;
            }
            if(indexPath.row == 0 && self.keyboardAdded) {
                NSString *reuse = @"keyboard";
                c = [tableView dequeueReusableCellWithIdentifier:reuse];
                if(!c) {
                    c = [NonTruncatedDetailTableViewCell.alloc initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
                    c.textLabel.text = AirTurnUILocalizedString(@"Keyboard AirTurn", @"Keyboard AirTurn cell text");
                    c.accessoryType = UITableViewCellAccessoryDetailButton;
                }
                if(AirTurnKeyboardManager.sharedManager.automaticKeyboardManagementEnabled) {
                    c.detailTextLabel.text = !AirTurnKeyboardStateMonitor.sharedMonitor.allowKeyboardStateReassessment || AirTurnViewManager.sharedViewManager.connected ? AirTurnUILocalizedString(@"Connected", @"Connected AirTurn label") : AirTurnUILocalizedString(@"Disconnected", @"Disconnected AirTurn label");
                } else {
                    c.detailTextLabel.text = nil;
                }
                
                return c;
            }
            AirTurnPeripheral *p = self.addedDevices[self.keyboardAdded ? indexPath.row-1 : indexPath.row];
            AirTurnConnectionState state = p.state;
            NSString *reuseID = [NSString stringWithFormat:@"storedListCell.%d", (int)state];
            c = [self.tableView dequeueReusableCellWithIdentifier:reuseID];
            if(!c) {
                c = [NonTruncatedDetailTableViewCell.alloc initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
                c.textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
                c.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
                c.accessoryType = UITableViewCellAccessoryDetailButton;
                c.selectionStyle = UITableViewCellSelectionStyleDefault;
                switch (state) {
                    case AirTurnConnectionStateUnknown:
                    case AirTurnConnectionStateDisconnected:
                    case AirTurnConnectionStateDisconnecting:
                    case AirTurnConnectionStateSystemConnected: // if system connected then we might not have requested connection
                        c.detailTextLabel.text = AirTurnUILocalizedString(@"Disconnected", @"Disconnected AirTurn label");
                        break;
                    case AirTurnConnectionStateConnecting: // if connecting then we will have requested it, so show spinner
                    case AirTurnConnectionStateDiscovering: {
                        c.accessoryView = UIActivityIndicatorView.standardActivityIndicatorView;
                        c.detailTextLabel.text = AirTurnUILocalizedString(@"Connecting", @"Connecting AirTurn label");
                    } break;
                    case AirTurnConnectionStateReady:
                        c.detailTextLabel.text = AirTurnUILocalizedString(@"Connected", @"Connected AirTurn label");
                        break;
                }
            }
            // every render configuration
            NSMutableArray<UIView *> *accessoryViews = [NSMutableArray arrayWithCapacity:3];
            switch (state) {
                case AirTurnConnectionStateReady: {
                    NSString *imageName = nil;
                    switch (p.chargingState) {
                        case AirTurnPeripheralChargingStateDisconnectedDischarging:
                            if(p.batteryLevel <= AirTurnPeripheralLowBatteryLevel) {
                                imageName = @"battery-low";
                            }
                            break;
                        case AirTurnPeripheralChargingStateConnectedFault: {
                            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                            [button addTarget:self action:@selector(chargingFaultButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                            [button setImage:[UIImage imageNamed:@"battery-fault" inBundle:AirTurnUIBundle compatibleWithTraitCollection:self.traitCollection] forState:UIControlStateNormal];
                            button.tintColor = [UIColor redColor];
                            [accessoryViews addObject:button];
                        } break;
                        case AirTurnPeripheralChargingStateConnectedValidating:
                            imageName = @"battery-validating";
                            break;
                        case AirTurnPeripheralChargingStateConnectedCharging:
                            imageName = @"battery-charging";
                            break;
                        case AirTurnPeripheralChargingStateConnectedFullyCharged:
                            imageName = @"battery-charged";
                            break;
                    }
                    if(imageName) {
                        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName inBundle:AirTurnUIBundle compatibleWithTraitCollection:nil]];
                        iv.tintColor = UIColor.standardTextColor;
                        [accessoryViews addObject:iv];
                    }
                    if(p.currentMode != AirTurnMode1) {
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                        [button addTarget:self action:@selector(nonAirDirectModeWarningTapped:) forControlEvents:UIControlEventTouchUpInside];
                        [button setImage:[UIImage imageNamed:@"alert" inBundle:AirTurnUIBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
                        button.tintColor = [UIColor systemYellowColor];
                        [accessoryViews addObject:button];
                    }
                } break;
                case AirTurnConnectionStateConnecting:
                case AirTurnConnectionStateSystemConnected:
                case AirTurnConnectionStateDiscovering:
                    if([c.accessoryView isKindOfClass:[UIActivityIndicatorView class]]) {
                        [(UIActivityIndicatorView *)c.accessoryView startAnimating];
                    }
                    break;
                case AirTurnConnectionStateDisconnected: {
                    if(p.lastConnectionFailed) {
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                        [button addTarget:self action:@selector(deviceConnectionProblemButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
                        [button setImage:[UIImage imageNamed:@"alert" inBundle:AirTurnUIBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
                        button.tintColor = [UIColor redColor];
                        [accessoryViews addObject:button];
                    }
                    c.textLabel.textColor = p.hasBonding ? UIColor.disabledColor : UIColor.standardTextColor;
                } break;
                default:
                    break;
            }
            if(state == AirTurnConnectionStateDisconnected || state == AirTurnConnectionStateReady) {
                if(accessoryViews.count) {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
                    [button addTarget:self action:@selector(detailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [accessoryViews addObject:button];
                    [c setAccessoryViews:accessoryViews];
                } else {
                    c.accessoryView = nil; // fall back to accessory
                }
            }
            c.textLabel.text = p.name;
            c.textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
            [c setNeedsLayout];
            [c layoutIfNeeded];
            return c;
        }
        case UISectionOtherDevices: {
            if(self.AirDirectAvailable) {
                if(self.otherDevices.count) {
                    UITableViewCell *c;
                    c = [tableView dequeueReusableCellWithIdentifier:@"OtherAirTurn"];
                    if(!c) {
                        c = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OtherAirTurn"];
                    }
                    c.textLabel.text = self.otherDevices[indexPath.row].name;
                    return c;
                } else { // no other devices
                    return self.scanningCell;
                }
            } else { // unavailable
                return [self unavailableCell];
            }
        }
        case UISectionAddKeyboard: {
            UITableViewCell *c;
            c = [tableView dequeueReusableCellWithIdentifier:@"AddKeyboardAirTurn"];
            if(!c) {
                c = [UITableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddKeyboardAirTurn"];
                c.textLabel.textColor = c.textLabel.tintColor;
            }
            c.textLabel.text = AirTurnUILocalizedString(@"Add Keyboard AirTurn", @"Add keyboard airturn cell text");
            return c;
        }
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}


#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#if TARGET_OS_MACCATALYST
    // prevent keyboard navigation on macOS catalyst (https://stackoverflow.com/questions/61147893/how-to-disable-default-keyboard-navigation-in-mac-catalyst-app)
    [tableView performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0.1];
#endif
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch([self codeSectionForRealSection:indexPath.section]) {
        case UISectionEnable:
            if(!self.isPoweredOn) {
                [self.class goToSettings];
            }
            break;
        case UISectionAddedDevices: {
            if(!self.AirDirectAvailable || !self.addedDevices.count || (self.keyboardAdded && indexPath.row == 0)) return;
            AirTurnPeripheral *p = self.addedDevices[self.keyboardAdded ? indexPath.row - 1 : indexPath.row];
            switch (p.state) {
                case AirTurnConnectionStateReady:
                case AirTurnConnectionStateConnecting:
                    [AirTurnCentral.sharedCentral cancelAirTurnConnection:p];
                    break;
                case AirTurnConnectionStateDisconnecting:
                case AirTurnConnectionStateDisconnected:
                case AirTurnConnectionStateSystemConnected: // might be system connected and not requested by user
                    [AirTurnCentral.sharedCentral connectToAirTurn:p];
                    break;
                default:
                    break;
            }
            return;
        }
        case UISectionOtherDevices: {
            if(!self.AirDirectAvailable) {
                [self.class goToSettings];
                return;
            }
            if(!self.otherDevices.count) return;
            if(self.maxNumberOfAirDirectAirTurns > 0 && [AirTurnCentral sharedCentral].storedAirTurns.count == self.maxNumberOfAirDirectAirTurns) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:AirTurnUILocalizedString(@"Max number of AirTurns", @"AirTurn max number of AirTurns") message:[NSString stringWithFormat:AirTurnUILocalizedString(@"You can only connect %lu AirTurn(s) at once. To connect to this AirTurn, forget another AirTurn first", @"AirTurn max number of AirTurns message"), (unsigned long)self.maxNumberOfAirDirectAirTurns] preferredStyle:UIAlertControllerStyleAlert];
                [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"OK", @"OK button title") style:UIAlertActionStyleCancel handler:nil]];
                [self presentAlert:ac presentGlobally:NO animated:YES];
                return;
            }
            AirTurnPeripheral *p = self.otherDevices[indexPath.row];
            if(p.hasBonding) {
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:AirTurnUILocalizedString(@"Already bonded", @"AirTurn already bonded title") message:AirTurnUILocalizedString(@"This AirTurn is already paired to another device. Reset the AirTurn by holding power for 6s until it flashes to indicate it has reset, then try again", @"AirTurn already bonded message") preferredStyle:UIAlertControllerStyleAlert];
                [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"OK", @"OK button title") style:UIAlertActionStyleCancel handler:nil]];
                [self presentAlert:ac presentGlobally:NO animated:YES fromPeripheral:p];
            } else {
                [NSUserDefaults.standardUserDefaults setBool:YES forKey:AirDirectAirTurnsEnabled];
                [[AirTurnCentral sharedCentral] connectToAirTurn:p];
                [self movePeripheral:p toAdded:YES];
            }
            return;
        }
        case UISectionAddKeyboard:
            self.keyboardAdded = YES;
            [NSUserDefaults.standardUserDefaults setBool:YES forKey:KeyboardAirTurnEnabled];
            [self updateKeyboardEnabled];
            [self.tableView beginUpdates];
            [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:[self realSectionForCodeSection:UISectionAddKeyboard]] toIndexPath:[NSIndexPath indexPathForRow:0 inSection:[self realSectionForCodeSection:UISectionAddedDevices]]];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:[self realSectionForCodeSection:UISectionAddKeyboard]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            break;
    }
}

- (void)detailTapped:(AirTurnPeripheral *)peripheral {
    AirTurnUIDeviceTableViewController *controller = [AirTurnUIDeviceTableViewController.alloc initIsKeyboard:NO peripheral:peripheral];
    controller.delegate = self;
    controller.title = peripheral.name;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)detailButtonPressed:(UIButton *)button {
    for(NSInteger i = 0; i < self.addedDevices.count; i++) {
        if([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.keyboardAdded ? i + 1 : i inSection:[self realSectionForCodeSection:UISectionAddedDevices]]].accessoryView.subviews containsObject:button]) {
            AirTurnPeripheral *p = self.addedDevices[i];
            [self detailTapped:p];
        }
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    switch([self codeSectionForRealSection:indexPath.section]) {
        case UISectionAddedDevices: {
            if(self.keyboardAdded && indexPath.row == 0) {
                AirTurnUIDeviceTableViewController *controller = [AirTurnUIDeviceTableViewController.alloc initIsKeyboard:YES peripheral:nil];
                controller.delegate = self;
                controller.title = AirTurnUILocalizedString(@"Keyboard AirTurn", @"Keyboard AirTurn cell text");
                [self.navigationController pushViewController:controller animated:YES];
                return;
            }
            if(!self.addedDevices.count) return;
            AirTurnPeripheral *p = self.addedDevices[self.keyboardAdded ? indexPath.row - 1 : indexPath.row];
            [self detailTapped:p];
        } return;
        default:break;
    }
}

#pragma mark - Actions

- (void)infoButtonAction:(UIButton *)button {
    [[AirTurnInfoViewController sharedInfoViewController] display];
}

- (void)enableSwitchChanged:(UISwitch *)sender {
    self.enabled = sender.on;
}

- (void)deviceConnectionProblemButtonTapped:(UIButton *)sender {
    UIView *c = sender.superview;
    while(![c isKindOfClass:[UITableViewCell class]]) {
        c = c.superview;
        if(c == nil) {
            return;
        }
    }
    NSIndexPath *ip = [self.tableView indexPathForCell:(UITableViewCell *)c];
    if(ip != nil) {
        AirTurnPeripheral *p = self.otherDevices[ip.row];
        [self presentConnectionProblemAlertForPeripheral:p];
    }
}

- (void)nonAirDirectModeWarningTapped:(UIButton *)sender {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:AirTurnUILocalizedString(@"Mode 2+", @"Non airdirect mode alert title") message:AirTurnUILocalizedString(@"When an AirTurn is connected in modes 2+ you may experience problems with the on-screen keyboard. Switch to mode 1 to avoid these issues", @"Non airdirect mode error message") preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"Dismiss", @"Dismiss button title") style:UIAlertActionStyleCancel handler:nil]];
    [self presentAlert:ac presentGlobally:NO animated:YES];
}

- (void)chargingFaultButtonTapped:(UIButton *)sender {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:AirTurnUILocalizedString(@"Charging fault", @"Charging fault alert title") message:AirTurnUILocalizedString(@"A fault occurred while charging. Disconnect the power supply and reconnect. If the issue persists, contact AirTurn support", @"Charging fault error message") preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:AirTurnUILocalizedString(@"Dismiss", @"Dismiss button title") style:UIAlertActionStyleCancel handler:nil]];
    [self presentAlert:ac presentGlobally:NO animated:YES];
}

- (void)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)deviceForget:(nonnull AirTurnUIDeviceTableViewController *)deviceController {
    if(deviceController.isKeyboard) {
        self.keyboardAdded = NO;
        [NSUserDefaults.standardUserDefaults setBool:NO forKey:KeyboardAirTurnEnabled];
        [self updateKeyboardEnabled];
        if(self.viewVisible) {
            [self.tableView beginUpdates];
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:[self realSectionForCodeSection:UISectionAddKeyboard]] withRowAnimation:UITableViewRowAnimationNone];
            if(self.addedDevices.count == 0) {
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:[self realSectionForCodeSection:UISectionAddedDevices]]] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:[self realSectionForCodeSection:UISectionAddedDevices]]] withRowAnimation:UITableViewRowAnimationNone];
            }
            [self.tableView endUpdates];
        }
    } else {
        [AirTurnCentral.sharedCentral forgetAirTurn:deviceController.peripheral];
        [self movePeripheral:deviceController.peripheral toAdded:NO];
        if(AirTurnCentral.sharedCentral.storedAirTurns.count == 0) {
            [NSUserDefaults.standardUserDefaults setBool:NO forKey:AirDirectAirTurnsEnabled];
        }
    }
}

@end


