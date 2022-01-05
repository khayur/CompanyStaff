//
//  ModelDataSource.swift
//  CompanyStaff
//
//  Created by Yury Khadatovich on 5.01.22.
//

import Foundation

protocol ModelDataSource {
    var dataSource: CompanyStaffDataSource? { get set }
}
