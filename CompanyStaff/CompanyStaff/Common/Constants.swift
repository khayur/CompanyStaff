//
//  Constants.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

struct Constants {
    static let animationDuration = 0.25
    static let appMainColor: UIColor = UIColor(red: 117/255.0, green: 117/255.0, blue: 255/255.0, alpha: 0.72)
    static let tagForOverlayView = 1234
}

/// Converting type's name to String
/// - Parameter some: Type that will be converted to String
/// - Returns: String value of parameter's name
func typeName(_ some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}
