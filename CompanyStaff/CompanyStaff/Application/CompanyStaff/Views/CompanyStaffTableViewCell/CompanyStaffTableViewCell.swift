//
//  CompanyStaffTableViewCell.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 4.01.22.
//

import UIKit

class CompanyStaffTableViewCell: BaseTableViewCell {
    //MARK: -Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageStepper: UIStepper!
    
    //MARK: -Properties
    
    weak var ageChanger: AgeChangerDelegate?
    var modelItem: User?
    
    //MARK: -Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//TODO: Think about fields, guard for the maximum value of stepper and user's age
    func configure() {
        nameLabel.text = modelItem?.name
        ageLabel.text = String(modelItem?.age ?? 0)
        ageStepper.value = Double(modelItem?.age ?? 0)
        ageStepper.autorepeat = false
        ageStepper.maximumValue = 120
    }
    
    //MARK: -Actions
    @IBAction func didPressAgeStepper() {
        ageChanger?.changeAge(of: modelItem!, to: Int(ageStepper.value))
        ageLabel.text = String(modelItem?.age ?? 0)
    }
}
