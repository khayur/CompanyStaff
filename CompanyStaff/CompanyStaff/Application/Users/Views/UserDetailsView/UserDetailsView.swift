//
//  UserDetails.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class UserDetailsView: BaseView {
    
//MARK: -Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    //MARK: -Properties
    var controller: UsersViewController?
    var indexPath: IndexPath?
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
        guard let controller = self.controller,
              let users = controller.model?.users,
              let indexPath = self.indexPath else { return }
        
        let modelItem = users[indexPath.row]
        self.nameLabel.text = modelItem.name
        self.ageLabel.text = String(modelItem.age)
        self.sexLabel.text = modelItem.sex.rawValue
        self.companyNameLabel.text = modelItem.company?.name ?? "Unemployed"
        
        self.layer.zPosition = 3
        self.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.applyShadow(corner: 15, opacity: 0.5, shadow: 15)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
//MARK: -Actions
    @IBAction func didPressCloseButton(_ sender: Any) {
        self.removeFromSuperview(animated: true)
        
        if let superview = superview?.viewWithTag(Constants.tagForOverlayView) {
            superview.removeFromSuperview()
        }
    }
}
