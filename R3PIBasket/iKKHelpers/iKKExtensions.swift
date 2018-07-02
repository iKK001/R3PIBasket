//
//  iKKExtensions.swift
//  R3PIBasket
//
//  Created by Stephan Korner on 03.05.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation
import UIKit

public enum Devices: String {
    case IPodTouch5
    case IPodTouch6
    case IPhone4
    case IPhone4S
    case IPhone5
    case IPhone5C
    case IPhone5S
    case IPhone6
    case IPhone6Plus
    case IPhone6S
    case IPhone6SPlus
    case IPhone7
    case IPhone7Plus
    case IPhoneSE
    case IPhone8
    case IPhone8Plus
    case IPhoneX
    case IPad2
    case IPad3
    case IPad4
    case IPad5
    case IPadAir
    case IPadAir2
    case IPadMini
    case IPadMini2
    case IPadMini3
    case IPadMini4
    case IPadPro_9_7
    case IPadPro_12_9
    case IPadPro_12_9_2ndGen
    case IPadPro_10_5
    case AppleTV_5_3
    case AppleTV_6_2
    case HomePod
    case Simulator
    case Other
}

public extension UIDevice {
    
    public var modelName: Devices {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return self.getDeviceFromIdentifier(identifier: identifier)
    }
    
    public var simulatorModelName: Devices {
        
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return getDeviceFromIdentifier(identifier: simulatorModelIdentifier) }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return getDeviceFromIdentifier(identifier: String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters))
    }
    
    private func getDeviceFromIdentifier(identifier: String) -> Devices {
        switch identifier {
        case "iPod5,1":                                 return Devices.IPodTouch5
        case "iPod7,1":                                 return Devices.IPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return Devices.IPhone4
        case "iPhone4,1":                               return Devices.IPhone4S
        case "iPhone5,1", "iPhone5,2":                  return Devices.IPhone5
        case "iPhone5,3", "iPhone5,4":                  return Devices.IPhone5C
        case "iPhone6,1", "iPhone6,2":                  return Devices.IPhone5S
        case "iPhone7,2":                               return Devices.IPhone6
        case "iPhone7,1":                               return Devices.IPhone6Plus
        case "iPhone8,1":                               return Devices.IPhone6S
        case "iPhone8,2":                               return Devices.IPhone6SPlus
        case "iPhone9,1", "iPhone9,3":                  return Devices.IPhone7
        case "iPhone9,2", "iPhone9,4":                  return Devices.IPhone7Plus
        case "iPhone8,4":                               return Devices.IPhoneSE
        case "iPhone10,1", "iPhone10,4":                return Devices.IPhone8
        case "iPhone10,2", "iPhone10,5":                return Devices.IPhone8Plus
        case "iPhone10,3", "iPhone10,6":                return Devices.IPhoneX
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return Devices.IPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return Devices.IPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return Devices.IPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           return Devices.IPadAir
        case "iPad5,3", "iPad5,4":                      return Devices.IPadAir2
        case "iPad6,11", "iPad6,12":                    return Devices.IPad5
        case "iPad2,5", "iPad2,6", "iPad2,7":           return Devices.IPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return Devices.IPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return Devices.IPadMini3
        case "iPad5,1", "iPad5,2":                      return Devices.IPadMini4
        case "iPad6,3", "iPad6,4":                      return Devices.IPadPro_9_7
        case "iPad6,7", "iPad6,8":                      return Devices.IPadPro_12_9
        case "iPad7,1", "iPad7,2":                      return Devices.IPadPro_12_9_2ndGen
        case "iPad7,3", "iPad7,4":                      return Devices.IPadPro_10_5
        case "AppleTV5,3":                              return Devices.AppleTV_5_3
        case "AppleTV6,2":                              return Devices.AppleTV_6_2
        case "AudioAccessory1,1":                       return Devices.HomePod
        case "i386", "x86_64":                          return Devices.Simulator
        default:                                        return Devices.Other
        }
    }
}

extension String {
    
    // Returns true if the string represents a proper numeric value.
    // This method uses the device's current locale setting to determine
    // which decimal separator it will accept.
    func isNumeric() -> Bool
    {
        let scanner = Scanner(string: self)
        
        // A newly-created scanner has no locale by default.
        // We'll set our scanner's locale to the user's locale
        // so that it recognizes the decimal separator that
        // the user expects (for example, in North America,
        // "." is the decimal separator, while in many parts
        // of Europe, "," is used).
        scanner.locale = NSLocale.current
        
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
}
