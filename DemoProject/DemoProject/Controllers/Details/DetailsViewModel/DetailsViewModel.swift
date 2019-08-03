//
//  DetailsViewModel.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

final class DetailsViewModel: NSObject {

    // MARK:- Initializers -
    
    override init() {
        super.init()
    }
    
    // MARK:- Helpers -
    
    func detailsContentUrl() -> String? {
        do {
            if let accessToken = try KeychainManager.shared.getAccessToken() {
                return "\(Apis.detailsApiUrl.rawValue)?token=\(accessToken)"
            }
            return nil
        } catch  {
            return nil
        }
    }
}
