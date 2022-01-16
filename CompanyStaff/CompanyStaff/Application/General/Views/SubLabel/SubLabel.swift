//
//  SubLabel.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 16.01.22.
//

import UIKit

class SubLabel: UILabel {

    override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            // This will call `awakeFromNib` in your code
            setup()
        }
        
        private func setup() {
            self.textColor = Constants.appFontSubColor
        }
}
