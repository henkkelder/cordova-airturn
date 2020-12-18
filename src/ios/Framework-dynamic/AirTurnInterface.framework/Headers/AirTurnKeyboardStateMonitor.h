//
//  AirTurnStateMonitor.h
//  AirTurnInterface
//
//  Created by Nick Brook on 28/09/2014.
//  Copyright (c) 2014 Nick Brook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AirTurnInterface/AirTurnLogging.h>
#import <AirTurnInterface/AirTurnTypes.h>

/**
 Indicates the keyboard state monitor is ready
 */
AIRTURN_NOTIFICATION AirTurnKeyboardStateMonitorReadyNotification;
/**
 Indicates the first responder has changed
 */
AIRTURN_NOTIFICATION AirTurnKeyboardStateMonitorFirstResponderChangedNotification;

/**
 Indicates the first responder owner has changed
 */
AIRTURN_NOTIFICATION AirTurnKeyboardStateMonitorFirstResponderOwnerChangedNotification;

/**
 External keyboard connection status changed. Notifications do not occur if automatic keyboard management is disabled
 */
AIRTURN_NOTIFICATION AirTurnKeyboardStateMonitorExternalKeyboardStateChangedNotification;

/**
 Virtual keyboard state changed. Notifications do not occur if automatic keyboard management is disabled
 */
AIRTURN_NOTIFICATION AirTurnKeyboardStateMonitorVirtualKeyboardShouldBeShownChangedNotification;

/**
A type for all AirTurnKeyboardState notification user info keys
*/
typedef AirTurnNotificationUserInfoKey AirTurnKeyboardStateNotificationUserInfoKey NS_TYPED_ENUM;
#define AIRTURN_KEYBOARD_STATE_NOTIFICATION_KEY AIRTURN_STRING_CONST(AirTurnKeyboardStateNotificationUserInfoKey)
/**
 The userinfo key for the direction the keyboard is going. The value is an NSNumber. 1 indicates the keyboard is coming on screen. -1 indicates the keyboard is going off screen.
 */
AIRTURN_KEYBOARD_STATE_NOTIFICATION_KEY AirTurnKeyboardStateMonitorVirtualKeyboardDirectionKey;

/**
 Determines the normal state of the virtual keyboard (i.e. the state the virtual keyboard is in as controlled by the OS)
 */
typedef NS_ENUM(NSInteger, AirTurnVirtualKeyboardNormalState){
    /**
     The virtual keyboard is hidden
     */
    AirTurnVirtualKeyboardNormalStateHidden,
	/**
	 The keyboard toolbar is visible
	 */
	AirTurnVirtualKeyboardNormalStateToolbarVisible,
    /**
     The virtual keyboard and toolbar is visible
     */
    AirTurnVirtualKeyboardNormalStateFullyVisible
};

/**
 The first responder owner
 */
typedef NS_ENUM(NSInteger, AirTurnFirstResponderOwner) {
    /**
     There is no first responder
     */
    AirTurnFirstResponderOwnerNone,
    /**
     The first responder is in this App
     */
    AirTurnFirstResponderOwnerLocal,
    /**
     The first responder is in another App in split screen
     */
    AirTurnFirstResponderOwnerRemote
};

/**
 Monitors the state of the virtual keyboard and first responders, and from this determines the state of the external keyboard
 */
@interface AirTurnKeyboardStateMonitor : NSObject

/**
 If `YES`, keyboard state reassessment will be performed when necessary to determine if an external keyboard is connected. This process requires a test view to become first responder briefly. If automatic keyboard management is not enabled this may cause the on screen keyboard to be displayed briefly. If you do not need to know the state of the external keyboard this can be set to NO. This will mean `AirTurnKeyboardStateMonitor.isExternalKeyboardConnected` and `AirTurnViewManager.connected` are invalid.
 By default this property is `YES` if automatic keyboard management is available.
 */
@property(nonatomic, assign) BOOL allowKeyboardStateReassessment;

/**
 The current first responder
 */
@property(nonatomic, readonly, weak, nullable) UIResponder *firstResponder;

/**
 The previous first responder before AirTurnView recaptured first responder status
 */
@property(nonatomic, readonly, weak, nullable) UIResponder *firstResponderBeforeRecapture;

/**
 Determines the normal virtual keyboard state
 */
@property(nonatomic, readonly) AirTurnVirtualKeyboardNormalState normalVirtualKeyboardState;

/**
 Normal virtual keyboard is animating
 */
@property(nonatomic, readonly) BOOL normalVirtualKeyboardIsAnimating;

/**
 The normal virtual keyboard animating from state
 */
@property(nonatomic, readonly) AirTurnVirtualKeyboardNormalState normalVirtualKeyboardAnimatingFromState;

/**
 Determines who owns the first responder – no first responder, local App or remote App (split screen)
 */
@property(nonatomic, readonly) AirTurnFirstResponderOwner firstResponderOwner;

/**
 Determines if the virtual keyboard should be shown
 */
@property(nonatomic, readonly) BOOL virtualKeyboardShouldBeShown;

/**
 Determines if an external hardware keyboard (e.g. BT-105) is connected. Not valid if automatic keyboard management is disabled as the keyboard must be "displayed" by iOS to monitor when the external keyboard is connected or not, and when automatic keyboard management is disabled a zero rect inputView is used on UIView to prevent keyboard display without keyboard management.
 */
@property(nonatomic, readonly) BOOL isExternalKeyboardConnected;

/**
 Determines if the keyboard state monitor is reassessing the external keyboard state. If so, you can add a block to be notified of completion using
 */
@property(nonatomic, readonly) BOOL isReassessingKeyboardState;

/**
 Determines if the singleton has been initialised
 
 @return `YES` if initialised
 */
+ (BOOL)initialized;

/**
 The shared monitor object
 
 @return The shared state monitor
 */
+ (nullable AirTurnKeyboardStateMonitor *)sharedMonitor;

/**
 Add a block to be called when the external keyboard state has been reassessed

 @param reason A human readable reason for performing keyboard state reassessment
 @param completion Completion block
 */
- (void)reassessKeyboardStateReason:(nonnull NSString *)reason completion:(nonnull void (^)(void))completion;

@end
