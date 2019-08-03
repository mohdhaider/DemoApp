//
//  LoginViewController.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK:- IBOotlets -
    
    // MARK:- Variables -
    
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    
    // MARK:- Controller Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
