//
//  Define.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

enum Apis: String {
    case loginApiUrl = "https://reqres.in/api/login"
    case detailsApiUrl = "https://mckinleyrice.com"
}

enum AppErrors: String, Error {
    case screenNotAvailable
}
