//
//  UINavigationController+Additions.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 5.01.22.
//

import UIKit

enum NavigationStyle {
    case common
    case big
}

extension UINavigationBar {
    func setup(barColor: UIColor?) {
        if let color = barColor {
            barTintColor = color
            tintColor = .white
            backgroundColor = color
            shadowImage = UIImage()
            isTranslucent = false
        } else {
            setBackgroundImage(UIImage(), for: .default)
            shadowImage = UIImage()
            isTranslucent = true
        }
        titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0)]
        largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 34.0),
                                        NSAttributedString.Key.foregroundColor: UIColor.white]

    }
}
