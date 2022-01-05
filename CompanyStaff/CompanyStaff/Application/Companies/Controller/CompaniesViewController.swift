//
//  CompaniesViewController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 4.01.22.
//

import UIKit

class CompaniesViewController: BaseViewController {
    //MARK: -Outlets
    @IBOutlet weak var companiesTableView: UITableView!
    
    //MARK: - Properties
    var model: CompaniesDataBase?
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: -Helper Methods
    func configureViewController() {
        configureTableView()
        fillModelWithData()
    }
    
    func configureTableView() {
        companiesTableView.delegate = self
        companiesTableView.dataSource = self
        companiesTableView.register(CompanyTableViewCell.self)
    }
    
    func fillModelWithData() {
        fillCompaniesDataBase()
        model = companiesDataBase
        companiesTableView.reloadData()
    }
}

//MARK: -Extensions
extension CompaniesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let companies = model?.companies else { return 1 }
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let companies = model?.companies else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CompanyTableViewCell
        cell.companyLabel.text = companies[indexPath.row].name
        return cell
    }
}

extension CompaniesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.companyStaff.instantiateViewController(withIdentifier: typeName(CompanyStaffViewController.self)) as? CompanyStaffViewController else { fatalError() }
        self.tabBarController?.tabBar.isHidden = true
        vc.model = getUsers(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CompaniesViewController: CompanyStaffDataSource {
    func getUsers(at indexPath: IndexPath) -> [User]? {
            return model?.companies?[indexPath.row].employees
    }
}

