//
//  LoginButton.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

class LoginButton: UIButton {

    // MARK:- Button Lifecycle -
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupButton()
    }
    
    // MARK:- Helpers -
    
    func setupButton() {
        
        layer.cornerRadius = 4.0
        layer.shadowOffset = CGSize.init(width: 0, height: 1)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2.0
        layer.shadowColor  = UIColor.lightGray.cgColor
        clipsToBounds = false
    }
}
