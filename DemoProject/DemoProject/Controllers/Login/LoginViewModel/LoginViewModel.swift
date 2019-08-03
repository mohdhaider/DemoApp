//
//  LoginViewModel.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

final class LoginViewModel: NSObject {

    // MARK:- Variables -
    
    var showActivityIndicator = DataObserver<Bool>(false)
    
    private let interactor: NetworkInteractor<LoginRequest> = NetworkInteractor()
    
    private let networkManager = NetworkManager()
    
    // MARK:- Initializers -
    
    override init() {
        super.init()
    }
    
    // MARK:- Helpers -
    
    func performLoginApi(forUsername username:String?, forPassword password:String?) throws {
        
        guard let username: String = username, !username.isEmpty else {
            throw LoginError.usrnameNotAvailable
        }
        guard let password: String = password, !password.isEmpty else {
            throw LoginError.passwordNotAvailable
        }
        
        showActivityIndicator.value = true
        
        networkManager.performLogin(interactor, .login(username: username, password: password)) {[weak self] (data, response, error) in
            
            //print(data as Any)
            //print(response as Any)
            //print(error as Any)
            
            do {
                if let dataAvail = data {
                    let json = try JSONSerialization.jsonObject(with: dataAvail, options: .allowFragments)
                    
                    if let jsonDict = json as? Parameters{
                        
                        print("jsonDict = \(jsonDict)")
                        
                    }
                }
            } catch {
                print("error = \(error)")
            }
            
            self?.showActivityIndicator.value = false
        }
    }
}

enum LoginError: String, Error {
    
    case usrnameNotAvailable = "Please enter email Id."
    case passwordNotAvailable = "Please enter password."
}
