//
//  NavigationController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 5.01.22.
//

import UIKit

class NavigationController: UINavigationController {
    //MARK: - Variables
        @IBInspectable var color: UIColor?

        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return [.portrait]
        }

        override var shouldAutorotate: Bool {
            return false
        }
        
        override var modalPresentationStyle: UIModalPresentationStyle {
            get {
                return .fullScreen
            }
            set {}
        }

        override var preferredStatusBarStyle: UIStatusBarStyle {
            return viewControllers.last?.preferredStatusBarStyle ?? .lightContent
        }

    //MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
            }

            navigationBar.setup(barColor: color)
            view.backgroundColor = color
        }
}
