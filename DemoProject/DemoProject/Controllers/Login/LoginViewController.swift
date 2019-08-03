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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonLogin: LoginButton!
    @IBOutlet weak var textFieldUsername: CustomTextField!
    @IBOutlet weak var textFieldPassword: CustomTextField!
    
    // MARK:- Variables -
    
    private lazy var viewModel = LoginViewModel()
    
    private lazy var keyboardHeightHandler = KeyboardHeightHandler()
    
    // MARK:- Controller Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        clearContent()
    }
}

extension LoginViewController {
    
    // MARK:- Private Functions -
    
    private func initialSetup() {
        dataBinding()
    }
    
    private func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        navigationItem.hidesBackButton = true
    }
    
    private func clearContent() {
        textFieldUsername.text = nil
        textFieldPassword.text = nil
    }
    
    private func dataBinding() {
        
        keyboardHeightHandler.height.bind {[weak self] (height) in
            self?.handleScrollViewScrolling(keyboardHeight: height)
        }
        
        viewModel.showActivityIndicator.bind {[weak self] (show) in
            
            self?.moveToMainThread({
                self?.networkRequestHandling(show)
            })
        }
        
        viewModel.isAccessTokenGeneretd.bind {[weak self] (isGenerated) in
            
            if isGenerated {
                self?.showDetailsScreen()
            }
        }
        
        viewModel.errorInfo.bind {[weak self] (error) in
        
            self?.moveToMainThread({
                self?.view.showInfo(infoPosition: .middle, info: error)
            })
        }
    }
    
    private func handleScrollViewScrolling(keyboardHeight height: CGFloat) {

        moveToMainThread{[weak self] in
            var keyboardHeight = height
            if #available(iOS 11.0, *) {
                if let viewAvail = self?.view {
                    keyboardHeight = keyboardHeight - viewAvail.safeAreaInsets.bottom
                }
            }
            
            let width = self?.scrollView.contentSize.width ?? 0
            let height = (self?.scrollView.frame.size.height ?? 0) + keyboardHeight
            
            self?.scrollView.contentSize = CGSize(width: width,
                                                  height: height)
            self?.view.applyAnimationEffect()
            self?.scrollView.scrollToBottom(animated: true)
        }
    }
    
    private func networkRequestHandling(_ isWorking:Bool) {
        
        if isWorking {
            view.endEditing(true)
            activityIndicator.startAnimating()
            view.isUserInteractionEnabled = false
            buttonLogin.setTitle(nil, for: .normal)
        } else {
            activityIndicator.stopAnimating()
            view.isUserInteractionEnabled = true
            buttonLogin.setTitle("LOGIN", for: .normal)
        }
    }
    
    private func showDetailsScreen() {
        
        moveToMainThread {[weak self] in
            
            guard let navCtrl = self?.navigationController else { return }
            
            let controller = DetailsViewController(nibName: "DetailsViewController", bundle: Bundle.main)
            
            navCtrl.pushViewController(controller, animated: true)
        }
    }
}

extension LoginViewController {
    
    // MARK:- Actions -
    
    @IBAction func loginButtonPressed(_ sender: Any?) {
        
        do {
            try viewModel.performLoginApi(forUsername: textFieldUsername.text, forPassword: textFieldPassword.text)
        } catch {
            view.showInfo(infoPosition: .middle, info: error.localizedDescription)
        }
    }
}
