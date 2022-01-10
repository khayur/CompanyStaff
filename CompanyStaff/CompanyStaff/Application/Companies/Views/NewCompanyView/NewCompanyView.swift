//
//  NewCompanyView.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 6.01.22.
//

import UIKit

class NewCompanyView: UIView, NibLoadableView {
    //MARK: -Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: -Properties
    var controller: CompaniesViewController?
    
    //MARK: -Methods
    func configure() {
        self.applyShadow(corner: 15, opacity: 0.5, shadow: 15)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        errorLabel.isHidden = true
    }
    
    private func isEnteredDataCorrect() -> Bool {
        errorLabel.isHidden = true
        
        if nameTextField.text == "" {
            errorLabel.text = getErrorLabelText(forCode: 1)
            errorLabel.isHidden = false
            return false
        }
        
        if let companyName = nameTextField.text,
           let controller = controller,
           !controller.isCompanyUnique(company: companyName) {
            errorLabel.text = getErrorLabelText(forCode: 4)
            errorLabel.isHidden = false
            return false
        }
        
        return true
    }
    
    //MARK: -Actions
    @IBAction func didPressCancelButton() {
        self.removeFromSuperview()
    }
    
    @IBAction func didPressAddButton() {
        if let companyName = nameTextField.text,
           isEnteredDataCorrect() {
            companiesDataBase.addCompany(Company(name: companyName, employees: []))
            controller?.companiesTableView.reloadData()
            self.removeFromSuperview()
        }
    }
}
