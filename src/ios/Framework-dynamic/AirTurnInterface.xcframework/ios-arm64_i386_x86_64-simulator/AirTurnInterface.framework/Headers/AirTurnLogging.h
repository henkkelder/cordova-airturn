//
//  AirTurnLogging.h
//  AirTurnInterface
//
//  Created by Nick Brook on 19/06/2015.
//  Copyright © 2015 Nick Brook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 AirTurn Log Flags
 */
typedef NS_OPTIONS(NSInteger, AirTurnLogFlag){
    /**
     Error log flag
     */
    AirTurnLogFlagError      =(1 << 0),
    /**
     Warning log flag
     */
    AirTurnLogFlagWarning    =(1 << 1),
    /**
     Info log flag
     */
    AirTurnLogFlagInfo       =(1 << 2),
    /**
     Debug log flag
     */
    AirTurnLogFlagDebug      =(1 << 3),
    /**
     Verbose log flag
     */
    AirTurnLogFlagVerbose    =(1 << 4),
};

/**
 AirTurn Log level masks
 */
typedef NS_ENUM(NSInteger, AirTurnLogLevel){
    /**
     No logging
     */
    AirTurnLogLevelOff       = 0,
    /**
     Error logging
     */
    AirTurnLogLevelError     =(AirTurnLogFlagError),
    /**
     Warning and error logging
     */
    AirTurnLogLevelWarning   =(AirTurnLogLevelError   | AirTurnLogFlagWarning),
    /**
     Info, warning and error logging
     */
    AirTurnLogLevelInfo      =(AirTurnLogLevelWarning | AirTurnLogFlagInfo),
    /**
     Debug, info, warning and error logging
     */
    AirTurnLogLevelDebug     =(AirTurnLogLevelInfo    | AirTurnLogFlagDebug),
    /**
     Verbose, debug, info, warning and error logging
     */
    AirTurnLogLevelVerbose   =(AirTurnLogLevelDebug   | AirTurnLogFlagVerbose),
    /**
     All logging
     */
    AirTurnLogLevelAll       = AirTurnLogLevelVerbose
};

@protocol AirTurnLoggingDelegate;

/**
 AirTurn Logging Class
 */
@interface AirTurnLogging : NSObject

/**
 Set a delegate to be passed log messages
 */
@property(class, nonatomic, weak, nullable) id<AirTurnLoggingDelegate> delegate;

/**
 Set the framework logging level. Only logs this severe or more will be logged.
 */
@property(class, nonatomic, assign) AirTurnLogLevel frameworkLogLevel;

/**
 This class is not designed to be initialized.

 @return None
 */
- (nonnull instancetype)init NS_UNAVAILABLE;

@end

/**
 The delegate for the `AirTurnLogging` class
 */
@protocol AirTurnLoggingDelegate <NSObject>

@required

/**
 The log delegate method. Called for every log item emitted from `AirTurnInterface` for your application to handle

 @param asynchronous If the log should be processed asynchronously
 @param level The log level
 @param flag The log flag
 @param context The log context
 @param file The file the log was sent from
 @param function The function the log was sent from
 @param line The line of code the log was sent from
 @param tag The log tag
 @param message The log message
 */
- (void)AirTurnLog:(BOOL)asynchronous
             level:(AirTurnLogLevel)level
              flag:(AirTurnLogFlag)flag
           context:(NSInteger)context
              file:(NSString * _Nonnull)file
          function:(NSString * _Nonnull)function
              line:(NSUInteger)line
               tag:(nullable id)tag
           message:(NSString * _Nonnull)message;

@end
