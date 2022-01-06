//
//  NewCompanyEmployeeView.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 6.01.22.
//

import UIKit

class NewCompanyEmployeeView: UIView, NibLoadableView {
    
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
    let numberOfRowsInSection = 1
    var menuOptions = ["Add existing unemployed user", "Add new user"]
    
    //MARK: -Methods
    func configure() {
        
    }
    
    //MARK: -Actions
    @IBAction func didPressCloseViewButton(_ sender: Any) {
        self.removeFromSuperview()
    }
    
}

extension NewCompanyEmployeeView: UITableViewDelegate {
    
}

extension NewCompanyEmployeeView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as NewCompanyEmployeeTableViewCell
        cell.menuOptionLabel.text = menuOptions[indexPath.section]
        return cell
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
