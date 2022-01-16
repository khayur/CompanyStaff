//
//  UsersViewController.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

class UsersViewController: BaseViewController {
    //MARK: -Outlets
    @IBOutlet weak var usersTableView: UITableView! {
        didSet {
            usersTableView.delegate = self
            usersTableView.dataSource = self
            usersTableView.register(UserTableViewCell.self)
        }
    }
    
    //MARK: -Properties
    private var userDetailsView: UserDetailsView!
    var model: UsersDataBase?
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usersTableView.reloadData()
    }
    
    //MARK: -HelperMethods
    private func configureViewController() {
        fillModelWithData()
    }
    
    private func fillModelWithData() {
        fillUsersDataBase()
        model = usersDataBase
        usersTableView.reloadData()
    }
    
    private func createUserDetailsView(for indexPath: IndexPath) {
       
        let overlayView = getOverlayView()
        view.addSubview(overlayView)
        
        userDetailsView = UserDetailsView.instantiate()
        userDetailsView.controller = self
        userDetailsView.indexPath = indexPath
        userDetailsView.configure()
        userDetailsView.tag = 111
        userDetailsView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        if let taggedView = view.viewWithTag(111) {
            taggedView.removeFromSuperview()
            overlayView.addSubview(userDetailsView)
        } else {
            overlayView.addSubview(userDetailsView)
        }
    }

}

//MARK: -Extensions
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.users?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as UserTableViewCell
        configureCell(cell: cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: Constants.animationDuration, animations: { cell.alpha = 1 })
        
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: Constants.animationDuration, animations: {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setHighlighted(true, animated: true)
        return true
    }
    
    private func configureCell(cell: UserTableViewCell, at indexPath: IndexPath) {
        guard let users = model?.users else { return }
        let modelItem = users[indexPath.row]
        cell.userNameLabel.text = modelItem.name
        cell.companyNameLabel.text = modelItem.company?.name ?? "Unemployed"
        cell.setBackgroundForSelectedState(color: Constants.appMainColor)
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        createUserDetailsView(for: indexPath)
    }
}
