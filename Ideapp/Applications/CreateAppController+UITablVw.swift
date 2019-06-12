//
//  CreateApplicationsController+UITableView.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 18/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit

extension ApplicationsController {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let application = self.applications[indexPath.row]
        let taskListController = CreateApplicationController()
        //editApplicationDetailsController.delegate = self
        taskListController.application = application
        let navController = CustomNavigationController(rootViewController: taskListController)
        present(navController, animated: true, completion: nil)
        //navigationController?.pushViewController(editApplicationDetailsController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, IndexPath) in
            let application = self.applications[IndexPath.row]
            print("Attempting to delete company...", application.name ?? "")
            // remove the application from our tableview
            // let deleteIndexPath = IndexPath
            self.applications.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            // delete the application from Core Data
            let context = CoreDataManager.shared.persistentContainer.viewContext
            context.delete(application)
            do {
                try context.save()
            } catch let saveErr {
                print("Failed to delete company.", saveErr)
            }
        }
        deleteAction.backgroundColor = UIColor.subHeader
        // This is for the 'Edit' when you slide
        //let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: editHandlerFunction)
        return [deleteAction]//, editAction*/
    }
    
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath) {
        // print("Editing application's name in separate function.")
        let editApplicationController = EditApplicationDetailsController()
        // The following delegate connects 2 of the view controller's pages
        editApplicationController.delegate = self as EditApplicationDetailsControllerDelegate
        editApplicationController.application = applications[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editApplicationController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "You haven't saved any app ideas yet..."
        label.textColor = .black
        label.textAlignment = .center
        // label.font = UIFont.boldSystemFont(ofSize: 16)
        label.font = .defaultFont
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return applications.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .subHeader
        return view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ApplicationCell
        let application = applications[indexPath.row]
        cell.application = application
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applications.count
    }
}

