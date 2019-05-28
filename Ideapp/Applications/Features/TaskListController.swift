//
//  AppdetailsController.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 19/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit
import CoreData

// lets create a UILabel subclass for custom text drawing
class IndentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        let customRect = rect.inset(by: insets)
        super.drawText(in: customRect)
    }
}

class TaskListController: UITableViewController, AddNewTaskControllerDelegate {
//this is called when we dismiss employee creation
    func didAddTask(task: Task) {
      //  taskList.append(task)
      //  fetchDetails()
     //   tableView.reloadData()
        
        guard let section = taskTypes.firstIndex(of: task.type!) else { return }
        let row = allTasks[section].count
        let insertionIndexPath = IndexPath(row: row, section: section)
        allTasks[section].append(task)
        tableView.insertRows(at: [insertionIndexPath], with: .automatic)
    }
    
    var application: Application?
    var taskList = [Task]()
    var taskTypes = [
        TaskType.HighPriority.rawValue,
        TaskType.Normal.rawValue,
        TaskType.LowPriority.rawValue]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = application?.name
        setupGoBackButtonInNavBar()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        label.backgroundColor = UIColor.softPurple
        /*
        if section == 0 {
            label.text = TaskType.HighPriority.rawValue
        } else if section == 1 {
            label.text = TaskType.Normal.rawValue
        } else {
            label.text = TaskType.LowPriority.rawValue
        }
        */
        
        label.text = taskTypes[section]
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    var allTasks = [[Task]]()
    
    // establishes how apps link with tasks list
    private func fetchDetails() {
        guard let applicationTasks = application?.tasks?.allObjects as? [Task] else { return }
        allTasks = []
        //self.taskList = applicationTasks
        taskTypes.forEach { (taskType) in
            // somehow construct my allTasks array
            allTasks.append(
                applicationTasks.filter { $0.type == taskType }
        )
        }
        
        /*
        //filter app tasks for 'High Priority'
        let highPriority = applicationTasks.filter { $0.type == TaskType.HighPriority.rawValue }
        let normal = applicationTasks.filter { $0.type == TaskType.Normal.rawValue}
        let lowPriority = applicationTasks.filter { $0.type == TaskType.LowPriority.rawValue }
        
        allTasks = [
            highPriority,
            normal,
            lowPriority
            //applicationTasks.filter { $0.type == "Just an idea" }
        ]
         */
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allTasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    //    if indexPath.section == 0 {
      //      task = quickTask
       // }
        
//        let task = taskList[indexPath.row]
        //let task = indexPath.section == 0 ? quickTasks[indexPath.row] : complexTasks[indexPath.row]
        let task = allTasks[indexPath.section][indexPath.row]
        cell.textLabel?.text = task.name
        /*
        if let dateLabel = task.taskDetails?.created {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            cell.textLabel?.text = "\(task.name ?? "")       \(dateFormatter.string(from: dateLabel))"} */
        cell.backgroundColor = UIColor.softPurple
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = .softPurple
        tableView.tableFooterView = UIView() //blank UIView
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        fetchDetails()
        /*
        let topBar = UITextField()
        topBar.placeholder = "Add pending task for your app"
        topBar.font = UIFont.boldSystemFont(ofSize: 12)
        topBar.textColor = .white
        //topBar.delegate = self
        self.setupLightPurpleBackgroundView(height: 50).addSubview(topBar)
        */
    }
    
    @objc private func handleAdd() {
        print("Trying to add a new idea..")
        let addNewTaskController = AddNewTaskController()
        addNewTaskController.delegate = self
        addNewTaskController.application = application
        let navController = UINavigationController(rootViewController: addNewTaskController)
        present(navController, animated: true, completion: nil)
    }
}


