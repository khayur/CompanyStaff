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
        
        if #available(iOS 15.0, *) {
            overrideUserInterfaceStyle = .light
        }
        //            color = .red
        //            self.tabBar.backgroundColor = color
        //            view.backgroundColor = color
        //            self.tabBar.scrollEdgeAppearance =
        design()
    }
    //MARK: -Helper Methods
    
    private func design() {
//        color = Constants.appMainColor
        let appearanceOfTabBar = UITabBarAppearance()
        appearanceOfTabBar.configureWithOpaqueBackground()
        appearanceOfTabBar.backgroundColor = color
        
        self.tabBar.standardAppearance = appearanceOfTabBar
        self.tabBar.scrollEdgeAppearance = appearanceOfTabBar
        self.tabBar.plainView.tintColor = .white
    }
}
