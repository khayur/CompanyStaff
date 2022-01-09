//
//  UsersDataBase.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 4.01.22.
//

import Foundation

class UsersDataBase {
    //MARK: -Properties
    static var shared = UsersDataBase()
    var users: [User]?
    
    private init() {
        self.users = []
    }
    //MARK: -Methods
    func addUser(_ user: User) {
        self.users?.append(user)
        synchronizeWithCompaniesDataBase(for: user)
    }
    
    func addUsers(_ users: [User]) {
        self.users?.append(contentsOf: users)
        for user in users {
            synchronizeWithCompaniesDataBase(for: user)
        }
    }
    
    private func synchronizeWithCompaniesDataBase(for user: User){
        guard let companies = companiesDataBase.companies,
              let userCompanyName = user.company?.name
        else { return }
        for company in companies {
            if userCompanyName  == company.name {
                company.addEmployee(user)
            }
        }
    }
}

var usersDataBase = UsersDataBase.shared
var user1 = User(name: "Yury", age: 25, sex: .male, company: company1)
var user2 = User(name: "Bob", age: 32, sex: .male, company: company2)
var user3 = User(name: "Alice", age: 29, sex: .female, company: company3)
var user4 = User(name: "John", age: 20, sex: .male, company: company4)

//MARK: -Filling users database
func fillUsersDataBase() {
    usersDataBase.addUsers([user1, user2, user3, user4])
    usersDataBase.addUser(User(name: "Kate", age: 47, sex: .female, company: company5))
    usersDataBase.addUser(User(name: "Peter", age: 14, sex: .male, company: company6))
    usersDataBase.addUser(User(name: "Joanna", age: 18, sex: .female, company: company7))
    usersDataBase.addUser(User(name: "Bruce", age: 39, sex: .male, company: company9))
    usersDataBase.addUser(User(name: "Thanos", age: 58, sex: .male, company: company8))
    usersDataBase.addUser(User(name: "Susanna", age: 23, sex: .female, company: company3))
    usersDataBase.addUser(User(name: "Dzmitro", age: 24, sex: .male, company: company1))
    usersDataBase.addUser(User(name: "Michal", age: 32, sex: .male, company: company1))
    usersDataBase.addUser(User(name: "Marya", age: 23, sex: .female, company: company3))
    usersDataBase.addUser(User(name: "Ihar", age: 35, sex: .male, company: company5))
    usersDataBase.addUser(User(name: "Hanna", age: 59, sex: .female, company: company7))
    usersDataBase.addUser(User(name: "Snow Soldier", age: 39, sex: .male, company: company8))
    usersDataBase.addUser(User(name: "Angelina", age: 43, sex: .female, company: company9))
    usersDataBase.addUser(User(name: "Paulina", age: 31, sex: .female, company: company5))
}
