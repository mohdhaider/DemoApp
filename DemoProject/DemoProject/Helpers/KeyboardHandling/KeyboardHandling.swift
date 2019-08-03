//
//  KeyboardHandling.swift
//  FlickrDemo
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardHandlingProtocol {
    
    func keyboardWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
}

class KeyboardHeightHandler: NSObject {
    
    var height: DataObserver<CGFloat> = DataObserver(0)
    
    override init() {
        super.init()
        startObserving()
    }
    
    deinit {
        removeObserving()
    }
    
    func startObserving() {
        let center = NotificationCenter.default
        
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(_:)),
                           name: UIResponder.keyboardWillShowNotification,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(_:)),
                           name: UIResponder.keyboardWillHideNotification,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(_:)),
                           name: UIResponder.keyboardWillChangeFrameNotification,
                           object: nil)
    }
    
    func removeObserving() {
        
        let center = NotificationCenter.default
        
        center.removeObserver(self,
                              name: UIResponder.keyboardWillShowNotification,
                              object: nil)
        
        center.removeObserver(self,
                              name: UIResponder.keyboardWillHideNotification,
                              object: nil)
        
        center.removeObserver(self,
                              name: UIResponder.keyboardWillChangeFrameNotification,
                              object: nil)
    }
}

extension KeyboardHeightHandler: KeyboardHandlingProtocol {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardRectValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let keyboardHeight = keyboardRectValue.height
            height.value = keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        height.value = 0
    }
}

