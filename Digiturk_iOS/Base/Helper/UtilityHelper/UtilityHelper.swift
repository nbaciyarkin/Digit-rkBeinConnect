//
//  UtilityHelper.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 5.11.2023.
//

import Foundation
import UIKit
class UtilityHelper {
    static let  shared = UtilityHelper()
    
    func isPad() -> Bool{
        return UIDevice.current.userInterfaceIdiom == .pad ? true : false
    }
}
