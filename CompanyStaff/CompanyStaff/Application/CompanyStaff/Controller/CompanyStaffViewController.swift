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
    var newCompanyEmployeeView: NewCompanyEmployeeView!
    
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
    
    private func createNewCompanyEmployeeView() {
        newCompanyEmployeeView = NewCompanyEmployeeView.instantiate()
        newCompanyEmployeeView.configure()
        newCompanyEmployeeView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        newCompanyEmployeeView.applyShadow(corner: 4)
        
        guard let companyName = companyName else { return }
        newCompanyEmployeeView.companyNameLabel.text = companyName
        self.view.addSubview(newCompanyEmployeeView)
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
    
    //MARK: -Actions
    @IBAction func didPressAddNewUserButton(_ sender: Any) {
        createNewCompanyEmployeeView()
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
        }
    }
}

extension CompanyStaffViewController: AgeChangerDelegate {
    func changeAge(of user: User, to newAge: Int) {
        user.changeAge(to: newAge)
    }
}
