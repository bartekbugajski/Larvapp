//
//  CreateNewAppController.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 19/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit

protocol AddNewTaskControllerDelegate {
    func didAddTask(task: Task)
}

class AddNewTaskController: UIViewController, UITextViewDelegate {
    var delegate: AddNewTaskControllerDelegate?
    var application: Application?
    
    
    let nameTextView: UITextView = {
        let textView = UITextView()
        textView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        textView.backgroundColor = .secondSubHeader
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textColor = UIColor.white
        textView.insertText("Start typing...")
        textView.allowsEditingTextAttributes = true
        //textView.isScrollEnabled = true
        textView.keyboardAppearance = .default
        textView.keyboardDismissMode = .interactive
        //textView.showsVerticalScrollIndicator = true
        //textView.adjustsFontForContentSizeCategory = true
        return textView
    }()
    
    let appTypeSegmentedControl: UISegmentedControl = {
        
        let types = [
            TaskType.HighPriority.rawValue,
            TaskType.Normal.rawValue,
            TaskType.LowPriority.rawValue]
        
        let sc = UISegmentedControl(items: types)
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 1
        sc.tintColor = .topHeader
        return sc
    }()
    
    
    /*
    let dateTextField: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .defaultFont
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        textField.textColor = .white
        textField.text = "\(dateFormatter.string(from: date))"
        return textField
    }()
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add new task"
        setupCancelButtonInNavBar()
        view.backgroundColor = .secondSubHeader
        
        // how does the underscore below fixes the unused yellow issue?
        //setupGoBackToFeaturesButtonInNavBar()
        setupUI()
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    
    }
    

    
    @objc private func handleSave() {
        guard let taskName = nameTextView.text else { return }
        guard let application = self.application else { return }
        // turn date  text field into a date object
        
        /*
        guard let dateText = dateTextField.text else { return }
        // if dateText.isEmpty {
        //      showError(title: "Empty Date", message: "Date not saved.")
        //       return
        //   }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        guard let dateToSave = dateFormatter.date(from: dateText) else {
            showError(title: "Bad Date", message: "Birthday date entered not valid")
            return
        }
        */
       // print(dateText)
       // print(dateToSave)
        
        guard let appType = appTypeSegmentedControl.titleForSegment(at: appTypeSegmentedControl.selectedSegmentIndex) else { return }
        //print(appType)
        
       // where do we get application from
        let tuple = CoreDataManager.shared.createTask(taskName: taskName, application: application, appType: appType)
       if let error = tuple.1
       {
        //is where you present error model of some kind
        // use UIAlertController to show your message
            print(error)
        } else {
            //we'll call the delegate somehow!
        self.delegate?.didAddTask(task: tuple.0!)
            //creation success
            dismiss(animated: true, completion: {
            })
        }
    }
    
    
    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupUI() {
    //_ = setupLightPurpleBackgroundView(height: 150)
        
    view.addSubview(nameTextView)
    nameTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
    //nameTextField.bottomAnchor.constraint(equalTo: dateTextField.bottomAnchor).isActive = true
    //nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    //nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
    nameTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
   // nameTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    nameTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    nameTextView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
    view.addSubview(appTypeSegmentedControl)
    appTypeSegmentedControl.topAnchor.constraint(equalTo: nameTextView.bottomAnchor).isActive = true
    appTypeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    //appTypeSegmentedControl.bottomAnchor.constraint(equalTo: nameTextView.bottomAnchor).isActive = true
    appTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    /*
    view.addSubview(dateTextField)
    dateTextField.topAnchor.constraint(equalTo: nameTextView.bottomAnchor).isActive = true
    dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    dateTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
    dateTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
    //dateTextField.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
    //dateTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    //dateTextField.leftAnchor.constraint(equalTo: dateLabel.rightAnchor).isActive = true
    */
    }
    
 }
