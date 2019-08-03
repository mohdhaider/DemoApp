//
//  CustomView.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

class CustomView: UIView {

    // MARK:- variables -
    
    enum ViewType: Int {
        case none
        case backgroundView
    }

    // MARK:- View Lifecycle -
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupCustomView()
    }
    
    // MARK:- Helpers -
    
    func setupCustomView() -> Void {
        
        if let customViewType = ViewType(rawValue: self.tag) {
            
            switch customViewType {
                
            case .backgroundView:
                self.backgroundColor = UIColor.defaultBackgroundColor()
            default:
                break
            }
        }
    }
}
