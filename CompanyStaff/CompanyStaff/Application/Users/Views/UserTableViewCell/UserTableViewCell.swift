//
//  UserTableViewCell.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class UserTableViewCell: BaseTableViewCell {
    //MARK: -Outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    //MARK: -Properties
    
    //MARK: -Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        userNameLabel.textColor = Constants.appFontMainColor
        companyNameLabel.textColor = Constants.appFontSubColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
