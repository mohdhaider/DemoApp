//
//  DetailsViewController.swift
//  DemoProject
//
//  Created by Mohd Haider on 03/08/19.
//  Copyright © 2019 Mohd Haider. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK:- IBOutlets -
    
    // MARK:- Variables -
    
    lazy var viewModel: DetailsViewModel = {
        return DetailsViewModel()
    }()
    
    // MARK:- Controller Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
