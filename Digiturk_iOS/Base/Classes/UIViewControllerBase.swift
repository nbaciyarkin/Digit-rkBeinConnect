//
//  UIViewControllerBase.swift
//  Digiturk_iOS
//
//  Created by Yarkın Gazibaba on 5.11.2023.
//

import UIKit
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        navigationController?.setNavigationBarHidden(true, animated: false)
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
    }
}
