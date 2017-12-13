//
//  ViewController.swift
//  KDeviceTest
//
//  Created by ksnowlv on 2017/12/13.
//  Copyright © 2017年 ksnowlv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        print("KDevice uuid=：\(KDevice.deviceUUID()) idfa = \(KDevice.idfaString()) model = \(KDevice.deviceModel()) size = \(KDevice.screenSize()) sizeType = \(KDevice.screenSizeType())")
        print("appUIScale = \(KDevice.appUIScale()) appUIScaleForWidth = \(KDevice.appUIScaleForWidth()) appUIScaleForSinglePixel = \(KDevice.appUIScaleForSinglePixel())");
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

