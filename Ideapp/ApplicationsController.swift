//
//  ViewController.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 05/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit
import CoreData


class ApplicationsController: UITableViewController {
    var applications = [Application]() // empty array
    
    @objc func doWork() {
        print("Do work")
        CoreDataManager.shared.persistentContainer.performBackgroundTask({
            (backgroundContext) in
            (0...20).forEach {(value) in
                print(value)
                let application = Application(context: backgroundContext)
                application.name = String(value)}
            do {
                try backgroundContext.save()
                DispatchQueue.main.async {
                    self.applications = CoreDataManager.shared.fetchApplications()
                    self.tableView.reloadData()
                }
            } catch let err {
                print("Failed to save", err)
            }
        }
   )}
    
    @objc func doUpdates() {
        print("Trying to update on a background context.")
        CoreDataManager.shared.persistentContainer.performBackgroundTask { (backgroundContext) in
            let request: NSFetchRequest<Application> = Application.fetchRequest()
            do {
                let applications = try backgroundContext.fetch(request)
                    applications.forEach({ (application) in
                        print(application.name ?? "")
                        application.name = "A: \(application.name ?? "")"
                    })
            do {
                    try backgroundContext.save()
            // let's try to update the UI after a save
                    DispatchQueue.main.async {
                        CoreDataManager.shared.persistentContainer.viewContext.reset()
                        self.applications = CoreDataManager.shared.fetchApplications()
                        self.tableView.reloadData()
                    }
                }
                } catch let err {
                    print("Failed to fetch applications on background:", err)
            }
        }
    }
    
    @objc private func doNestedUpdates() {
        print("Trying to perform a nested updates now...")
        DispatchQueue.global(qos: .background).async {
            // we'll try to perform our updates
            // we'll first construct a custom MOC
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
            //execute updates on privateContext now
            let request: NSFetchRequest<Application> = Application.fetchRequest()
            request.fetchLimit = 1
        do {
        let applications = try privateContext.fetch(request)
            applications.forEach({ (application) in
                print(application.name ?? "")
                application.name = "D: \(application.name ?? "")"
            })
        do {
            try privateContext.save()
            
        // after the save succeeeds
            DispatchQueue.main.async {
                
                do {
                    let context = CoreDataManager.shared.persistentContainer.viewContext
                    if context.hasChanges {
                        try context.save()
                    }
                    self.tableView.reloadData()
                } catch let finalSaveErr {
                    print("Failed to save main context:", finalSaveErr)
                }
            }
            } catch let saveErr {
                print("Failed to save on private context.", saveErr)
            }
            } catch let fetchErr {
        print("Failed to fetch on a private context:", fetchErr)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // fetching refactored inside of Core Data Manager file
        self.applications = CoreDataManager.shared.fetchApplications()
        navigationItem.leftBarButtonItems = [
       // UIBarButtonItem(title: "Delete all", style: .plain, target: self, action: #selector(handleReset)),
        //UIBarButtonItem(title: "Nested Updates", style: .plain, target: self, action: #selector(doNestedUpdates))
        ]
        view.backgroundColor = .white
        navigationItem.title = "my apps"
        //tableView.rowHeight = 50.0
//        tableView.backgroundColor = .tableBackground
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .darkGray
        tableView.tableFooterView = UIView() //blank UIView
        tableView.register(ApplicationCell.self, forCellReuseIdentifier: "Cell")
//        setupPlusButtonInNavBar(selector: #selector(handleAddApp))
    }
    
    @objc private func handleReset() {
        print("Attempting to delete all core data objects")
        let context = CoreDataManager.shared.persistentContainer.viewContext
        applications.forEach { (application) in
            context.delete(application)
        }
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Application.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            // upon deletion from core data succeeded
            var indexPathsToRemove = [IndexPath]()
            for (index, _) in applications.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            applications.removeAll()
            tableView.deleteRows(at: indexPathsToRemove, with: .left)
        } catch let delErr {
            print("Failed to delete objects from Core Data", delErr)
        }
    }
    
    @objc func handleAddApp() {
        print("Adding a new app idea...")
        let createApplicationController = CreateApplicationController()
        //createApplicationController.view.backgroundColor = .green
        let navController = UINavigationController(rootViewController: createApplicationController)
        createApplicationController.delegate = self as CreateApplicationControllerDelegate
        present(navController, animated: true, completion: nil)
    }

   
}

