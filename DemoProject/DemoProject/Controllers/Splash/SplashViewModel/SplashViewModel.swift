//
//  SplashViewModel.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

final class SplashViewModel: NSObject {

    // MARK:- Initallizers -
    
    override init() {
        super.init()
    }
    
    // MARK:- Helpers -
    
    func canShowLoginScreen() -> Bool {
        do {
            _ = try KeychainManager.shared.getAccessToken()
            return false
        } catch {
            return true
        }
    }
    
    func canShowDetailsScreen() -> Bool {
        do {
            _ = try KeychainManager.shared.getAccessToken()
            return true
        } catch {
            return false
        }
    }
}
