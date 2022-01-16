//
//  NewCompanyEmployeeTableViewCell.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 6.01.22.
//

import UIKit

class NewCompanyEmployeeTableViewCell: BaseTableViewCell {
//MARK: -Outlets
    @IBOutlet weak var menuOptionLabel: UILabel!
    @IBOutlet weak var chevronButton: UIButton!
    
//MARK: -Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        chevronButton.backgroundColor = Constants.appButtonsColor
        chevronButton.layer.cornerRadius = chevronButton.frame.height / 2
        chevronButton.tintColor = .white
    }
}
