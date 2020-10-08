#import <UIKit/UIKit.h>
#import <AirTurnInterface/AirTurnInterface.h>

//
//  AirTurnDeviceTableViewController.h
//  AirTurnExample
//
//  Created by Nick Brook on 01/05/2020.
//  Copyright © 2020 AirTurn. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@class AirTurnUIDeviceTableViewController;

/// The delegate protocol for `AirTurnUIDeviceTableViewController`
@protocol AirTurnUIDeviceDelegate <NSObject>

/// The device should be forgotten
/// @param deviceController The device controller
- (void)deviceForget:(AirTurnUIDeviceTableViewController *)deviceController;

@end

/// A table view controller for displaying details about a device
@interface AirTurnUIDeviceTableViewController : UITableViewController

/// Determines if keyboard management is set enabled (in storage)
@property(class, nonatomic, readonly) BOOL isKeyboardManagementEnabled;

/// If YES, will display the list of actions in a popover instead of pushing the VC
@property(class, nonatomic, assign) BOOL displayActionsInPopover;

/// A delegate for the device table view controller
@property(nonatomic, weak) id<AirTurnUIDeviceDelegate> delegate;

/// Determines if this VC is for the keyboard AirTurn or not
@property (nonatomic, readonly) BOOL isKeyboard;

/// If not for a keyboard AirTurn, the peripheral associated with it
@property (nonatomic, readonly) AirTurnPeripheral *peripheral;

/// Create a device table view controller
/// @param isKeyboard Determines if the VC is for a keyboard AirTurn
/// @param peripheral If `isKeyboard` is `NO` a peripheral must be provided
- (instancetype)initIsKeyboard:(BOOL)isKeyboard peripheral:(nullable AirTurnPeripheral *)peripheral;

@end

NS_ASSUME_NONNULL_END


//
//  AirTurnUIController.h
//  AirTurnExample
//
//  Created by Nick Brook on 01/03/2014.
//
//


#ifndef IBInspectable
#define IBInspectable
#endif

@protocol AirTurnUIDelegate;

/**
 Controls the AirTurn user interface table view
 
 By default the AirTurnUIConnectionController class will automatically restore the AirTurn Interface to it's previous state when the App was last used, i.e. enabled/disabled, keyboard added or not, previously connected AirDirect AirTurns.
 
 If you would rather the UI/framework starts in the default disabled state, add the key `AirTurnUIRestoreState` to your info.plist and set it to boolean NO. This is discouraged, as it means your users will have to re-enable AirTurn support every time the App is launched.
 */
@interface AirTurnUITableViewController : UITableViewController

#pragma mark Essential
/**
 Support for Keyboard AirTurns (BT-105, BT-106, DIGIT, DIGIT II, QUAD, STOMP6)
 */
@property(nonatomic, readonly) IBInspectable BOOL supportKeyboard;

/**
 Support for AirDirect AirTurns (PED, PEDpro, DIGIT III, BT200(S), QUAD200)
 */
@property(nonatomic, readonly) IBInspectable BOOL supportAirDirect;

/**
 Defines the maximum number of AirTurns that can be connected simultaneously. Default is 0, which is unlimited. An alert is displayed if already connected to max number and user attempts to connect to another.
 */
@property(nonatomic, assign) IBInspectable NSInteger maxNumberOfAirDirectAirTurns;

/**
 Check for firmware updates when an AirTurn connects. Offers to take the user to the AirTurn App if an update is available. Default NO.
 */
@property(nonatomic, readonly) IBInspectable BOOL checkForFirmwareUpdates;

/**
 Init method, use this instead of -init
 
 @param keyboard  Enable support for Keyboard AirTurns (BT-105, BT-106, DIGIT, DIGIT II, QUAD, STOMP6)
 @param AirDirect Enable support for AirDirect AirTurns (PED, PEDpro, DIGIT III)
 
 @return UI controller object
 */
- (nonnull instancetype)initSupportingKeyboardAirTurn:(BOOL)keyboard AirDirectAirTurn:(BOOL)AirDirect;

#pragma mark Advanced
/**
 If `true`, displays the 'AirTurn support' enabled/disable toggle switch.  If `false` when loaded from nib, the `enabled` property is `true` by default.  Default `true`.
 */
@property(nonatomic, assign) IBInspectable BOOL displayEnableToggle;

/**
 Toggle the AirTurn framework on or off (same action as switch in UI)
 */
@property(nonatomic, assign) BOOL enabled;

/**
 A dictionary of digital app action identifiers (keys) and their associated human readable text labels. The localized version of the text labels will be used in the UI.
 */
@property(class, nonatomic, strong, nullable) NSDictionary<AirTurnAppAction, NSString *> *digitalAppActions;

/**
 A dictionary of `AirTurnPort` to app action identifier mappings to use as the default for new devices
 */
@property(class, nonatomic, strong, nullable) NSDictionary<NSNumber *, AirTurnAppAction> *digitalAppActionDefaultMapping;

/**
 A dictionary of analog app action identifiers (keys) and their associated human readable text labels. The localized version of the text labels will be used in the UI.
 */
@property(class, nonatomic, strong, nullable) NSDictionary<AirTurnAppAction, NSString *> *analogAppActions;

@end


