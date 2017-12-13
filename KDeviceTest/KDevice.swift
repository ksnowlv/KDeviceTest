//
//  KDevice.swift
//  KDeviceTest
//
//  Created by ksnowlv on 2017/12/13.
//  Copyright © 2017年 ksnowlv. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import AdSupport

class KDevice{
    
    public enum KDeviceScreenSizeType :Int {
        case none
        case iPhone4s
        case iPhone5s
        case iPhone6
        case iPhone6Plus
        case iPhoneX
    }
    
    private let KUUIDKey = "KUuidKey"
    private let KDeviceScreenSize4S:CGSize = CGSize(width: 320, height: 480)
    private let KDeviceScreenSize5S:CGSize = CGSize(width: 320, height: 568)
    private let KDeviceScreenSize6:CGSize = CGSize(width: 375, height: 668)
    private let KDeviceScreenSize6Plus:CGSize = CGSize(width: 414, height: 736)
    private let KDeviceScreenSizeX:CGSize = CGSize(width: 375, height: 812)
    
    private static var sharedDevice = KDevice()
    private var uuid:String!
    private var deviceScreenSize:CGSize!
    private var deviceScreenSizeType:KDeviceScreenSizeType!
    private var uiScale:CGFloat!
    private var uiScaleForWidth:CGFloat!
    private var uiScaleForSinglePixel:CGFloat!
    
    public static func deviceUUID() ->String{
        return sharedDevice.uuid
    }
    
    public static func deviceModel() ->String {
        return sharedDevice.model()
    }
    
    public static func deviceName() ->String {
        return  UIDevice.current.name
    }
    
    public static func systemVersion() ->String {
        return UIDevice.current.systemName
    }
    
    public static func idfaString() ->String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    public static func screenSize() ->CGSize {
        return sharedDevice.deviceScreenSize
    }
    
    public static func screenSizeType() ->KDeviceScreenSizeType {
        return sharedDevice.deviceScreenSizeType
    }
    
    public static func appUIScale() ->CGFloat {
        return sharedDevice.uiScale
    }
    
    public static func appUIScaleForWidth() -> CGFloat {
        return sharedDevice.uiScaleForWidth
    }
    
    public static func appUIScaleForSinglePixel()->CGFloat {
        return sharedDevice.uiScaleForSinglePixel
    }
    
    
    init() {
        self.setUpDeviceUUID()
        self.setupDeviceInfo()
    }
    
    private func setUpDeviceUUID() -> Void {
        let userDefault = UserDefaults.standard
        let uuid:String? = userDefault.string(forKey:KUUIDKey)
        if uuid != nil && uuid!.count > 0 {
            self.uuid = uuid!
        }else{
            
            let uuidOjbect = CFUUIDCreate(nil)
            let uuidString = (String)(CFUUIDCreateString(nil, uuidOjbect))
            self.uuid = uuidString
            userDefault.set(uuidString, forKey: KUUIDKey)
            userDefault.synchronize()
        }
    }
    
    func setupDeviceInfo() -> Void {
        self.deviceScreenSize = UIScreen.main.bounds.size
        
        if __CGSizeEqualToSize(self.deviceScreenSize, KDeviceScreenSize4S) {
            self.deviceScreenSizeType = KDeviceScreenSizeType.iPhone4s
        }else if __CGSizeEqualToSize(self.deviceScreenSize, KDeviceScreenSize5S) {
            self.deviceScreenSizeType = KDeviceScreenSizeType.iPhone5s
        }else if __CGSizeEqualToSize(self.deviceScreenSize, KDeviceScreenSize6) {
            self.deviceScreenSizeType = KDeviceScreenSizeType.iPhone6
        }else if __CGSizeEqualToSize(self.deviceScreenSize, KDeviceScreenSize6Plus) {
            self.deviceScreenSizeType = KDeviceScreenSizeType.iPhone6Plus
        }else if __CGSizeEqualToSize(self.deviceScreenSize, KDeviceScreenSizeX) {
            self.deviceScreenSizeType = KDeviceScreenSizeType.iPhoneX
        }
        
        self.uiScale = deviceScreenSize.height/667.0
        self.uiScaleForWidth = deviceScreenSize.width/375.0
        self.uiScaleForSinglePixel = 1.0/UIScreen.main.scale
    }
    
    private func model()->String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") {
            identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch (5 Gen)"
        case "iPod7,1":   return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":   return "iPhone 5"
        case  "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":   return "国行、日版、港行iPhone 7"
        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
        case "iPhone9,3":  return "美版、台版iPhone 7"
        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
            
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":   return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":   return "Apple TV 4"
        case "i386", "x86_64":   return "Simulator"
        default:  return identifier
        }
    }
}
