//
//  UsersViewController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class UsersViewController: BaseViewController {
    //MARK: -Outlets
    @IBOutlet weak var usersTableView: UITableView!
    
    //MARK: -Properties
    private var userDetailsView: UserDetailsView!
    private var model: UsersDataBase?
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        fillModelWithData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usersTableView.reloadData()
    }
    
    //MARK: -HelperMethods
    
    private func configureViewController() {
        
    }
    
    private func configureTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.register(UserTableViewCell.self)
    }
    
    private func fillModelWithData() {
        fillUsersDataBase()
        model = usersDataBase
        usersTableView.reloadData()
    }
}

//MARK: -Extensions
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let users = model?.users else { return 1 }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let users = model?.users else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as UserTableViewCell
        let modelItem = users[indexPath.row]
        cell.userNameLabel.text = modelItem.name
        cell.companyNameLabel.text = modelItem.company?.name ?? "Unemployed"
        return cell
    }
}

//TODO: Restrict user interaction with table view while detailsView is presenting
extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userDetailsView = UserDetailsView.instantiate()
        userDetailsView.configure()
        guard let users = model?.users else { return }
        let modelItem = users[indexPath.row]
        userDetailsView.nameLabel.text = modelItem.name
        userDetailsView.ageLabel.text = String(modelItem.age)
        userDetailsView.sexLabel.text = modelItem.sex.rawValue
        userDetailsView.companyNameLabel.text = modelItem.company?.name ?? "Unemployed"
        userDetailsView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(userDetailsView)
    }
}
