//
//  menuViewController.swift
//  Mujeres que viven
//
//  Created by Salvador De La Rosa on 9/5/16.
//  Copyright © 2016 Magnolia Inc. All rights reserved.
//

import Foundation
import UIKit

class menuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground() 
        
    }

}


//Configure UI
extension menuViewController {
    
    private func configureBackground() {
        let backgroundGradient = CAGradientLayer()
        let colorTop = UIColor(red:1.00, green:0.00, blue:0.54, alpha:1.0).CGColor
        let colorBottom = UIColor(red:1.00, green:0.63, blue:0.43, alpha:1.0).CGColor
        backgroundGradient.colors = [colorTop, colorBottom]
        backgroundGradient.locations = [0.0, 1.0]
        backgroundGradient.frame = view.frame
        view.layer.insertSublayer(backgroundGradient, atIndex: 0)
    }
}
