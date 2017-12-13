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
    
    public static func deviceUUID()->String{
        return sharedDevice.uuid
    }
    
    public static func idfaString()->String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    public static func screenSize() ->CGSize {
        return sharedDevice.deviceScreenSize
    }
    
    public static func screenSizeType() ->KDeviceScreenSizeType {
        return sharedDevice.deviceScreenSizeType
    }
    
    public static func appUIScale()->CGFloat {
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

}
