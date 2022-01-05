//
//  ModelDelegate.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 5.01.22.
//

import Foundation

protocol CompanyStaffDataSource: AnyObject {
    func getUsers(at indexPath: IndexPath) -> [User]?
}
