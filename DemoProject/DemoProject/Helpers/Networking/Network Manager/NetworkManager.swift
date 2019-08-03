//
//  NetworkManager.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    func performLogin(_ interactor:NetworkInteractor<LoginRequest>,_ info: LoginRequest, completionBlock: @escaping NetworkRequestCompletion) {
        
        interactor.request(info) { (data, response, error) in
            
            completionBlock(data, response, error)
        }
    }
}
