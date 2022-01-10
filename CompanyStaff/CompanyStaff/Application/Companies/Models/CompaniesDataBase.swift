//
//  CompaniesDataBase.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 4.01.22.
//

import Foundation

class CompaniesDataBase {
    //MARK: -Properties
    static var shared = CompaniesDataBase()
    var companies: [Company]?
    
    private init() {
        self.companies = []
    }
    
    //MARK: -Methods
    func addCompany(_ company: Company) {
        self.companies?.append(company)
    }
    
    func addCompanies(_ companies: [Company]) {
        self.companies?.append(contentsOf: companies)
    }
}

var companiesDataBase = CompaniesDataBase.shared
var company1 = Company(name: "Stadler", employees: nil)
var company2 = Company(name: "TMS", employees: nil)
var company3 = Company(name: "A1", employees: nil)
var company4 = Company(name: "United Company", employees: nil)
var company5 = Company(name: "Hard Choice", employees: nil)
var company6 = Company(name: "School of St. Patrick", employees: nil)
var company7 = Company(name: "Belarusian State Unifersity of Informatics and Radioelectronics", employees: nil)
var company8 = Company(name: "Avengers killers", employees: nil)
var company9 = Company(name: "Hollywood Stars", employees: nil)

//MARK: -Filling companies database
func fillCompaniesDataBase() {
    companiesDataBase.addCompanies([company1, company2, company3, company4, company5, company6, company7, company8, company9])
    guard let users = usersDataBase.users,
          let companies = companiesDataBase.companies
    else { return }

    //TODO: make identifiers for users and companies
    for user in users {
        for company in companies {
            if user.company?.name == company.name {
                company.addEmployee(user)
                print(company.name)
            }
        }
    }
}
