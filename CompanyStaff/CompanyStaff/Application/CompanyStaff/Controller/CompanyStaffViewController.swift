//
//  CompanyStaffViewController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 4.01.22.
//

import UIKit

class CompanyStaffViewController: BaseViewController {
    
    //MARK: -Outlets
    
    @IBOutlet weak var companyStaffTableView: UITableView! {
        didSet {
            companyStaffTableView.delegate = self
            companyStaffTableView.dataSource = self
            companyStaffTableView.register(CompanyStaffTableViewCell.self)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addNewUserButton: UIButton!
    
    
    //MARK: -Properties
    var model: [User]?
    var companyName: String?
    var optionsView: OptionsView!
    var newCompanyEmployeeView: NewCompanyEmployeeView!
    var newUserView: NewUserView!
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: -Helper Methods
    private func configureViewController() {
        configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        if let companyName = companyName {
            if let model = model, !model.isEmpty {
                titleLabel.text = "Staff of '\(companyName)'"
            } else {
                titleLabel.text = "'\(companyName)' has no staff"
            }
        } else {
            titleLabel.text = "Error"
        }
    }
    
    func showOptionsView(as type: OptionsView.Type) {
        switch type {
        case is NewCompanyEmployeeView.Type :
            createNewCompanyEmployeeView()
        case is NewUserView.Type :
            createNewUserView()
        default:
            return
        }
    }
    
    private func createNewCompanyEmployeeView() {
        let overlayView = getOverlayView()
        view.addSubview(overlayView)
        
        newCompanyEmployeeView = NewCompanyEmployeeView.instantiate()
        newCompanyEmployeeView.controller = self
        newCompanyEmployeeView.tag = 222
        newCompanyEmployeeView.configure()
        
        if let taggedView = view.viewWithTag(222) {
            taggedView.removeFromSuperview()
            overlayView.addSubview(newCompanyEmployeeView)
        } else {
           overlayView.addSubview(newCompanyEmployeeView)
        }
    }
    
    private func createNewUserView() {
        let overlayView = getOverlayView()
        view.addSubview(overlayView)
        
        newUserView = NewUserView.instantiate()
        newUserView.controller = self
        newUserView.tag = 333
        newUserView.configure()
        
        if let taggedView = view.viewWithTag(333) {
            taggedView.removeFromSuperview()
            overlayView.addSubview(newUserView)
        } else {
            overlayView.addSubview(newUserView)
        }
    }
    
    private func fireEmployee(_ user: User) {
        guard let companies = companiesDataBase.companies else { return }
        for company in companies {
            if user.company?.name == company.name {
                company.deleteEmployee(user)
            }
        }
        user.company = nil
    }
    
    func getCompany(named companyName: String) -> Company? {
        guard let companies = companiesDataBase.companies else { return nil }
        for company in companies {
            if company.name == companyName {
                return company
            }
        }
        return nil
    }
    
    func updateModel() {
        guard let companyName = companyName else { return }
        let company = getCompany(named: companyName)
        self.model = company?.employees
        configureTitleLabel()
    }
    
    //MARK: -Actions
    @IBAction func didPressAddNewUserButton(_ sender: Any) {
        showOptionsView(as: NewCompanyEmployeeView.self)
    }
}

//MARK: -Extensions

extension CompanyStaffViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CompanyStaffTableViewCell
        configureCell(cell: cell, at: indexPath)
        return cell
    }
    
    private func configureCell(cell: CompanyStaffTableViewCell, at indexPath: IndexPath) {
        guard let user = model?[indexPath.row] else { return }
        cell.ageChanger = self
        cell.modelItem = user
        cell.configure()
        cell.setBackgroundForSelectedState(color: Constants.appMainColor)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: Constants.animationDuration, animations: { cell.alpha = 1 })
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
}

extension CompanyStaffViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let user = model?[indexPath.row] else { return }
        if editingStyle == .delete {
            model?.remove(at: indexPath.row)
            fireEmployee(user)
            user.company = nil
            tableView.deleteRows(at: [indexPath], with: .fade)
            configureTitleLabel()
        }
    }
}

extension CompanyStaffViewController: AgeChangerDelegate {
    func changeAge(of user: User, to newAge: Int) {
        user.changeAge(to: newAge)
    }
}
