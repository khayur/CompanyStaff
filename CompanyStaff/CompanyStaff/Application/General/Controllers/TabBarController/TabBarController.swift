//
//  TabBarController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class TabBarController: UITabBarController {
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
            return viewControllers?.last?.preferredStatusBarStyle ?? .lightContent
        }

    //MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()

            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light
            }
            self.tabBar.backgroundColor = color
            view.backgroundColor = color
        }
}
