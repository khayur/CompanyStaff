//
//  User.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import Foundation

enum Sex: String {
    case male
    case female
}
protocol Nameable {
    var name: String { get }
}

protocol Humanable: Nameable {
    var age: Int { get }
    var sex: Sex { get }
}

protocol Workable {
    var company: Company? { get set }
}

class User: Humanable, Workable {
    
    //MARK: - Properties
    var name: String
    var age: Int
    var sex: Sex
    var company: Company?
    
    //MARK: -Initializers
    init(name: String,
         age: Int,
         sex: Sex,
         company: Company?
    ) {
        self.name = name
        self.age = age
        self.sex = sex
        self.company = company
    }
    
    //MARK: - Methods
     func changeName(to newName: String) {
        self.name = newName
    }
    
     func changeAge(to newAge: Int) {
        self.age = newAge
    }
    
     func changeSex(to newSex: Sex) {
        self.sex = newSex
    }
    
     func setCompany(to company: inout Company) {
        self.company = company
        company.addEmployee(self)
    }
}


