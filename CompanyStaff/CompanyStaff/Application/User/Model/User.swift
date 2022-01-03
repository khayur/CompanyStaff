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

protocol Humanable {
    var name: String { get }
    var age: Int { get }
    var sex: Sex { get }
}

protocol Workable {
    var companyName: String? { get set }
}
struct User: Humanable, Workable {
    
    //MARK: - Properties
    var name: String
    var age: Int
    var sex: Sex
    var companyName: String?
    
    //MARK: - Methods
    mutating func changeName(to newName: String) {
        self.name = newName
    }
    
    mutating func changeAge(to newAge: Int) {
        self.age = newAge
    }
    
    mutating func decreaseAge(by number: Int) {
        self.age -= number
    }
    
    mutating func increaseAge(by number: Int) {
        self.age += number
    }
    
    mutating func changeSex(to newSex: Sex) {
        self.sex = newSex
    }
    
    mutating func setCompany(to company: String) {
        self.companyName = company
    }
}
