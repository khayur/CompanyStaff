//
//  UserDetails.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class UserDetailsView: UIView, NibLoadableView {
//MARK: -Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    //MARK: -Properties
    var width: CGFloat {
        let rootViewController =  UIApplication.shared.windows.first!.rootViewController
        guard let rootViewWidth = rootViewController?.view.bounds.width else {return 200}
        return rootViewWidth / 1.5
    }
    var height: CGFloat {
        return width
    }
    
    //MARK: -Methods
    func configure() {
        self.backgroundColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1)
        self.layer.zPosition = 3
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.applyShadow(corner: 15, opacity: 0.5, shadow: 15)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
//MARK: -Actions
    @IBAction func didPressCloseButton(_ sender: Any) {
        self.removeFromSuperview()
    }
}
