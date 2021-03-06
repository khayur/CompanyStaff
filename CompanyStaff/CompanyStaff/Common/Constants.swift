//
//  Constants.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 3.01.22.
//

import UIKit

struct Constants {
    static let animationDuration = 0.25
    static let appMainColor = UIColor(red: 117/255.0, green: 117/255.0, blue: 255/255.0, alpha: 1)
    static let appFontMainColor = UIColor(red: 40/255.0, green: 40/255.0, blue: 45/255.0, alpha: 1)
    static let appFontSubColor = UIColor(red: 97/255.0, green: 92/255.0, blue: 97/255.0, alpha: 1)
    static let appSupportingColor = UIColor(red: 240/255.0, green: 238/255.0, blue: 233/255.0, alpha: 1)
//    static let appButtonsColor = UIColor(red: 208/255.0, green: 151/255.0, blue: 134/255.0, alpha: 0.5)
    static let appButtonsColor = appMainColor.withAlphaComponent(0.7)
    static let tagForOverlayView = 1234
}

/// Converting type's name to String
/// - Parameter some: Type that will be converted to String
/// - Returns: String value of parameter's name
func typeName(_ some: Any) -> String {
    return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
}
