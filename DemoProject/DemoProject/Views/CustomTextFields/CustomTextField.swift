//
//  CustomTextField.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    // MARK:- Variables -
    
    private enum FieldType: Int {
        case none
        case username
        case password
    }
    
    private lazy var leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    private lazy var rigthPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    
    // MARK:- TextField Lifecycle -
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    // MARK:- Helpers -
    
    private func setup() {

        if let customViewType = FieldType(rawValue: self.tag) {
            
            switch customViewType {
                
            case .username:
                backgroundColor = UIColor.white
                layer.borderWidth = 2.0
                layer.borderColor = UIColor.textFieldBorderColor().cgColor
                clipsToBounds = true
                
                attributedPlaceholder = NSAttributedString.getAttributedString("ID", font: UIFont.systemFont(ofSize: 16, weight: .semibold), textColor: UIColor.lightGray)
                
                leftView = leftPaddingView
                leftViewMode = .always
                
            case .password:
                backgroundColor = UIColor.white
                layer.borderWidth = 2.0
                layer.borderColor = UIColor.textFieldBorderColor().cgColor
                clipsToBounds = true
                
                attributedPlaceholder = NSAttributedString.getAttributedString("Password", font: UIFont.systemFont(ofSize: 16, weight: .semibold), textColor: UIColor.lightGray)
                
                leftView = leftPaddingView
                leftViewMode = .always
                
            default:
                break
            }
        }
    }
}
