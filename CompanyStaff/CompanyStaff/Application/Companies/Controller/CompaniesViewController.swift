//
//  CompaniesViewController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 4.01.22.
//

import UIKit

class CompaniesViewController: BaseViewController {
    //MARK: -Outlets
    @IBOutlet weak var companiesTableView: UITableView! {
        didSet {
            companiesTableView.delegate = self
            companiesTableView.dataSource = self
            companiesTableView.register(CompanyTableViewCell.self)
        }
    }
    
    @IBOutlet weak var addCompanyButton: UIButton!
    
    //MARK: - Properties
    var model: CompaniesDataBase?
    var newCompanyView: NewCompanyView!
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: -Helper Methods
    private func configureViewController() {
        fillModelWithData()
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
    
    //MARK: -EASTER EGG :)
    private func setDobbiesFree(from company: Company) {
        guard let users = usersDataBase.users else { return }
        for user in users {
            if user.company?.name == company.name {
                user.company = nil
                print(user)
            }
        }
    }
    
    func isCompanyUnique(company name: String) -> Bool {
        guard let companies = model?.companies else { return true }
        var answer = true
        for company in companies {
            if company.name == name {
                answer = false
            }
        }
        return answer
    }
    
    //MARK: -Actions
    @IBAction func didPressAddCompanyButton(_ sender: Any) {
        createNewCompanyView()
    }
}

//MARK: -Extensions
extension CompaniesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.companies?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CompanyTableViewCell
        configureCell(cell: cell, at: indexPath)
        return cell
    }
    
    private func configureCell(cell: CompanyTableViewCell, at indexPath: IndexPath) {
            guard let companies = model?.companies else { return }
            cell.companyLabel.text = companies[indexPath.row].name
            cell.setBackgroundForSelectedState(color: Constants.appSupportingColor)
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

extension CompaniesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.companyStaff.instantiateViewController(withIdentifier: typeName(CompanyStaffViewController.self)) as? CompanyStaffViewController else { fatalError() }
        vc.model = getUsers(at: indexPath)
        vc.companyName = model?.companies?[indexPath.row].name
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let company = model?.companies?[indexPath.row] else { return }
        if editingStyle == .delete {
            model?.companies?.remove(at: indexPath.row)
            setDobbiesFree(from: company)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension CompaniesViewController: CompanyStaffDataSource {
    func getUsers(at indexPath: IndexPath) -> [User]? {
        return model?.companies?[indexPath.row].employees
    }
}

