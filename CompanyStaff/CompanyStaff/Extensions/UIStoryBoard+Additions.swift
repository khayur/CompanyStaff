//
//  UIStoryBoard+Additions.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit.UIStoryboard

enum StoryboardType: String {
    case companyStaff = "CompanyStaff"
}

extension UIStoryboard {

    static let companyStaff = UIStoryboard(.companyStaff)

    convenience init(_ type: StoryboardType) {
        self.init(name: type.rawValue, bundle: nil)
    }

    func instantiate<T>(identifier: String = "") -> T {
        let identifier = identifier.isEmpty ? typeName(T.self) : identifier
        guard let controller = instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError()
        }

        return controller
    }

}
