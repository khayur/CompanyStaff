//
//  NewCompanyEmployeeView.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 6.01.22.
//

import UIKit

class NewCompanyEmployeeView: BaseView, OptionsView {
    
//MARK: -Outlets
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView! {
        didSet {
            menuTableView.delegate = self
            menuTableView.dataSource = self
            menuTableView.register(NewCompanyEmployeeTableViewCell.self)
        }
    }
    @IBOutlet weak var closeViewButton: UIButton!
    
    //MARK: -Properties
    static var optionsViewName = typeName(self)
    let numberOfRowsInSection = 1
    var menuOptions = ["Add existing unemployed user (soon)", "Add new user"]
    var newUserView: NewUserView!
    var controller: CompanyStaffViewController?
    
    
    //MARK: -Methods
    func configure() {
        guard let controller = controller,
              let companyName = controller.companyName else { return }
        
        self.companyNameLabel.text = companyName
    
        
        self.frame = CGRect(x: 0, y: 0,
                            width: controller.view.bounds.width - 50,
                            height: controller.view.bounds.height / 3)
        self.center = controller.view.center
        self.applyShadow(corner: 15, opacity: 0.5, shadow: 15)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        closeViewButton.backgroundColor = Constants.appButtonsColor
        closeViewButton.layer.cornerRadius = closeViewButton.frame.height / 2
        closeViewButton.tintColor = .white
    }
    
    //MARK: -Actions
    @IBAction func didPressCloseViewButton(_ sender: Any) {
        closeViewButton.pulsate()
        self.removeFromSuperview(animated: true)
        if let superview = superview?.viewWithTag(Constants.tagForOverlayView) {
            superview.removeFromSuperview()
        }
        
    }
}

//MARK: -Extensions
extension NewCompanyEmployeeView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NewCompanyEmployeeTableViewCell
        configureCell(cell: cell, at: indexPath)
        return cell
    }
    
    private func configureCell(cell: NewCompanyEmployeeTableViewCell, at indexPath: IndexPath) {
        cell.menuOptionLabel.text = menuOptions[indexPath.section]
        cell.setBackgroundForSelectedState(color: Constants.appSupportingColor)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 10))
            view.backgroundColor = .white
            return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    
}

extension NewCompanyEmployeeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1  {
            controller?.showOptionsView(as: NewUserView.self)
        }
    }
}
