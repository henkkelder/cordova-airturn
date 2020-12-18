//
//  AirTurnManager.h
//  AirTurnInterface
//
//  Created by Nick Brook on 27/02/2014.
//  Copyright (c) 2014 Nick Brook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AirTurnInterface/AirTurnCentral.h>
#import <AirTurnInterface/AirTurnViewManager.h>
#import <AirTurnInterface/ARCHelper.h>
#import <AirTurnInterface/AirTurnTypes.h>
#import <AirTurnInterface/AirTurnCoalesced.h>

/**
 The overall HID + BTLE manager for AirTurn
 */
@interface AirTurnManager : NSObject

/**
 A coalesced representation of all connected AirTurns
 */
@property(nonatomic, readonly, nonnull) AirTurnCoalesced *coalescedAirTurn;

/**
 The version of AirTurnInterface SDK
 */
@property(nonatomic, readonly, nonnull) NSString *version;

/**
 `YES` if an AirTurn is connected
 */
@property(nonatomic, readonly) BOOL isConnected __attribute__((deprecated("Use the coalesced AirTurn instead", "coalescedAirTurn.isConnected")));

/**
 The AirTurn AirDirect central
 */
@property(ah_weak_delegate, nonatomic, readonly, nullable) AirTurnCentral *central;

/**
 The AirTurn View manager (detects keyboard-based AirTurn events)
 */
@property(ah_weak_delegate, nonatomic, readonly, nullable) AirTurnViewManager *viewManager;

/**
 The shared manager, use this to get the shared `AirTurnManager` object
 
 @return The shared `AirTurnManager` object
 */
+ (nonnull AirTurnManager *)sharedManager;

/**
 A set of digital app actions which are available to be assigned to AirTurn inputs
 */
@property(nonatomic, strong, nullable) NSSet<AirTurnAppAction> *digitalAppActions;

/**
 A dictionary of `AirTurnPort` to app action identifier mappings to use as the default for new devices
 */
@property(nonatomic, strong, nullable) NSDictionary<NSNumber *, AirTurnAppAction> *digitalAppActionDefaultMapping;

/**
 A set of analog app actions which are available to be assigned to AirTurn inputs
 */
@property(nonatomic, strong, nullable) NSSet<AirTurnAppAction> *analogAppActions;

@end
