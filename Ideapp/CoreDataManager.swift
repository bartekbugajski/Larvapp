//
//  CoreDataManager.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 07/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager() // will live forever as long as the application is still alive, and it's properties will too
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TrainingCoreModel")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed \(err).")
            }
    }
        return container
    }()
    
    func fetchApplications() -> [Application] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Application>(entityName: "Application")
        do {
            let applications = try context.fetch(fetchRequest)
            return applications
        } catch let fetchErr {
            print("Failed to fetch the list of  Applications.", fetchErr)
        }
        return []
    }
    
    func createTask(taskName: String, application: Application, appType: String) -> (Task?, Error?) {
        let context = persistentContainer.viewContext
        // create a task
        let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: context) as! Task
        task.application = application
        // lets check application is setup correctly
        //let application = Application(context: context)
        //application.tasks
        //task.application
        task.setValue(taskName, forKey: "name")
        task.type = appType
        
        /*
        let taskDetails = NSEntityDescription.insertNewObject(forEntityName: "TaskDetails", into: context) as! TaskDetails
        task.taskDetails = taskDetails
        taskDetails.created = created
        // task.taskDetails?.setValue(created, forKey: "created")
        */
        
        do {
        try context.save()
            //save succeeds
            return (task, nil)
        } catch let err {
            print("Failed to create employee", err)
            return (nil, err)
        }
    }

}
