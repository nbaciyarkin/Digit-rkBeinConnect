//
//  Extension+UIApplication.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 5.11.2023.
//

import Foundation
import UIKit
extension UIApplication {
    static var kWindow : UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication
                .shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        }
    }
}
