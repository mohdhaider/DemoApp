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
        return false
    }
    
    func canShowDetaailsScreen() -> Bool {
        return false
    }
}
