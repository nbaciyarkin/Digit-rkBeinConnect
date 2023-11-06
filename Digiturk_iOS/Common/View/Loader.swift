//
//  Loader.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 1.11.2023.
//

import Foundation
import UIKit

fileprivate let viewTag = 14531453

final class Loader {
    
    class func show(_ customView: UIView? = nil, color: UIColor = Colors.black) {
        let bgView = UIView()
        let loadingIndicator = UIActivityIndicatorView()
        
        loadingIndicator.style = .whiteLarge
        loadingIndicator.color = .blue
        var view = UIView()
        if let customView = customView {
            view = customView
        } else {
            if let window = UIApplication.shared.keyWindow {
                view = window
            }
        }
        
        if view.viewWithTag(viewTag) == nil {
            bgView.frame = view.frame
            bgView.tag = viewTag
            bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            loadingIndicator.frame = CGRect(x: (view.frame.width / 2) - 25, y: (view.frame.height / 2) - 25, width: 50, height: 50)
            
            DispatchQueue.main.async {
                loadingIndicator.startAnimating()
                bgView.addSubview(loadingIndicator)
                view.addSubview(bgView)
            }
        }
    }
    
    class func hide(_ customView: UIView? = nil) {
        var view = UIView()
        if let customView = customView {
            view = customView
        } else {
            if let window = UIApplication.shared.keyWindow {
                view = window
            }
        }
        DispatchQueue.main.async {
            view.viewWithTag(viewTag)?.removeFromSuperview()
        }
    }
}
