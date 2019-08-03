//
//  AttributedStringAdditions.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString {
    
    class func getAttributedString(_ text:String?, font:UIFont, textColor: UIColor) -> NSAttributedString? {
        
        guard let text = text, !text.isEmpty else { return nil }
        
        return NSAttributedString(string: text,
                                  attributes: [NSAttributedString.Key.foregroundColor: textColor,
                                               NSAttributedString.Key.font: font as Any])
    }
}
