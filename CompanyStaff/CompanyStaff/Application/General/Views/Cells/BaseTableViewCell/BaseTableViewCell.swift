//
//  BaseTableViewCell.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class BaseTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    //MARK: -Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// Creates empty UIView for cell's background and fills it with color
    /// - Parameter color: color for filling background view
    func setBackgroundForSelectedState(color: UIColor) {
        let backgroundView = UIView()
        backgroundView.backgroundColor = color
        self.selectedBackgroundView = backgroundView
    }
}
