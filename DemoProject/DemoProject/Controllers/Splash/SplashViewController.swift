//
//  SplashViewController.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK:- Variables -
    
    lazy var viewModel: SplashViewModel = {
       return SplashViewModel()
    }()
    
    // MARK:- Controller Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        do {
            try showAppInitalScreen()
        } catch {
            print(error)
            abort()
        }
    }

    // MARK:- Helpers -
    
    func showAppInitalScreen() throws {
     
        if viewModel.canShowLoginScreen() {
            
        }
        else if viewModel.canShowDetaailsScreen() {
            
        }
        else {
            throw AppErrors.screenNotAvailable
        }
    }
}

