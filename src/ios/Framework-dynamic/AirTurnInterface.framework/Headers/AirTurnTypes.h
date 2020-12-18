//
//  AirTurnTypes.h
//  AirTurnInterface
//
//  Created by Nick Brook on 04/01/2012.
//  Copyright (c) 2012 Nick Brook. All rights reserved.
//
//  Permission is hereby granted, to any person (the “Licensee”) who has 
//  legitimately purchased a copy of this framework, example code and 
//  associated documentation (the “Software”) from AirTurn Inc, to use the 
//  compiled binary framework and any parts of the example code within their 
//  own software for distribution and sale on the Apple App Store. The 
//  Software must remain unmodified except any portion of the example source 
//  code which may be used and modified without restriction. The Licensee has 
//  no right to distribute any part of the Software further beyond this 
//  Agreement.

//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
//  DEALINGS IN THE SOFTWARE.
//

#import <AirTurnInterface/AirTurnDefines.h>
#import <AirTurnInterface/AirTurnKeyCodes.h>

#define AIRTURN_STRING_CONST(type) AIRTURN_EXTERN type _Nonnull const

#define AIRTURN_NOTIFICATION AIRTURN_STRING_CONST(NSNotificationName)

/**
A type for all AirTurn notification user info keys
*/
typedef NSString * AirTurnNotificationUserInfoKey NS_TYPED_EXTENSIBLE_ENUM;
#define AIRTURN_NOTIFICATION_KEY AIRTURN_STRING_CONST(AirTurnNotificationUserInfoKey)

/// ---------------------------------
/// @name Standard userInfo keys
/// ---------------------------------

/**
 The notification `userInfo` key for the peripheral that the notification is concerning. The value is an `AirTurnPeripheral` object. Only present on BTLE device notifications.
 */
AIRTURN_NOTIFICATION_KEY AirTurnPeripheralKey;

/**
 The notification `userInfo` key for the AirTurn identifier. The value is a `NSString` object. Only present on BTLE device notifications.
 */
AIRTURN_NOTIFICATION_KEY AirTurnIDKey;

/**
 The notification `userInfo` key for the device type on connection notification. The value is an `NSNumber` object containing an integer which is one of the `AirTurnDeviceType` enum values.
 */
AIRTURN_NOTIFICATION_KEY AirTurnDeviceTypeKey;

/**
 The notification `userInfo` key indicating if the device is an AirDirect device or not. The value is an `NSNumber` object containing a boolean value, YES if an AirTurnDirect device.
 */
AIRTURN_NOTIFICATION_KEY AirTurnConnectionModeAirDirectKey;

/**
 The notification `userInfo` key for an error. The value is an `NSError` object.
 */
AIRTURN_NOTIFICATION_KEY AirTurnErrorKey;

/// ---------------------------------
/// @name Pedal State Notifications
/// ---------------------------------

/**
 A notification indicating which pedal was pressed. A press occurs on pedal down, then at the key repeat rate after intial repeat delay. The `userInfo` dictionary contains all standard keys and the key `AirTurnPortNumberKey` contains the port of the pedal that was pressed and `AirTurnPortStateKey` contains the state of the pedal, which will be `AirTurnPortStateDown`. For HID devices, `AirTurnKeyCodeKey` contains the key code. For AirDirect devices, `AirTurnPedalRepeatCount` contains the number of key repeats.
 */
AIRTURN_NOTIFICATION AirTurnPedalPressNotification;
/**
 A notification indicating a pedal was pressed down. The `userInfo` dictionary contains all standard keys and the key `AirTurnPortNumberKey` contains the port of the pedal that was pressed and `AirTurnPortStateKey` contains the state of the pedal, which will be `AirTurnPortStateDown`.
 */
AIRTURN_NOTIFICATION AirTurnPedalDownNotification;
/**
 A notification indicating a pedal was lifted. The `userInfo` dictionary contains all standard keys and the key `AirTurnPortNumberKey` contains the port of the pedal that was lifted and `AirTurnPortStateKey` contains the state of the pedal, which will be `AirTurnPortStateUp`. For AirDirect devices, `AirTurnPedalRepeatCount` contains the number of key repeats that occurred.
 */
AIRTURN_NOTIFICATION AirTurnPedalUpNotification;
/**
 A notification indicating a pedal press was cancelled. The `userInfo` dictionary contains all standard keys and the key `AirTurnPortNumberKey` contains the port of the pedal that was cancelled and `AirTurnPortStateKey` contains the state of the pedal, which will be `AirTurnPortStateUp`.
 */
AIRTURN_NOTIFICATION AirTurnPedalCancelledNotification;

/**
A type for all AirTurnPedal notification user info keys
*/
typedef AirTurnNotificationUserInfoKey AirTurnPedalNotificationUserInfoKey NS_TYPED_ENUM;
#define AIRTURN_PEDAL_NOTIFICATION_KEY AIRTURN_STRING_CONST(AirTurnPedalNotificationUserInfoKey)

/**
 The notification `userInfo` key for the port number. The value is an `NSNumber` object containing an integer which is one of the `AirTurnPort` enum values.
 */
AIRTURN_PEDAL_NOTIFICATION_KEY AirTurnPortNumberKey;

/**
 The notification `userInfo` key for the port state. The value is an `NSNumber` object containing an integer which is one of the `AirTurnPortState` enum values.
 */
AIRTURN_PEDAL_NOTIFICATION_KEY AirTurnPortStateKey;

/**
The notification `userInfo` key for the app action. The value is an `NSString` object which is one of the App Actions set to `AirTurnManager`.
*/
AIRTURN_PEDAL_NOTIFICATION_KEY AirTurnAppActionKey;

/**
 The notification `userInfo` key for the port state from a HID device only. The value is an `NSNumber` object containing an integer which is one of the `AirTurnKeyCode` enum values.
 */
AIRTURN_PEDAL_NOTIFICATION_KEY AirTurnKeyCodeKey;

/**
 The notification `userInfo` key for the underlying event type that triggered this notification. The value is an `NSNumber` object containing an integer which is one of the `AirTurnUnderlyingEventType` enum values.
 */
AIRTURN_PEDAL_NOTIFICATION_KEY AirTurnUnderlyingEventTypeKey;

/**
 The notification `userInfo` key for the underlying event key input for this notification. The value is an `NSString` object which is one of the `UIKeyInput` values, or a string representing a key. This key will only be present if the `AirTurnUnderlyingEventTypeKey` is `AirTurnUnderlyingEventTypeKeyCommand`.
 */
AIRTURN_PEDAL_NOTIFICATION_KEY AirTurnUnderlyingEventKeyInputKey;

/**
 The notification `userInfo` key for the underlying event HID usage for this notification. The value is an `NSNumber` object containing an integer which is one of the `UIKeyboardHIDUsage` enum values. This key will only be present if the `AirTurnUnderlyingEventTypeKey` is `AirTurnUnderlyingEventTypePresses`.
 */
AIRTURN_PEDAL_NOTIFICATION_KEY AirTurnUnderlyingEventHIDUsageKey;

/**
 The notification `userInfo` key for the repeat count when a pedal is held. Only present For AirDirect devices. The value is an `NSNumber` object containing an integer representing the number of repeats. This will be 0 on the first pedal press event and increment subsequently.
 */
AIRTURN_PEDAL_NOTIFICATION_KEY AirTurnPedalRepeatCountKey;

/// ---------------------------------
/// @name Analog port Notifications
/// ---------------------------------

/**
 A notification indicating the analog port value changed. The `userInfo` dictionary contains all standard keys and the key `AirTurnPortNumberKey` contains the port that has changed.
 */
AIRTURN_NOTIFICATION AirTurnAnalogPortValueChangeNotification;

/**
A type for all AirTurnAnalog notification user info keys
*/
typedef AirTurnNotificationUserInfoKey AirTurnAnalogNotificationUserInfoKey NS_TYPED_ENUM;
#define AIRTURN_ANALOG_NOTIFICATION_KEY AIRTURN_STRING_CONST(AirTurnAnalogNotificationUserInfoKey)
/**
 The notification `userInfo` key for the port value. The value is an `NSNumber` object containing an integer of type `AirTurnPortValue`.
 */
AIRTURN_ANALOG_NOTIFICATION_KEY AirTurnAnalogPortValueKey;

/// ---------------------------------
/// @name BTLE Central State Notifications
/// ---------------------------------

/**
 A notification indicating the state of the central has changed. The `userInfo` key `AirTurnCentralStateKey` contains an `NSNumber` object containing an integer which is one of the `AirTurnCentralState` enum values
 */
AIRTURN_NOTIFICATION AirTurnCentralStateChangedNotification;

/**
A type for all AirTurnCentral notification user info keys
*/
typedef AirTurnNotificationUserInfoKey AirTurnCentralNotificationUserInfoKey NS_TYPED_ENUM;
#define AIRTURN_CENTRAL_NOTIFICATION_KEY AIRTURN_STRING_CONST(AirTurnCentralNotificationUserInfoKey)

/**
 The notification `userInfo` key for the new central state. The value is an `NSNumber` object containing one of the `AirTurnCentralState` enum values
 */
AIRTURN_CENTRAL_NOTIFICATION_KEY AirTurnCentralStateKey;


/// ---------------------------------
/// @name BTLE Devices Discovered Notifications
/// ---------------------------------

/**
 A notification indicating the list of BTLE Devices discovered has changed. The `userInfo` dictionary contains all standard keys and the key `AirTurnDiscoveredPeripheralsKey` contains the set of all discovered devices, and `AirTurnPeripheralKey` contains the device just discovered
 */
AIRTURN_NOTIFICATION AirTurnDiscoveredNotification;

/**
A type for all AirTurnDiscovered notification user info keys
*/
typedef AirTurnNotificationUserInfoKey AirTurnDiscoveredNotificationUserInfoKey NS_TYPED_ENUM;
#define AIRTURN_DISCOVERED_NOTIFICATION_KEY AIRTURN_STRING_CONST(AirTurnDiscoveredNotificationUserInfoKey)

/**
 The notification `userInfo` key for all discovered BTLE devices. The value is an `NSSet` object containing `AirTurnPeripheral` objects. Pass a peripheral object back to `-connectToAirTurn:` on `AirTurnCentral` to connect.
 */
AIRTURN_DISCOVERED_NOTIFICATION_KEY AirTurnDiscoveredPeripheralsKey;

/**
 A notification indicating the list of BTLE Devices discovered has changed. The `userInfo` dictionary contains all standard keys and the key `AirTurnDiscoveredDevicesKey` contains the set of all discovered devices, and `AirTurnPeripheralKey` contains the device just lost. The device could have been lost if we have not received an advertising packet within a 10 second window, 10 seconds after disconnecting from a device without receiving an advertising packet, or when the state of the Bluetooth radio changes.
 */
AIRTURN_NOTIFICATION AirTurnLostNotification;

/// ---------------------------------
/// @name Connection Notifications
/// ---------------------------------

/**
 A notification indicating the BTLE central is connecting to an AirTurn. The `userInfo` dictionary contains all standard keys.
 */
AIRTURN_NOTIFICATION AirTurnConnectingNotification;

/**
 A notification indicating the connection state changed. The `userInfo` dictionary contains all standard keys and the key `AirTurnConnectionStateKey` contains the new connection state. Works with AirDirect and Keyboard. Only sent in Keyboard mode if automatic keyboard management is enabled, see `AirTurnViewManager.connected` for more info.
 */
AIRTURN_NOTIFICATION AirTurnConnectionStateChangedNotification;
/**
 A notification indicating an AirTurn device connected. The `userInfo` dictionary contains all standard keys and the key `AirTurnConnectionStateKey` contains the new connection state. Works with AirDirect and Keyboard. Only sent in Keyboard mode if automatic keyboard management is enabled, see `AirTurnViewManager.connected` for more info.
 */
AIRTURN_NOTIFICATION AirTurnDidConnectNotification;
/**
 A notification indicating an AirTurn device failed to connect. The `userInfo` dictionary contains all standard keys and the key `AirTurnConnectionStateKey` contains the new connection state
 */
AIRTURN_NOTIFICATION AirTurnDidFailToConnectNotification;
/**
 A notification indicating an AirTurn device disconnected. The `userInfo` dictionary contains all standard keys and the key `AirTurnConnectionStateKey` contains the new connection state. Works with AirDirect and Keyboard. Only sent in Keyboard mode if automatic keyboard management is enabled, see `AirTurnViewManager.connected` for more info.
 */
AIRTURN_NOTIFICATION AirTurnDidDisconnectNotification;

/**
A type for all AirTurnConnection notification user info keys
*/
typedef AirTurnNotificationUserInfoKey AirTurnConnectionNotificationUserInfoKey NS_TYPED_ENUM;
#define AIRTURN_CONNECTION_NOTIFICATION_KEY AIRTURN_STRING_CONST(AirTurnConnectionNotificationUserInfoKey)

/**
 The notification `userInfo` key for the connected state. The value is an `NSNumber` object containing an integer which is one of the `AirTurnConnectionState` enum values
 */
AIRTURN_CONNECTION_NOTIFICATION_KEY AirTurnConnectionStateKey;

/// ---------------------------------
/// @name Storage notifications
/// ---------------------------------

/**
 A notification indicating an AirTurn device was added. The `userInfo` dictionary contains all standard keys
 */
AIRTURN_NOTIFICATION AirTurnAddedNotification;

/**
 A notification indicating an AirTurn device was removed. The `userInfo` dictionary contains all standard keys
 */
AIRTURN_NOTIFICATION AirTurnRemovedNotification;

/**
 A notification indicating an AirTurn device was invalidated, meaning the identifier originally used is no longer valid and your Application should removed any stored data relating to that identifier. This notification can only occur at App start. The `userInfo` key `AirTurnIDKey` contains a unique identifier string for the device.
 */
AIRTURN_NOTIFICATION AirTurnInvalidatedNotification;

/// ---------------------------------
/// @name Peripheral Notifications
/// ---------------------------------

/**
 A notification indicating the current mode of the peripheral has changed. The `userInfo` dictionary contains all standard keys. The posting object is the `AirTurnPeripheral`.
 */
AIRTURN_NOTIFICATION AirTurnDidUpdateCurrentModeNotification;

/**
 A notification indicating the name of the peripheral has changed. The `userInfo` dictionary contains all standard keys. The posting object is the `AirTurnPeripheral`.
 */
AIRTURN_NOTIFICATION AirTurnDidUpdateNameNotification;

/**
 A notification indicating the charging state of the peripheral has changed. The `userInfo` dictionary contains all standard keys. The posting object is the `AirTurnPeripheral`.
 */
AIRTURN_NOTIFICATION AirTurnDidUpdateChargingStateNotification;

/**
 A notification indicating the battery level of the peripheral has changed. The `userInfo` dictionary contains all standard keys. The posting object is the `AirTurnPeripheral`.
 */
AIRTURN_NOTIFICATION AirTurnDidUpdateBatteryLevelNotification;

/**
 A notification indicating the pairing state of the peripheral has changed. The `userInfo` dictionary contains all standard keys. The posting object is the `AirTurnPeripheral`.
 */
AIRTURN_NOTIFICATION AirTurnDidUpdatePairingStateNotification;

/// ---------------------------------
/// @name Keyboard Notifications
/// ---------------------------------

/**
 A notification indicating automatic keyboard management was enabled or disabled.
 */
AIRTURN_NOTIFICATION AirTurnAutomaticKeyboardManagementEnabledChangedNotification;

/**
 A notification indicating the virtual keyboard will be displayed.  The posting object is the `AirTurnKeyboardManager` shared object. The `userInfo` dictionary contains the keys `AirTurnVirtualKeyboardFrameBeginUserInfoKey`, `AirTurnVirtualKeyboardFrameEndUserInfoKey`, `AirTurnVirtualKeyboardAnimationCurveUserInfoKey` and `AirTurnVirtualKeyboardAnimationDurationUserInfoKey`.
 */
AIRTURN_NOTIFICATION AirTurnVirtualKeyboardWillShowNotification;

/**
 A notification indicating the virtual keyboard was displayed.  The posting object is the `AirTurnKeyboardManager` shared object. The `userInfo` dictionary contains the keys `AirTurnVirtualKeyboardFrameBeginUserInfoKey`, `AirTurnVirtualKeyboardFrameEndUserInfoKey`, `AirTurnVirtualKeyboardAnimationCurveUserInfoKey` and `AirTurnVirtualKeyboardAnimationDurationUserInfoKey`.
 */
AIRTURN_NOTIFICATION AirTurnVirtualKeyboardDidShowNotification;

/**
 A notification indicating the virtual keyboard will be hidden.  The posting object is the `AirTurnKeyboardManager` shared object. The `userInfo` dictionary contains the keys `AirTurnVirtualKeyboardFrameBeginUserInfoKey`, `AirTurnVirtualKeyboardFrameEndUserInfoKey`, `AirTurnVirtualKeyboardAnimationCurveUserInfoKey` and `AirTurnVirtualKeyboardAnimationDurationUserInfoKey`.
 */
AIRTURN_NOTIFICATION AirTurnVirtualKeyboardWillHideNotification;

/**
 A notification indicating the virtual keyboard was hidden.  The posting object is the `AirTurnKeyboardManager` shared object. The `userInfo` dictionary contains the keys `AirTurnVirtualKeyboardFrameBeginUserInfoKey`, `AirTurnVirtualKeyboardFrameEndUserInfoKey`, `AirTurnVirtualKeyboardAnimationCurveUserInfoKey` and `AirTurnVirtualKeyboardAnimationDurationUserInfoKey`.
 */
AIRTURN_NOTIFICATION AirTurnVirtualKeyboardDidHideNotification;

/**
A type for all AirTurnVirtualKeyboard notification user info keys
*/
typedef AirTurnNotificationUserInfoKey AirTurnVirtualKeyboardNotificationUserInfoKey NS_TYPED_ENUM;
#define AIRTURN_VIRTUAL_KEYBOARD_NOTIFICATION_KEY AIRTURN_STRING_CONST(AirTurnVirtualKeyboardNotificationUserInfoKey)

/**
 The notification `userInfo` key for the frame of the keyboard at the beginning of an animation at a show/hide notification.  The value is an `NSValue` object containing a `CGRect`.
 */
AIRTURN_VIRTUAL_KEYBOARD_NOTIFICATION_KEY AirTurnVirtualKeyboardFrameBeginUserInfoKey;

/**
 The notification `userInfo` key for the frame of the keyboard at the end of an animation at a show/hide notification.  The value is an `NSValue` object containing a `CGRect`.
 */
AIRTURN_VIRTUAL_KEYBOARD_NOTIFICATION_KEY AirTurnVirtualKeyboardFrameEndUserInfoKey;

/**
 The notification `userInfo` key for the keyboard animation curve at a show/hide notification.  The value is an `NSNumber` object containing a `UIViewAnimationCurve` constant.
 */
AIRTURN_VIRTUAL_KEYBOARD_NOTIFICATION_KEY AirTurnVirtualKeyboardAnimationCurveUserInfoKey;

/**
 The notification `userInfo` key for the keyboard animation duration at a show/hide notification.  The value is an `NSNumber` object containing a `double` that identifies the duration of the animation in seconds.
 */
AIRTURN_VIRTUAL_KEYBOARD_NOTIFICATION_KEY AirTurnVirtualKeyboardAnimationDurationUserInfoKey;

/// ---------------------------------
/// @name enums
/// ---------------------------------


/**
 Represents the current mode of the AirTurn
 */
typedef NS_ENUM(NSInteger, AirTurnMode) {
    /**
     No mode
     */
    AirTurnModeNone = 0,
    /**
     Mode 1 – iOS mode
     */
    AirTurnMode1 = 1,
    /**
     Mode 2 – Programmable mode 2
     */
    AirTurnMode2,
    /**
     Mode 3 – Programmable mode 3
     */
    AirTurnMode3,
    /**
     Mode 4 – Programmable mode 4
     */
    AirTurnMode4,
    /**
     Mode 5 – Programmable mode 5
     */
    AirTurnMode5,
    /**
     Programmable mode 6
     */
    AirTurnMode6,
    /**
     Programmable mode 7
     */
    AirTurnMode7,
    /**
     Programmable mode 8
     */
    AirTurnMode8,
    /**
     The minimum mode value
     */
    AirTurnModeMinimum = AirTurnMode1,
    /**
     The maximum mode value
     */
    AirTurnModeMaximum = AirTurnMode8,
	/**
	 Defines the number of modes available
	 */
	AirTurnModeMaxNumberOfModes = AirTurnModeMaximum - AirTurnModeMinimum + 1
};

/**
 Constants defining the AirTurn port numbers
 */
typedef NS_ENUM(NSInteger, AirTurnPort) {
    /**
     An invalid port number
     */
    AirTurnPortInvalid = 0,
    /**
     AirTurn Port 1, usually 'Up'
     */
    AirTurnPort1,
    /**
     AirTurn Port 2, usually 'Left'
     */
    AirTurnPort2,
    /**
     AirTurn Port 3, usually 'Down'
     */
    AirTurnPort3,
    /**
     AirTurn Port 4, usually 'Right'
     */
    AirTurnPort4,
    /**
     AirTurn Port 5
     */
    AirTurnPort5,
    /**
     AirTurn Port 6
     */
    AirTurnPort6,
    /**
     AirTurn Port 7
     */
    AirTurnPort7,
    /**
     AirTurn Port 8
     */
    AirTurnPort8,
    /**
     The minimum port number
     */
    AirTurnPortMinimum = AirTurnPort1,
    /**
     The maximum port number
     */
    AirTurnPortMaximum = AirTurnPort8,
	/**
	 Defines the number of ports available
	 */
	AirTurnPortMaxNumberOfPorts = AirTurnPortMaximum - AirTurnPortMinimum + 1
};

/**
 Constants defining the AirTurn port states
 */
typedef NS_ENUM(NSInteger, AirTurnPortState) {
    /**
     Invalid port state
     */
    AirTurnPortStateInvalid = -1,
    /**
     The port state is up, i.e. the pedal is not pressed
     */
    AirTurnPortStateUp = 0,
    /**
     The port state is down, i.e. the pedal is pressed
     */
    AirTurnPortStateDown = 1
};

/**
 Constants defining the underlying event types
 */
typedef NS_ENUM(NSInteger, AirTurnUnderlyingEventType) {
    /**
     AirDirect underlying event type
     */
    AirTurnUnderlyingEventTypeAirDirect,
    /**
     Text input underlying event type, triggered from detecting text input events on the first responder
     */
    AirTurnUnderlyingEventTypeTextInput,
    /**
     Key command underlying event type, triggered from a `UIKeyCommand` performed on the first responder
     */
    AirTurnUnderlyingEventTypeKeyCommand,
    /**
     Presses underlying event type, triggered from a `presses(Began|Ended|Cancelled)` performed on the first responder
     */
    AirTurnUnderlyingEventTypePresses,
};

/**
 A function that can be used to determine if an underlying event type will provide separate up and down pedal events, or if the up and down events will be sent simultaneously
 @param eventType The event type
 @return `YES` if separate up and down pedal events will be sent for the event type, `NO` otherwise.
 */
BOOL AirTurnUnderlyingEventTypeHasSeparateUpDownEvents(AirTurnUnderlyingEventType eventType);

/**
 Constants defining the AirTurn device type. If the device is connected via HID the device type cannot be determined and so will be `AirTurnDeviceTypeUnknown`
 */
typedef NS_ENUM(NSInteger, AirTurnDeviceType) {
    /**
     Invalid device type that the framework does not support
     */
    AirTurnDeviceTypeInvalid = -1,
    /**
     Unknown device type
     */
    AirTurnDeviceTypeUnknown = 0,
    /**
     HID device type (probably BT-105)
     */
    AirTurnDeviceTypeHID,
    /**
     AirTurn PED device type
     */
    AirTurnDeviceTypePED,
    /**
     AirTurn virtual AirTurn device type
     */
    AirTurnDeviceTypeVirtualAirTurn,
    /**
     AirTurn PEDpro device type
     */
    AirTurnDeviceTypePEDpro,
    /**
     AirTurn DIGIT device type
     */
    AirTurnDeviceTypeDIGIT3,
    /**
     AirTurn BT200 device type
     */
    AirTurnDeviceTypeBT200,
    /**
     AirTurn BT200S-2 device type
     */
    AirTurnDeviceTypeBT200S_2,
    /**
     AirTurn BT200S-4 device type
     */
    AirTurnDeviceTypeBT200S_4,
    /**
     AirTurn BT200S-6 device type
     */
    AirTurnDeviceTypeBT200S_6,
    /**
     AirTurn QUAD200 device type
     */
    AirTurnDeviceTypeQUAD200,
    /**
     AirTurn BT500 device type
     */
    AirTurnDeviceTypeBT500,
    /**
     AirTurn BT500S-2 device type
     */
    AirTurnDeviceTypeBT500S_2,
    /**
     AirTurn BT500S-4 device type
     */
    AirTurnDeviceTypeBT500S_4,
    /**
     AirTurn BT500S-6 device type
     */
    AirTurnDeviceTypeBT500S_6,
};

/**
 Constants defining the type of inputs the AirTurn has.
 */
typedef NS_ENUM(NSInteger, AirTurnInputType) {
	/**
	 AirTurn has 'port' inputs. Examples include older keyboard only devices and unknown devices.
	 */
	AirTurnInputTypePort,
	/**
	 AirTurn has 'pedal' inputs. Examples include PEDpro.
	 */
	AirTurnInputTypeDualPedal,
    /**
     AirTurn has 'pedal' inputs. Examples include QUAD200.
     */
    AirTurnInputTypeManyPedal,
	/**
	 AirTurn has 'switch' inputs. Examples include BT200S-2
	 */
	AirTurnInputTypeSwitch,
	/**
	 AirTurn has 'button' inputs. Examples include DIGITIII
	 */
	AirTurnInputTypeButton,
    /**
     AirTurn has both 'ports' and directional pad inputs. Examples include BT200
     */
    AirTurnInputTypePortsAndPad
};

/**
 Constants defining the AirTurn connection states
 */
typedef NS_ENUM(NSInteger, AirTurnConnectionState) {
    /**
     Unknown connection state
     */
    AirTurnConnectionStateUnknown = 0,
    /**
     The AirTurn is disconnecting
     */
    AirTurnConnectionStateDisconnecting,
    /**
     The AirTurn is disconnected
     */
    AirTurnConnectionStateDisconnected,
    /**
     The AirTurn is connecting
     */
    AirTurnConnectionStateConnecting,
    /**
     The AirTurn is connected to the system, but not the App
     */
    AirTurnConnectionStateSystemConnected,
    /**
     The AirTurn is being interrogated
     */
    AirTurnConnectionStateDiscovering,
    /**
     The AirTurn is ready to use with the App
     */
    AirTurnConnectionStateReady
};

/**
 Defines which features are available for a mode
 */
typedef NS_OPTIONS(NSInteger, AirTurnModeFeatures) {
    /**
     Digital port config is available for this mode
     */
    AirTurnModeFeaturesDigitalPortConfig = 1 << 0,
    /**
     Analog port config is available for this mode
     */
    AirTurnModeFeaturesAnalogPortConfig = 1 << 1,
    /**
     Proprietary output is available for this mode
     */
    AirTurnModeFeaturesProprietary = 1 << 2,
    /**
     Keyboard output is available for this mode
     */
    AirTurnModeFeaturesKeyboard = 1 << 3,
    /**
     Consumer output is available for this mode
     */
    AirTurnModeFeaturesConsumer = 1 << 4,
    /**
     Mouse output is available for this mode
     */
    AirTurnModeFeaturesMouse = 1 << 5,
    /**
     Joystick output is available for this mode
     */
    AirTurnModeFeaturesJoystick = 1 << 6,
    /**
     MIDI output is available for this mode
     */
    AirTurnModeFeaturesMIDI = 1 << 7,
	/**
	 A mask of mode features that represent port configuration types
	 */
	AirTurnModeFeaturesPortConfigurationTypesMask = AirTurnModeFeaturesKeyboard | AirTurnModeFeaturesConsumer | AirTurnModeFeaturesMouse | AirTurnModeFeaturesJoystick | AirTurnModeFeaturesMIDI
};

/**
 Defines the charging states
 */
typedef NS_ENUM(NSInteger, AirTurnPeripheralChargingState) {
    /**
     The device is not connected to external power and is discharging
     */
    AirTurnPeripheralChargingStateDisconnectedDischarging,
    /**
     The device is connected to external power and is charging
     */
    AirTurnPeripheralChargingStateConnectedCharging,
    /**
     The device is connected to external power and is fully charged
     */
    AirTurnPeripheralChargingStateConnectedFullyCharged,
    /**
     The device is connected to external power and the battery is being validated before charging begins
     */
    AirTurnPeripheralChargingStateConnectedValidating,
    /**
     The device is connected to external power and a fault occurred during charging
     */
    AirTurnPeripheralChargingStateConnectedFault
};

/**
 Defines the central state
 */
typedef NS_ENUM(NSInteger, AirTurnCentralState) {
    /**
     Unknown central state
     */
    AirTurnCentralStateUnknown = 0,
    /**
     The central manager is resetting, wait for next state change...
     */
    AirTurnCentralStateResetting,
    /**
     Bluetooth low energy is not supported on this device
     */
    AirTurnCentralStateUnsupported,
    /**
     Bluetooth low energy is not authorised for this application
     */
    AirTurnCentralStateUnauthorized,
    /**
     Bluetooth is powered off
     */
    AirTurnCentralStatePoweredOff,
    /**
     AirTurn Central is disabled
     */
    AirTurnCentralStateDisabled,
    /**
     AirTurn Central is not connected to an AirTurn
     */
    AirTurnCentralStateDisconnected,
    /**
     AirTurn Central is connected
     */
    AirTurnCentralStateConnected
};

/**
 The pairing state between the central and peripheral
 */
typedef NS_ENUM(NSInteger, AirTurnPeripheralPairingState) {
    /**
     There is no pairing between the central and peripheral
     */
    AirTurnPeripheralPairingStateNotPaired,
    /**
     A pairing exists between the central and peripheral
     */
    AirTurnPeripheralPairingStatePaired
};

/**
 A type for analog values
 */
typedef NSInteger AirTurnPortValue;

/**
 The maximum possible analog value
 */
extern const AirTurnPortValue AirTurnPortValueMax;
/**
 The minimum possible analog value
 */
extern const AirTurnPortValue AirTurnPortValueMin;

/**
 Defines the low battery level cut off
 */
extern const NSInteger AirTurnPeripheralLowBatteryLevel;

/**
 A type for App actions. Can be any object which implements NSCopying and NSCoding, such as any property list object: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary
 */
typedef id<NSObject, NSCopying, NSCoding> AirTurnAppAction;
