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
    var employees: [User]? = []
    
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
        print(employee)
        self.employees?.append(employee)
        print(self.employees)
    }
    
    //    mutating func deleteEmployee(_ employee: User) {
    //        guard let employees = employees else { return }
    //            if employees.contains(where: { employee in
    //                for employee in employees {
    //                    if employee.name == employee.name {
    //                        return true
    //                    }
    //                    return false
    //                }
    //            }) {
    //            guard let index = employees.firstIndex(of: employee) else { return }
    //            self.employees?.remove(at: index)
    //        } else {
    //#if DEBUG
    //            print("There is no such employee")
    //#endif
    //        }
    //    }
}
