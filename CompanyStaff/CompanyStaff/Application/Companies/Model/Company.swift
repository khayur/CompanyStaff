//
//  Company.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import Foundation

protocol Companyable: Nameable {
    var employees : [User]? { get }
}

struct Company: Companyable {
    //MARK: -Properties
    var name: String
    var employees: [User]?
    
    //MARK: -Methods
    mutating func changeName(to newName: String) {
        self.name = newName
    }
    
    mutating func addEmployee(_ employee: User) {
        self.employees?.append(employee)
    }
    
    mutating func deleteEmployee(_ employee: User) {
        guard let employees = employees else { return }
        
        if employees.contains(employee) {
            guard let index = employees.firstIndex(of: employee) else { return }
            self.employees?.remove(at: index)
        } else {
#if DEBUG
            print("There is no such employee")
#endif
        }
    }
}
