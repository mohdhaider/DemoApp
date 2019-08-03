//
//  KeychainManager.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit
import KeychainAccess

enum KeychainErrors: String, Error {
    case EmptyToken
    case SavingAccessTokenFailed
    case RetrievingAccessTokenFailed
    case RemovingAccessTokenFailed
}

final class KeychainManager: NSObject {

    // MARK:- Variables -
    
    static let shared = KeychainManager()
    
    enum KeychainKeys: String {
        case name = "com.demo.accessToken"
        case accessToken
    }
    
    private let keychain = Keychain(service: KeychainKeys.name.rawValue)
    
    // MARK:- Initalizers -
    
    private override init() {
        super.init()
    }
    
    // MARK:- Helpers -
    
    func getAccessToken() throws -> String? {
        
        var token: String?
        do {
            token = try keychain.getString(KeychainKeys.accessToken.rawValue)
        } catch {
            throw KeychainErrors.RetrievingAccessTokenFailed
        }
        
        guard let strToken = token, !strToken.isEmpty else {
            throw KeychainErrors.RetrievingAccessTokenFailed
        }
        
        return token
    }
    
    func saveAccessToken(_ token: String?) throws {
        
        guard let token = token, !token.isEmpty else {
            throw KeychainErrors.EmptyToken
        }
        
        do {
            try keychain.set(token, key: KeychainKeys.accessToken.rawValue)
        } catch {
            throw KeychainErrors.SavingAccessTokenFailed
        }
    }
    
    func removeSavedAccessToken() throws {
        
        do {
            try keychain.remove(KeychainKeys.accessToken.rawValue)
        } catch {
            throw KeychainErrors.RemovingAccessTokenFailed
        }
    }
}
