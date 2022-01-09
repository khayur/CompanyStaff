//
//  CompanyStaffViewController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 4.01.22.
//

import UIKit

class CompanyStaffViewController: BaseViewController, ModelDataSource {
    
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
    var dataSource: CompanyStaffDataSource?
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
    private func configureCell(cell: CompanyStaffTableViewCell, at indexPath: IndexPath) {
        guard let user = model?[indexPath.row] else { return }
        cell.ageChanger = self
        cell.modelItem = user
        cell.configure()
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
        newCompanyEmployeeView = NewCompanyEmployeeView.instantiate()
        newCompanyEmployeeView.configure()
        

        newCompanyEmployeeView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        newCompanyEmployeeView.applyShadow(corner: 4)
        
        guard let companyName = companyName else { return }
        newCompanyEmployeeView.companyNameLabel.text = companyName
        newCompanyEmployeeView.controller = self
        self.view.addSubview(newCompanyEmployeeView)
    }
    
    private func createNewUserView() {
        newUserView = NewUserView.instantiate()
        newUserView.controller = self
        newUserView.companyName = self.companyName
        newUserView.configure()
        newUserView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        newUserView.applyShadow(corner: 4)
        newUserView.frame = CGRect(x: 50, y: 100, width: self.view.frame.width - 100, height: self.view.frame.height - 500)
        self.view.addSubview(newUserView)
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
        guard let companies = companiesDataBase.companies else { fatalError() }
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
        guard let rows = model?.count else { return 1 }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CompanyStaffTableViewCell
        configureCell(cell: cell, at: indexPath)
        return cell
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
