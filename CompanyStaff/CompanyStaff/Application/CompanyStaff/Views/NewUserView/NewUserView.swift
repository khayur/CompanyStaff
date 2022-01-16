//
//  NewUserView.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 7.01.22.
//

import UIKit
import DropDown

class NewUserView: UIView, NibLoadableView {
    //MARK: -Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var donebutton: UIButton!
    @IBOutlet weak var chooseSexButton: UIButton!
    @IBOutlet weak var warningStackView: UIStackView!
    
    //MARK: -Properties
    var controller: CompanyStaffViewController?
    let circleImage = UIImage(named: "circle")
    let circleFillImage = UIImage(named: "circle.fill")
    let sexDropDown = DropDown()
    var sex: Sex?
    var companyName: String?
    
    //MARK: -Methods
    func configure() {
        self.frame = CGRect(x: 50, y: 20, width: 200, height: 300)
        setupChooseSexButton()
        warningStackView.isHidden = true
        ageTextField.keyboardType = .numberPad
    }
    
    func isEnteredDataCorrect() -> Bool {
        warningStackView.isHidden = true
        nameTextField.backgroundColor = .white
        ageTextField.backgroundColor = .white
        
        if nameTextField.text == "" {
            errorLabel.text = getErrorLabelText(forCode: 1)
            warningStackView.isHidden = false
            nameTextField.backgroundColor = .red.withAlphaComponent(0.2)
            return false
        }
        
        if ageTextField.text == "" {
            errorLabel.text = getErrorLabelText(forCode: 1)
            warningStackView.isHidden = false
            ageTextField.backgroundColor = .red.withAlphaComponent(0.2)
            return false
        }
        
        if Int(ageTextField.text!) == nil {
            errorLabel.text = getErrorLabelText(forCode: 2)
            warningStackView.isHidden = false
            ageTextField.backgroundColor = .red.withAlphaComponent(0.2)
            return false
        }
        
        if chooseSexButton.titleLabel?.text == "Choose sex" {
            chooseSexButton.titleLabel?.textColor = .red
            errorLabel.text = getErrorLabelText(forCode: 3)
            warningStackView.isHidden = false
            return false
        }
        
        return true
    }
    //MARK: -Actions
    @IBAction func didPressCancelButton(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBAction func didPressDoneButton(_ sender: Any) {
        guard isEnteredDataCorrect(),
              let userName = nameTextField.text,
              let age = Int(ageTextField.text!),
              let sex = sex,
              let companyName = companyName,
              let company = controller?.getCompany(named: companyName)
        else { return }
        let newUser = User(name: userName, age: age, sex: sex, company: company)
        usersDataBase.addUser(newUser)
        controller?.updateModel()
        controller?.companyStaffTableView.reloadData()
        self.removeFromSuperview()
    }
    
    @IBAction func didPressChooseSexButton(_ sender: Any) {
        sexDropDown.show()
    }
    
    func setupChooseSexButton() {
        sexDropDown.anchorView = chooseSexButton
        sexDropDown.bottomOffset = CGPoint(x: 0, y: chooseSexButton.bounds.height)
        sexDropDown.dataSource = Sex.allCases.map { $0.rawValue }
        sexDropDown.selectionAction = { [weak self] (index, item) in
            self?.chooseSexButton.setTitle(item, for: .normal)
            if item == "male" {
                self?.sex = .male
            } else {
                self?.sex = .female
            }
        }
    }
}

//MARK: -Extensions
extension NewUserView: OptionsView {
    static var optionsViewName: String {
        return typeName(self)
    }
}
