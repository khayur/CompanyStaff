//
//  BaseView.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class BaseView: UIView, NibLoadableView {
    
    //MARK: -Methods
    
    /// Posibillity of animated view removing from its superview
    /// - Parameter animated: animate removing or not
    func removeFromSuperview(animated: Bool) {
        if animated {
            UIView.animate(withDuration: Constants.animationDuration, animations: {
                self.alpha = 0
            }) { _ in
                self.removeFromSuperview()
            }
        } else {
            self.removeFromSuperview()
        }
    }
}
