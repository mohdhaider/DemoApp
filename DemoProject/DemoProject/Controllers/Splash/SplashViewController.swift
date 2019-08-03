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
        
        appInitialSetups()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
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
}

extension SplashViewController {

    // MARK:- Private Functions -
    
    private func appInitialSetups() {
        
        ToastManager.shared.applyDefaultStyle()
        view.backgroundColor = UIColor.defaultBackgroundColor()
    }
    
    private func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func showAppInitalScreen() throws {
        
        if viewModel.canShowLoginScreen() {
            showLoginScreen()
        } else if viewModel.canShowDetailsScreen() {
            showDetailsScreen()
        } else {
            throw AppErrors.screenNotAvailable
        }
    }
    
    private func showLoginScreen() {
        
        guard let navCtrl = navigationController else { return }
        
        let controller = LoginViewController(nibName: "LoginViewController", bundle: Bundle.main)
        
        navCtrl.view.addTransitionAnimation()
        navCtrl.pushViewController(controller, animated: false)
    }
    
    private func showDetailsScreen() {
        
        guard let navCtrl = navigationController else { return }
        
        let controller = DetailsViewController(nibName: "DetailsViewController", bundle: Bundle.main)
        
        navCtrl.view.addTransitionAnimation()
        navCtrl.pushViewController(controller, animated: false)
    }
}
