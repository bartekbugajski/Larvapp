//
//  ApplicationsAutoUpdateController.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 06/04/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit
import CoreData

class ApplicationsAutoUpdateController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //warning: this code here is going to be a bit of a monster
    lazy var fetchedResultsController: NSFetchedResultsController<Application> = {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<Application> = Application.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "name", cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        return frc
    }()
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
            
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    @objc private func handleAdd() {
        print("Let's add a company called inGen.")
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let application = Application(context: context)
        application.name = "Cool ideas only"
        
        do {
            try context.save()
        } catch let err {
            print("Error adding.", err)
        }
    }
    
    @objc private func handleDelete() {
    print("Let's delete it.")
    let request: NSFetchRequest<Application> = Application.fetchRequest()
    let context = CoreDataManager.shared.persistentContainer.viewContext
    let applicationsWithB = try? context.fetch(request)
    applicationsWithB?.forEach { (application) in
    context.delete(application)
    }
    try? context.save()
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "larvapp"
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd)),
            UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(handleDelete))
        ]
        
        tableView.backgroundColor = UIColor.softPurple
        tableView.register(ApplicationCell.self, forCellReuseIdentifier: cellId)
  //      fetchedResultsController.fetchedObjects?.forEach({ (application) in
 //           print(application.name ?? "")})
 //       let service = Service()
//        service.downloadCompaniesFromServer()
        Service.shared.downloadCompaniesFromServer()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        label.text = fetchedResultsController.sectionIndexTitles[section]
        label.text = "HEADER"
        label.backgroundColor = UIColor.secondSubHeader
        return label
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    let cellId = "cellId"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ApplicationCell
        let application = fetchedResultsController.object(at: indexPath)
        cell.backgroundColor = .softPurple
        cell.textLabel?.textColor = .white
        //cell.detailTextLabel.text = true
        //cell.textLabel?.text = application.name
        cell.application = application
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let taskListController = TaskListController()
        taskListController.application = fetchedResultsController.object(at: indexPath)
        navigationController?.pushViewController(taskListController, animated: true)
    }
}
