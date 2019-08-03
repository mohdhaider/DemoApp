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
        textFieldUsername.text = "mohdhaider1187@gmail.com"
        textFieldPassword.text = "Qwerty#654321"
        
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension LoginViewController {
    
    // MARK:- Private Functions -
    
    private func initialSetup() {
        dataBinding()
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
    
    func networkRequestHandling(_ isWorking:Bool) {
        
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
