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

    @IBOutlet weak var addCompanyButton: UIButton!
    
    //MARK: - Properties
    var model: CompaniesDataBase?
    var newCompanyView: NewCompanyView!
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: -Helper Methods
    private func configureViewController() {
        configureTableView()
        fillModelWithData()
    }
    
    private func configureTableView() {
        companiesTableView.delegate = self
        companiesTableView.dataSource = self
        companiesTableView.register(CompanyTableViewCell.self)
    }
    
    private func fillModelWithData() {
        fillCompaniesDataBase()
        model = companiesDataBase
        companiesTableView.reloadData()
    }
    
    private func createNewCompanyView() {
        newCompanyView = NewCompanyView.instantiate()
        newCompanyView.controller = self
        newCompanyView.configure()
        newCompanyView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        self.view.addSubview(newCompanyView)
    }
    
    //MARK: -Actions
    @IBAction func didPressAddCompanyButton(_ sender: Any) {
       createNewCompanyView()
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
        vc.model = getUsers(at: indexPath)?.sorted(by: { $0.age > $1.age })
        vc.companyName = model?.companies?[indexPath.row].name
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CompaniesViewController: CompanyStaffDataSource {
    func getUsers(at indexPath: IndexPath) -> [User]? {
            return model?.companies?[indexPath.row].employees
    }
}

