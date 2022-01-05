//
//  CompanyStaffViewController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 4.01.22.
//

import UIKit

class CompanyStaffViewController: BaseViewController, ModelDataSource {
    
//MARK: -Outlets

    @IBOutlet weak var companyStaffTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //MARK: -Properties
    var model: [User]?
    var companyName: String?
    var dataSource: CompanyStaffDataSource?
    
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
            titleLabel.text = "Staff of \(companyName)"
            } else {
                titleLabel.text = "\(companyName) has no staff"
            }
        } else {
            titleLabel.text = "Error"
        }
        
        configureTableView()
    }
    
    private func configureTableView() {
        companyStaffTableView.delegate = self
        companyStaffTableView.dataSource = self
        companyStaffTableView.register(CompanyStaffTableViewCell.self)
    }
    
    private func configureCell(cell: CompanyStaffTableViewCell, at indexPath: IndexPath) {
        guard let user = model?[indexPath.row] else { return }
        cell.ageChanger = self
        cell.modelItem = user
        cell.configure()
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
    
}

extension CompanyStaffViewController: AgeChangerDelegate {
    func changeAge(of user: User, to newAge: Int) {
        user.changeAge(to: newAge)
    }
}
