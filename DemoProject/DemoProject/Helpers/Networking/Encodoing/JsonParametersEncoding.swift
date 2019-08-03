//
//  JsonParametersEncoding.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

struct JsonParametersEncoding: EncodingProtocol {
    
    func encode(_ request: inout URLRequest, parameters: Parameters) throws {
        
        guard let _ = request.url else { throw ParametersEncodingErrors.urlNotAvailable }
        
        do {
            let jsonObj = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonObj
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            throw ParametersEncodingErrors.jsonEncodingFailed
        }
    }
}
