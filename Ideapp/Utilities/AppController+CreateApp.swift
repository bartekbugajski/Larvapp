//
//  ApplicationsController+CreateApplication.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 18/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit

extension ApplicationsController: CreateApplicationControllerDelegate, EditApplicationDetailsControllerDelegate {
    
    
    //specify your extension methods here...
    
func didEditApplication(application: Application) {
    // update my tableview somehow
    let row = applications.firstIndex(of: application)
    let reloadIndexPath = IndexPath(row: row!, section: 0)
    tableView.reloadRows(at: [reloadIndexPath], with: .fade)
}

func didAddApplication(application: Application) {
    //1 modify your array
    applications.append(application)
    //2 insert a new table path into the table view
    let newIndexPath = IndexPath(row: applications.count - 1, section: 0)
    tableView.insertRows(at: [newIndexPath], with: .automatic)
}
    
}
