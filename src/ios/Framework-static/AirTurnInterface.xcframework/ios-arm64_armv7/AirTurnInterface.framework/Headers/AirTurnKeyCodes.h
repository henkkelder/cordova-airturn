//
//  AirTurnKeyCodes.h
//  AirTurnInterface
//
//  Created by Nick Brook on 03/09/2014.
//  Copyright (c) 2014 Nick Brook. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Constants defining AirTurn keyboard codes
 */
typedef NS_ENUM(NSInteger, AirTurnKeyCode) {
    /**
     Unknown key code
     */
    AirTurnKeyCodeUnknown = -1,
    /**
     'A' keyboard key
     */
    AirTurnKeyCodeA = 0x04,
    /**
     'B' keyboard key
     */
    AirTurnKeyCodeB = 0x05,
    /**
     'C' keyboard key
     */
    AirTurnKeyCodeC = 0x06,
    /**
     'D' keyboard key
     */
    AirTurnKeyCodeD = 0x07,
    /**
     'E' keyboard key
     */
    AirTurnKeyCodeE = 0x08,
    /**
     'F' keyboard key
     */
    AirTurnKeyCodeF = 0x09,
    /**
     'G' keyboard key
     */
    AirTurnKeyCodeG = 0x0A,
    /**
     'H' keyboard key
     */
    AirTurnKeyCodeH = 0x0B,
    /**
     'I' keyboard key
     */
    AirTurnKeyCodeI = 0x0C,
    /**
     'J' keyboard key
     */
    AirTurnKeyCodeJ = 0x0D,
    /**
     'K' keyboard key
     */
    AirTurnKeyCodeK = 0x0E,
    /**
     'L' keyboard key
     */
    AirTurnKeyCodeL = 0x0F,
    /**
     'M' keyboard key
     */
    AirTurnKeyCodeM = 0x10,
    /**
     'N' keyboard key
     */
    AirTurnKeyCodeN = 0x11,
    /**
     'O' keyboard key
     */
    AirTurnKeyCodeO = 0x12,
    /**
     'P' keyboard key
     */
    AirTurnKeyCodeP = 0x13,
    /**
     'Q' keyboard key
     */
    AirTurnKeyCodeQ = 0x14,
    /**
     'R' keyboard key
     */
    AirTurnKeyCodeR = 0x15,
    /**
     'S' keyboard key
     */
    AirTurnKeyCodeS = 0x16,
    /**
     'T' keyboard key
     */
    AirTurnKeyCodeT = 0x17,
    /**
     'U' keyboard key
     */
    AirTurnKeyCodeU = 0x18,
    /**
     'V' keyboard key
     */
    AirTurnKeyCodeV = 0x19,
    /**
     'W' keyboard key
     */
    AirTurnKeyCodeW = 0x1A,
    /**
     'X' keyboard key
     */
    AirTurnKeyCodeX = 0x1B,
    /**
     'Y' keyboard key
     */
    AirTurnKeyCodeY = 0x1C,
    /**
     'Z' keyboard key
     */
    AirTurnKeyCodeZ = 0x1D,
    /**
     '1' keyboard key
     */
    AirTurnKeyCode1 = 0x1E,
    /**
     '2' keyboard key
     */
    AirTurnKeyCode2 = 0x1F,
    /**
     '3' keyboard key
     */
    AirTurnKeyCode3 = 0x20,
    /**
     '4' keyboard key
     */
    AirTurnKeyCode4 = 0x21,
    /**
     '5' keyboard key
     */
    AirTurnKeyCode5 = 0x22,
    /**
     '6' keyboard key
     */
    AirTurnKeyCode6 = 0x23,
    /**
     '7' keyboard key
     */
    AirTurnKeyCode7 = 0x24,
    /**
     '8' keyboard key
     */
    AirTurnKeyCode8 = 0x25,
    /**
     '9' keyboard key
     */
    AirTurnKeyCode9 = 0x26,
    /**
     '0' keyboard key
     */
    AirTurnKeyCode0 = 0x27,
    /**
     'Backslash' keyboard key
     */
    AirTurnKeyCodeBackslash = 0x31,
    /**
     'NonUSPound' keyboard key
     Non-US # or _
     Typical language mappings: US: \| Belg: μ`£ FrCa: <}> Dan:’* Dutch: <> Fren:*μ
     Ger: #’ Ital: ù§ LatAm: }`] Nor:,* Span: }Ç Swed: ,*
     Swiss: $£ UK: #~.
     */
    AirTurnKeyCodeNonUSPound = 0x32,
    /**
     'Comma' keyboard key
     */
    AirTurnKeyCodeComma = 0x36,
    /**
     'Equal' keyboard key
     */
    AirTurnKeyCodeEqual = 0x2E,
    /**
     'Grave' keyboard key
     */
    AirTurnKeyCodeGrave = 0x35,
    /**
     'Left Bracket' keyboard key
     */
    AirTurnKeyCodeLeftBracket = 0x2F,
    /**
     'Right Bracket' keyboard key
     */
    AirTurnKeyCodeRightBracket = 0x30,
    /**
     'Minus' keyboard key
     */
    AirTurnKeyCodeMinus = 0x2D,
    /**
     'Period' keyboard key
     */
    AirTurnKeyCodePeriod = 0x37,
    /**
     'Quote' keyboard key
     */
    AirTurnKeyCodeQuote = 0x34,
    /**
     'Semicolon' keyboard key
     */
    AirTurnKeyCodeSemicolon = 0x33,
    /**
     'Slash' keyboard key
     */
    AirTurnKeyCodeSlash = 0x38,
    /**
     'Slash' keyboard key
     */
    AirTurnKeyCodeCapsLock = 0x39,
    /**
     'Forward Delete' keyboard key
     */
    AirTurnKeyCodeForwardDelete = 0x4C,
    /**
     'Delete' keyboard key
     */
    AirTurnKeyCodeDelete = 0x2A,
    /**
     'Up Arrow' keyboard key
     */
    AirTurnKeyCodeUpArrow = 0x52,
    /**
     'Right Arrow' keyboard key
     */
    AirTurnKeyCodeRightArrow = 0x4F,
    /**
     'Down Arrow' keyboard key
     */
    AirTurnKeyCodeDownArrow = 0x51,
    /**
     'Left Arrow' keyboard key
     */
    AirTurnKeyCodeLeftArrow = 0x50,
    /**
    'Home' keyboard key
    */
    AirTurnKeyCodeHome = 0x5F,
    /**
    'End' keyboard key
    */
    AirTurnKeyCodeEnd = 0x59,
    /**
     'Page Up' keyboard key
     */
    AirTurnKeyCodePageUp = 0x4B,
    /**
     'Page Down' keyboard key
     */
    AirTurnKeyCodePageDown = 0x4E,
    /**
     'Return' keyboard key
     */
    AirTurnKeyCodeReturn = 0x28,
    /**
     'Escape' keyboard key
     */
    AirTurnKeyCodeEscape = 0x29,
    /**
     'Space' keyboard key
     */
    AirTurnKeyCodeSpace = 0x2C,
    /**
     'Tab' keyboard key
     */
    AirTurnKeyCodeTab = 0x2B,
    /**
     'F1' keyboard key
     */
    AirTurnKeyCodeF1 = 0x3A,
    /**
     'F2' keyboard key
     */
    AirTurnKeyCodeF2 = 0x3B,
    /**
     'F3' keyboard key
     */
    AirTurnKeyCodeF3 = 0x3C,
    /**
     'F4' keyboard key
     */
    AirTurnKeyCodeF4 = 0x3D,
    /**
     'F5' keyboard key
     */
    AirTurnKeyCodeF5 = 0x3E,
    /**
     'F6' keyboard key
     */
    AirTurnKeyCodeF6 = 0x3F,
    /**
     'F7' keyboard key
     */
    AirTurnKeyCodeF7 = 0x40,
    /**
     'F8' keyboard key
     */
    AirTurnKeyCodeF8 = 0x41,
    /**
     'F9' keyboard key
     */
    AirTurnKeyCodeF9 = 0x42,
    /**
     'F10' keyboard key
     */
    AirTurnKeyCodeF10 = 0x43,
    /**
     'F11' keyboard key
     */
    AirTurnKeyCodeF11 = 0x44,
    /**
     'F12' keyboard key
     */
    AirTurnKeyCodeF12 = 0x45,
    /**
     'F13' keyboard key
     */
    AirTurnKeyCodeF13 = 0x68,
    /**
     'F14' keyboard key
     */
    AirTurnKeyCodeF14 = 0x69,
    /**
     'F15' keyboard key
     */
    AirTurnKeyCodeF15 = 0x6A,
    /**
     'F16' keyboard key
     */
    AirTurnKeyCodeF16 = 0x6B,
    /**
     'F17' keyboard key
     */
    AirTurnKeyCodeF17 = 0x6C,
    /**
     'F18' keyboard key
     */
    AirTurnKeyCodeF18 = 0x6D,
    /**
     'F19' keyboard key
     */
    AirTurnKeyCodeF19 = 0x6E,
    /**
     'F20' keyboard key
     */
    AirTurnKeyCodeF20 = 0x6F,
    /**
     'F21' keyboard key
     */
    AirTurnKeyCodeF21 = 0x70,
    /**
     'F22' keyboard key
     */
    AirTurnKeyCodeF22 = 0x71,
    /**
     'F23' keyboard key
     */
    AirTurnKeyCodeF23 = 0x72,
    /**
     'F24' keyboard key
     */
    AirTurnKeyCodeF24 = 0x73,
    /**
     'Print Screen' keyboard key
     */
    AirTurnKeyCodePrintScreen = 0x46,
    /**
     'Scroll lock' keyboard key
     */
    AirTurnKeyCodeScrollLock = 0x47,
    /**
     'Pause' keyboard key
     */
    AirTurnKeyCodePause = 0x48,
    /**
     'Insert' keyboard key
     */
    AirTurnKeyCodeInsert = 0x49,
    /**
     'NonUSBackslash' keyboard key
     On Apple ISO keyboards, this is the section symbol (§/±)
     Typical language mappings: Belg:<\> FrCa:«°» Dan:<\> Dutch:]|[ Fren:<> Ger:<|>
     Ital:<> LatAm:<> Nor:<> Span:<> Swed:<|> Swiss:<\>
     UK:\| Brazil: \|.
     */
    AirTurnKeyCodeNonUSBackslash = 0x64,
    /**
     'Application' keyboard key
     */
    AirTurnKeyCodeApplication = 0x65,
    /**
     'Power' keyboard key
     */
    AirTurnKeyCodePower = 0x66,
    /**
     'Execute' keyboard key
     */
    AirTurnKeyCodeExecute = 0x74,
    /**
     'Help' keyboard key
     */
    AirTurnKeyCodeHelp = 0x75,
    /**
     'Menu' keyboard key
     */
    AirTurnKeyCodeMenu = 0x76,
    /**
     'Select' keyboard key
     */
    AirTurnKeyCodeSelect = 0x77,
    /**
     'Stop' keyboard key
     */
    AirTurnKeyCodeStop = 0x78,
    /**
     'Again' keyboard key
     */
    AirTurnKeyCodeAgain = 0x79,
    /**
     'Undo' keyboard key
     */
    AirTurnKeyCodeUndo = 0x7A,
    /**
     'Cut' keyboard key
     */
    AirTurnKeyCodeCut = 0x7B,
    /**
     'Copy' keyboard key
     */
    AirTurnKeyCodeCopy = 0x7C,
    /**
     'Paste' keyboard key
     */
    AirTurnKeyCodePaste = 0x7D,
    /**
     'Find' keyboard key
     */
    AirTurnKeyCodeFind = 0x7E,
    /**
     'Mute' keyboard key
     */
    AirTurnKeyCodeMute = 0x7F,
    /**
     'Volume Up' keyboard key
     */
    AirTurnKeyCodeVolumeUp = 0x80,
    /**
     'Volume Down' keyboard key
     */
    AirTurnKeyCodeVolumeDown = 0x81,
    /**
     'Locking Caps Lock' keyboard key
     */
    AirTurnKeyCodeLockingCapsLock   = 0x82,
    /**
     'Locking Num Lock' keyboard key
     Implemented as a locking key; sent as a toggle button. Available for legacy support;
        however, most systems should use the non-locking version of this key.
     */
    AirTurnKeyCodeLockingNumLock    = 0x83,
    /**
     'Locking Scroll Lock' keyboard key
     */
    AirTurnKeyCodeLockingScrollLock = 0x84,
    
    /* See the footnotes in the USB specification for what keys these are commonly mapped to.
     * https://www.usb.org/sites/default/files/documents/hut1_12v2.pdf */
    
    /**
     'International1' keyboard key
     */
    AirTurnKeyCodeInternational1 = 0x87,
    /**
     'International2' keyboard key
     */
    AirTurnKeyCodeInternational2 = 0x88,
    /**
     'International3' keyboard key
     */
    AirTurnKeyCodeInternational3 = 0x89,
    /**
     'International4' keyboard key
     */
    AirTurnKeyCodeInternational4 = 0x8A,
    /**
     'International5' keyboard key
     */
    AirTurnKeyCodeInternational5 = 0x8B,
    /**
     'International6' keyboard key
     */
    AirTurnKeyCodeInternational6 = 0x8C,
    /**
     'International7' keyboard key
     */
    AirTurnKeyCodeInternational7 = 0x8D,
    /**
     'International8' keyboard key
     */
    AirTurnKeyCodeInternational8 = 0x8E,
    /**
     'International9' keyboard key
     */
    AirTurnKeyCodeInternational9 = 0x8F,
    /**
     'LANG1' keyboard key
     On Apple keyboard for Japanese, this is the kana switch (かな) key
     On Korean keyboards, this is the Hangul/English toggle key.
     */
    AirTurnKeyCodeLANG1 = 0x90,
    /**
     'LANG2' keyboard key
     On Apple keyboards for Japanese, this is the alphanumeric (英数) key
     On Korean keyboards, this is the Hanja conversion key.
     */
    AirTurnKeyCodeLANG2 = 0x91,
    /**
     'LANG3' keyboard key
     Defines the Katakana key for Japanese USB word-processing keyboards.
     */
    AirTurnKeyCodeLANG3 = 0x92,
    /**
     'LANG4' keyboard key
     Defines the Hiragana key for Japanese USB word-processing keyboards.
     */
    AirTurnKeyCodeLANG4 = 0x93,
    /**
     'LANG5' keyboard key
     Defines the Zenkaku/Hankaku key for Japanese USB word-processing keyboards.
     */
    AirTurnKeyCodeLANG5 = 0x94,
    
    /* LANG6-9: Reserved for language-specific functions, such as Front End Processors and Input Method Editors. */
    
    /**
     'LANG6' keyboard key
     */
    AirTurnKeyCodeLANG6 = 0x95,
    /**
     'LANG7' keyboard key
     */
    AirTurnKeyCodeLANG7 = 0x96,
    /**
     'LANG8' keyboard key
     */
    AirTurnKeyCodeLANG8 = 0x97,
    /**
     'LANG9' keyboard key
     */
    AirTurnKeyCodeLANG9 = 0x98,
    
    
    /**
     'AlternateErase' keyboard key
     */
    AirTurnKeyCodeAlternateErase = 0x99,
    /**
     'SysReq/Attention' keyboard key
     */
    AirTurnKeyCodeSysReqOrAttention = 0x9A,
    /**
     'Cancel' keyboard key
     */
    AirTurnKeyCodeCancel = 0x9B,
    /**
     'Clear' keyboard key
     */
    AirTurnKeyCodeClear = 0x9C,
    /**
     'Prior' keyboard key
     */
    AirTurnKeyCodePrior = 0x9D,
    /**
     'Return' keyboard key
     */
    AirTurnKeyCodeReturn2 = 0x9E,
    /**
     'Separator' keyboard key
     */
    AirTurnKeyCodeSeparator = 0x9F,
    /**
     'Out' keyboard key
     */
    AirTurnKeyCodeOut = 0xA0,
    /**
     'Oper' keyboard key
     */
    AirTurnKeyCodeOper = 0xA1,
    /**
     'Clear/Again' keyboard key
     */
    AirTurnKeyCodeClearOrAgain = 0xA2,
    /**
     'CrSel/Props' keyboard key
     */
    AirTurnKeyCodeCrSelOrProps = 0xA3,
    /**
     'ExSel' keyboard key
     */
    AirTurnKeyCodeExSel = 0xA4,
    
    
    /**
     'Left Control' keyboard key
     */
    AirTurnKeyCodeLeftControl = 0xE0,
    /**
     'Left Shift' keyboard key
     */
    AirTurnKeyCodeLeftShift = 0xE1,
    /**
     'Left Alt' keyboard key
     */
    AirTurnKeyCodeLeftAlt = 0xE2,
    /**
     'Left GUI' keyboard key
     */
    AirTurnKeyCodeLeftGUI = 0xE3,
    /**
     'Right Control' keyboard key
     */
    AirTurnKeyCodeRightControl = 0xE4,
    /**
     'Right Shift' keyboard key
     */
    AirTurnKeyCodeRightShift = 0xE5,
    /**
     'Right Alt' keyboard key
     */
    AirTurnKeyCodeRightAlt = 0xE6,
    /**
     'Right GUI' keyboard key
     */
    AirTurnKeyCodeRightGUI = 0xE7,
    
    
    /**
     'Keypad NumLock or Clear' keyboard key
     */
    AirTurnKeyCodeKeypadNumLock = 0x53,
    /**
     'Keypad /' keyboard key
     */
    AirTurnKeyCodeKeypadSlash = 0x54,
    /**
     'Keypad *' keyboard key
     */
    AirTurnKeyCodeKeypadAsterisk = 0x55,
    /**
     'Keypad -' keyboard key
     */
    AirTurnKeyCodeKeypadHyphen = 0x56,
    /**
     'Keypad +' keyboard key
     */
    AirTurnKeyCodeKeypadPlus = 0x57,
    /**
     'Keypad Enter' keyboard key
     */
    AirTurnKeyCodeKeypadEnter = 0x58,
    /**
     'Keypad 1 or End' keyboard key
     */
    AirTurnKeyCodeKeypad1 = 0x59,
    /**
     'Keypad 2 or Down Arrow' keyboard key
     */
    AirTurnKeyCodeKeypad2 = 0x5A,
    /**
     'Keypad 3 or Page Down' keyboard key
     */
    AirTurnKeyCodeKeypad3 = 0x5B,
    /**
     'Keypad 4 or Left Arrow' keyboard key
     */
    AirTurnKeyCodeKeypad4 = 0x5C,
    /**
     'Keypad 5' keyboard key
     */
    AirTurnKeyCodeKeypad5 = 0x5D,
    /**
     'Keypad 6 or Right Arrow' keyboard key
     */
    AirTurnKeyCodeKeypad6 = 0x5E,
    /**
     'Keypad 7 or Home' keyboard key
     */
    AirTurnKeyCodeKeypad7 = 0x5F,
    /**
     'Keypad 8 or Up Arrow' keyboard key
     */
    AirTurnKeyCodeKeypad8 = 0x60,
    /**
     'Keypad 9 or Page Up' keyboard key
     */
    AirTurnKeyCodeKeypad9 = 0x61,
    /**
     'Keypad 0 or Insert' keyboard key
     */
    AirTurnKeyCodeKeypad0 = 0x62,
    /**
     'Keypad . or Delete' keyboard key
     */
    AirTurnKeyCodeKeypadPeriod = 0x63,
    /**
     'Keypad =' keyboard key
     */
    AirTurnKeyCodeKeypadEqualSign = 0x67,
    /**
     'Keypad ,' keyboard key
     */
    AirTurnKeyCodeKeypadComma = 0x85,
    /**
     'Keypad =' keyboard key
     For AS/400
     */
    AirTurnKeyCodeKeypadEqualSignAS400 = 0x86,
};
