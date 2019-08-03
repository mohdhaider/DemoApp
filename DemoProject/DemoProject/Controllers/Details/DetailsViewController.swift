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

    // MARK:- IBOutlets -
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK:- Variables -
    
    lazy var viewModel: DetailsViewModel = {
        return DetailsViewModel()
    }()
    
    // MARK:- Controller Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }
}

extension DetailsViewController {
    
    // MARK:- Private Functions -
    
    private func initialSetup() {
        
        setupWebView()
        loadContent()
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
    }
    
    private func loadContent() {
        
        if let strUrl = viewModel.detailsContentUrl(), !strUrl.isEmpty {
            
            let url = URL(string: strUrl)!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}

extension DetailsViewController: WKNavigationDelegate {
    
    
}
