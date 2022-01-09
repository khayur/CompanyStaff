//
//  ErrorLabelText.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 9.01.22.
//

import Foundation

func getErrorLabelText(forCode error: Int) -> String {
    switch error {
    case 1:
        return "Fill in all fields"
    case 2:
        return "Age must contain only numbers"
    case 3:
        return "Choose sex"
    case 4:
        return "This company already exists"
    default:
        return "Unknown error"
    }
}
