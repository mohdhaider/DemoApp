//
//  DetailsViewController.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {

    // MARK:- Variables -
    
    let webView = WKWebView()
    
    lazy var viewModel: DetailsViewModel = {
        return DetailsViewModel()
    }()
    
    // MARK:- Controller Lifecycle -
    
    override func loadView() {
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        observerWebViewChanges()
    }
    
    deinit {
        removeWebViewObservers()
    }
}

extension DetailsViewController {
    
    // MARK:- Private Functions -
    
    private func initialSetup() {
        
        navigationBarSetup()
        dataBinding()
        loadContent()
    }
    
    private func navigationBarSetup() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        
        let rightItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonSelected))
        navigationItem.rightBarButtonItem = rightItem
    }
    
    private func loadContent() {
        
        if let strUrl = viewModel.detailsContentUrl(), !strUrl.isEmpty {
            
            let url = URL(string: strUrl)!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    private func dataBinding() {
        
        viewModel.pageTitle.bind {[weak self] (pageTitle) in
            self?.moveToMainThread({
                self?.title = pageTitle
            })
        }
        
        viewModel.isUserLogout.bind {[weak self] (isLogout) in
            if isLogout {
                self?.moveToMainThread({
                    self?.performLogout()
                })
            }
        }
    }
}

extension DetailsViewController {
    
    // MARK:- Actions -
    
    @objc func logoutButtonSelected() {
        do {
            try viewModel.removeUserAccessToken()
        } catch  {
            view.showInfo(infoPosition: .middle, info: error.localizedDescription)
        }
    }
    
    private func performLogout() {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailsViewController {
    
    // MARK:- Setup Observers -
    
    private func observerWebViewChanges() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
    }
    
    private func removeWebViewObservers() {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            //print(Float(webView.estimatedProgress))
        }
        else if keyPath == "title",
            let title = webView.title {
            viewModel.updateNewTitle(title)
        }
    }
}

extension DetailsViewController: WKNavigationDelegate {
    
    
}
