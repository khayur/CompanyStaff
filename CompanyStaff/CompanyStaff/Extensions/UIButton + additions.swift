//
//  UIButton + additions.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 16.01.22.
//

import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        layer.add(pulse, forKey: nil)
    }
}
