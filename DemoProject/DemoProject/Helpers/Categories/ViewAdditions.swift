//
//  ViewAdditions.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

enum InfoPosition {
    case top
    case middle
    case bottom
}

extension UIView {
    
    func showInfo(infoPosition position: InfoPosition, info strInfo: String?) {
        
        guard let info = strInfo, !info.isEmpty else { return }
        
        switch position {
        case .top:
            self.makeToast(info, duration: 0.3, position: .top)
        case .middle:
            self.makeToast(info, duration: 0.3, position: .center)
        case .bottom:
            self.makeToast(info, duration: 0.3, position: .bottom)
        }
    }
    
    func addTransitionAnimation() {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        layer.add(transition, forKey: nil)
    }
    
    func applyAnimationEffect() -> Void {
        
        weak var weakSelf = self
        moveToMainThread{
            UIView.animate(withDuration: 0.3) {
                weakSelf?.layoutIfNeeded()
            }
        }
    }
}
