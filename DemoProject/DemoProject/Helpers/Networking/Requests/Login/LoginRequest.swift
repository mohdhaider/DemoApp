//
//  SearchRequest.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

enum LoginRequest {
    case login(username: String, password: String)
}

extension LoginRequest : RequestInfo {
    var httpType: HTTPType {
        return .post
    }
    
    var requestURL: URL {
        
        guard let url = URL(string: Apis.loginApiUrl.rawValue) else { fatalError("Unable to configure url") }
        return url
    }
    
    var requestType: RequestFeature {
        
        let headers =  Parameters()
        var bodyParams =  Parameters()
        let urlParams =  Parameters()
        
        switch self {
        case .login(let username, let password):
            bodyParams["email"] = username
            bodyParams["password"] = password
        }
        
        return .requestWithParameters(encoding: .jsonEncoding, urlParameters: urlParams, bodyParameters: bodyParams, headers: headers)
    }
}
