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
    
    var isAccessTokenGeneretd = DataObserver<Bool>(false)
    
    var errorInfo = DataObserver<String>("")
    
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
            
            self?.showActivityIndicator.value = false
            
            do {
                if let dataAvail = data {
                    let json = try JSONSerialization.jsonObject(with: dataAvail, options: .allowFragments)
                    
                    if let jsonDict = json as? Parameters {
                        
                        if let accessToken:String = jsonDict["token"] as? String,
                            !accessToken.isEmpty {
                            
                            print("jsonDict = \(jsonDict)")
                            
                            let isSaved = try self?.saveAccessToken(accessToken) ?? false
                            
                            self?.isAccessTokenGeneretd.value = isSaved
                        }
                        else if let strError = jsonDict["error"] as? String,
                            !strError.isEmpty {
                            self?.errorInfo.value = strError
                        }
                    }
                }
            } catch {
                print("error = \(error)")
            }
        }
    }
    
    private func saveAccessToken(_ token:String) throws -> Bool {
        
        try KeychainManager.shared.saveAccessToken(token)
        
        guard let _ = try KeychainManager.shared.getAccessToken() else {
            return false
        }
        return true
    }
}

enum LoginError: String, Error {
    
    case usrnameNotAvailable = "Please enter email Id."
    case passwordNotAvailable = "Please enter password."
}
