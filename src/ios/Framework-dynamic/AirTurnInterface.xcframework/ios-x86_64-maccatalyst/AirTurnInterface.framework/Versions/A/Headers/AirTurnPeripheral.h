//
//  AirTurnPeripheral.h
//  AirTurnInterface
//
//  Created by Nick Brook on 27/02/2014.
//  Copyright (c) 2014 Nick Brook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AirTurnInterface/AirTurnTypes.h>
#import <AirTurnInterface/AirTurnError.h>
#import <AirTurnInterface/ARCHelper.h>
#import <AirTurnInterface/AirTurnDeviceProtocol.h>
#import <AirTurnInterface/EDSemver.h>

/**
 Represents one AirTurn peripheral
 */
@interface AirTurnPeripheral : NSObject <AirTurnDeviceProtocol>

/**
 A peripheral that coalesces all connected peripherals
 */
@property(class, nonatomic, readonly, nonnull) AirTurnPeripheral *coalesced;

#pragma mark Peripheral State

/**
 The current state of the peripheral
 */
@property(nonatomic, readonly) AirTurnConnectionState  state;

/**
 The type of connected device
 */
@property(nonatomic, readonly) AirTurnDeviceType deviceType;

/**
 The type of inputs this device has
 */
@property(nonatomic, readonly) AirTurnInputType inputType;

/**
 The order the ports are arranged physically on the device
 */
@property(nonatomic, readonly, nonnull) NSArray<NSNumber *> *physicalDigitalPortOrder;

/**
 The user-readable model name of the device
 */
@property(nonatomic, readonly, nonnull) NSString * model;

/**
 YES if the last connection attempt to the device failed
 */
@property(nonatomic, readonly) BOOL lastConnectionFailed;

/**
 Indicates if the peripheral has bonding, probably to another device. Can't connect to it if it does (unless the system connects automatically for us).
 */
@property(nonatomic, assign) BOOL hasBonding;

/**
 `YES` if pairing failed
 */
@property(nonatomic, readonly) BOOL pairingFailed;


#pragma mark - Peripheral Values
/**
 A unique identifier for this device
 */
@property(nonatomic, readonly, nonnull) NSString *identifier;

/**
 The name of the peripheral
 */
@property(nonatomic, readonly, nullable) NSString * name;

/**
 The default name of the peripheral
 */
@property(nonatomic, readonly, nullable) NSString * defaultName;

/**
 The firmware version of the peripheral
 */
@property(nonatomic, readonly, nullable) EDSemver * firmwareVersion;

/**
 The previous firmware version of the peripheral when it was last connected
 */
@property(nonatomic, readonly, nullable) EDSemver * previousFirmwareVersion;

/**
 The hardware version of the peripheral
 */
@property(nonatomic, readonly, nullable) EDSemver * hardwareVersion;

/**
 The current mode of this AirTurn
 */
@property(nonatomic, readonly) AirTurnMode currentMode;

/**
 The number of modes on this AirTurn
 */
@property(nonatomic, readonly) NSInteger numberOfModes;

/**
 The number of digital ports available on this AirTurn
 */
@property(nonatomic, readonly) NSInteger numberOfDigitalPortsAvailable;

/**
 The number of analog ports available on this AirTurn
 */
@property(nonatomic, readonly) NSInteger numberOfAnalogPortsAvailable;

/**
 The peripheral battery level, a percentage 0-100%
 */
@property(nonatomic, readonly) NSInteger batteryLevel;

/**
 The peripheral charging state
 */
@property(nonatomic, readonly) AirTurnPeripheralChargingState chargingState;

/**
 The peripheral's configured OEM
 */
@property(nonatomic, readonly, nullable) NSString * OEM;

/**
 The features for a given mode on this Airturn
 
 @param mode The mode
 @return The features available on the specified mode
 */
- (AirTurnModeFeatures)featuresForMode:(AirTurnMode)mode;

/**
 Indicates if a specific digital port is available
 
 @param port The port
 @return YES if the port is available
 */
- (BOOL)digitalPortAvailable:(AirTurnPort)port;

/**
 Indicates if a specific analog port is available
 
 @param port The port
 @return YES if the port is available
 */
- (BOOL)analogPortAvailable:(AirTurnPort)port;

/**
 Get the port state for a given port.
 @param port The port
 @return The port state
 */
- (AirTurnPortState)digitalPortState:(AirTurnPort)port;

/**
 Get the value for the port.
 
 @param port The port
 @return The current analog value. This value is between 0 and UINT8_MAX, and is the analog value scaled between its calibrated min and max.
 */
- (AirTurnPortValue)analogPortValue:(AirTurnPort)port;

#pragma mark - Firmware updates

/**
 Check for a firmware update for this AirTurn
 
 @param callback Called back on result. YES if an update is available.
 */
- (void)checkForFirmwareUpdate:(void (^_Nonnull)(EDSemver * _Nullable newVersion))callback;

@end
