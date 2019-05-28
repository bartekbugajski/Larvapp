//
//  EditApplicationDetailsController.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 27/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit
import CoreData

// Custom Delegation
protocol EditApplicationDetailsControllerDelegate {
    func didAddApplication(application: Application)
    func didEditApplication(application: Application)
    
}


class EditApplicationDetailsController: UIViewController, UIImagePickerControllerDelegate {


    var application: Application? {
        didSet {
            nameTextField.text = application?.name
            notesField.text = application?.notes
           // if let imageData = application?.imageData {
        //        applicationImageView.image = UIImage(data: imageData)
          //  }
           // guard (application?.created) != nil else { return }
        }
    }
    
    var taskList = [Task]()
    
    // not tightly-coupled, for the classes above
    var delegate: EditApplicationDetailsControllerDelegate?
    // var applicationsController: ApplicationsController?
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter a name"
        textField.adjustsFontSizeToFitWidth = true
        
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        //textField.textColor = .subHeader
        textField.font = UIFont.boldSystemFont(ofSize: 24)
        return textField
    }()
    
    let quickNotesField: UILabel = {
        let notesField = UILabel()
        notesField.text = "notes"
        notesField.textAlignment = .center
        notesField.textColor = .white
        notesField.font = UIFont.boldSystemFont(ofSize: 38)
        notesField.backgroundColor = .secondSubHeader
        // enable autolayout
        notesField.translatesAutoresizingMaskIntoConstraints = false
        return notesField
    }()
    
    let notesField: UITextView = {
        let notesField = UITextView()
        //notesField.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        notesField.backgroundColor = .secondSubHeader
        notesField.translatesAutoresizingMaskIntoConstraints = false
        notesField.font = UIFont.systemFont(ofSize: 15)
        notesField.textColor = UIColor.white
        notesField.allowsEditingTextAttributes = true
        notesField.keyboardAppearance = .default
        notesField.keyboardDismissMode = .interactive
        notesField.isScrollEnabled = true
        notesField.showsVerticalScrollIndicator = true
        //appDescription.textAlignment = .justified
        return notesField
    }()
    
    
    let dateTextField: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.boldSystemFont(ofSize: 11)
        textField.textColor = .black
        textField.textAlignment = .center
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        textField.text = "\(dateFormatter.string(from: date))"
        return textField
    }()
    
    let applicationImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "brainstorming"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false // remember to enable this, otherwise ImageView by default are not interactive
       // imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return imageView
    }()

    /*
    @objc private func handleSelectPhoto() {
        print("Trying to select photo")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    */
    
    /*  override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     setupUI()
     // ternary syntax
     navigationItem.title = application == nil ? "Save new idea" : "Edit the details"
     }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        //setupPlusButtonInNavBar(selector: handleAdd)
        setupCancelButtonInNavBar()
        
        setupUI()
        navigationItem.title = application?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        view.backgroundColor = .secondSubHeader
        
    }

   
    
    @objc private func handleSave() {
        //print("Trying to save...")
        if application == nil {
            createApplication()
        } else {
            saveApplicationChanges()
            
        }
    }
    
    /*
    @objc private func handleAdd() {
        print("Trying to add a new idea..")
        let addNewTaskController = AddNewTaskController()
        addNewTaskController.delegate = self
        addNewTaskController.application = application
        let navController = UINavigationController(rootViewController: addNewTaskController)
        present(navController, animated: true, completion: nil)
    }
    */
    
    @objc override func handleCancelModel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        //if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
           // let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            //let keyBoardRect = frame?.cgRectValue
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
    }
    
    
    
}
