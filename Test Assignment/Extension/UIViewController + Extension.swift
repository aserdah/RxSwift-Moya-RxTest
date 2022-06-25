//
//  UIViewController + Extension.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 25/06/2022.
//

import Foundation
import UIKit
import MBProgressHUD


extension UIViewController {
    func showIndicator() {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.isUserInteractionEnabled = false
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
    }
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }

}
