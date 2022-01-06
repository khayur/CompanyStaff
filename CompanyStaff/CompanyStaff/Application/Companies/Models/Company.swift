//
//  Company.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import Foundation

protocol Companyable: Nameable {
    var employees: [User]? { get }
}

class Company: Companyable {
    //MARK: -Properties
    var name: String
    var employees: [User]? {
        didSet {
            self.employees = employees?.sorted(by: { $0.age > $1.age })
        }
    }
    
    //MARK: -Initializers
    init(name: String,
         employees: [User]?
    ) {
        self.name = name
        
        if employees == nil {
            self.employees = []
        } else {
            self.employees = employees
        }
    }
    
    //MARK: -Methods
    func changeName(to newName: String) {
        self.name = newName
    }
    
    func addEmployee(_ employee: User) {
        self.employees?.append(employee)
    }
    
    func deleteEmployee(_ employee: User) {
        guard let employees = employees,
        !employees.isEmpty
        else { return }
        
        let index = employees.firstIndex { user in
            for (_, element) in employees.enumerated() {
                if  user.name == element.name {
                    return true
                }
            }
            return false
        }
        
        guard let index = index else {
            return
        }
        
        self.employees?.remove(at: index)

    }
}
