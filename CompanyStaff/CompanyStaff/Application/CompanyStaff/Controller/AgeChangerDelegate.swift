//
//  AgeChangerDelegate.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 5.01.22.
//

import Foundation

protocol AgeChangerDelegate: AnyObject {
    func changeAge(of user: User, to newAge: Int)
}
