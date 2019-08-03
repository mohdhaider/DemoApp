//
//  DetailsViewModel.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

final class DetailsViewModel: NSObject {

    // MARK:- Variables -
    
    var pageTitle = DataObserver<String>("")
    
    var isUserLogout = DataObserver<Bool>(false)
    
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
    
    func updateNewTitle(_ title: String?) {
        
        guard let title = title, !title.isEmpty else { return }
        
        pageTitle.value = title
    }
    
    func removeUserAccessToken() throws {
        do {
            try KeychainManager.shared.removeSavedAccessToken()
            isUserLogout.value = true
        } catch  {
            throw error
        }
    }
}
