//
//  UIViewController+Utilities.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 19/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // my extension/utility methods
    
 
   
    
    
    func setupPlusButtonInNavBar(selector: Selector) {
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: selector)
    }
    
    func setupCancelButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModel))
    }
    
    func setupGoBackButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
    }
    
    func setupGoBackToFeaturesButtonInNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackToFeatures))
    }
    
    @objc func handleCancelModel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func goBack() {
        let applicationsController = ApplicationsController()
        let navController = CustomNavigationController(rootViewController: applicationsController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc func goBackToFeatures() {
        let featuresController = TaskListController()
        let navController = CustomNavigationController(rootViewController: featuresController)
        present(navController, animated: true, completion: nil)
    }
    
    func setupLightPurpleBackgroundView(height: CGFloat) -> UIView {
        
    let lightPurpleBackgroundView = UIView()
    lightPurpleBackgroundView.backgroundColor = UIColor.secondSubHeader
    lightPurpleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
    
    
    view.addSubview(lightPurpleBackgroundView)
    lightPurpleBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    lightPurpleBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    lightPurpleBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    lightPurpleBackgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    return lightPurpleBackgroundView
}

}
