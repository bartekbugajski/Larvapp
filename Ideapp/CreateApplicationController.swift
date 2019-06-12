//
//  CreateApplicationController.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 05/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit
import CoreData

// Custom Delegation
protocol CreateApplicationControllerDelegate {
    func didAddApplication(application: Application)
    func didEditApplication(application: Application)
    }

class CreateApplicationController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var application: Application? {
        didSet {
            nameTextField.text = application?.name
        //applicationDescription.text = application?.notes
        // dateIsDisplayed = (application?.created)! as NSDate
        //   if let imageData = application?.imageData {
        //  applicationImageView.image = UIImage(data: imageData)
               // setupCircularImageStyle()
            // }
          //  guard (application?.created) != nil else { return }
        }
    }
    // not tightly-coupled, for the classes above
    var delegate: CreateApplicationControllerDelegate?
    // var applicationsController: ApplicationsController?
    /*
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.backgroundColor = .secondSubHeader
        // enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    */
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter a name"
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        //textField.textColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 24)
        return textField
    }()
   
    
    let appDescrLabel: UILabel = {
        let appDescrLabel = UILabel()
        appDescrLabel.text = "description"
        appDescrLabel.textAlignment = .left
        appDescrLabel.textColor = .white
        appDescrLabel.font = UIFont.boldSystemFont(ofSize: 28)
       // appDescrLabel.backgroundColor = .secondSubHeader
        // enable autolayout
        appDescrLabel.translatesAutoresizingMaskIntoConstraints = false
        return appDescrLabel
    }()
     
    let notesField: UITextView = {
        let notesField = UITextView()
        notesField.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
       // notesField.backgroundColor = .secondSubHeader
        notesField.translatesAutoresizingMaskIntoConstraints = false
        notesField.font = UIFont.systemFont(ofSize: 15)
        notesField.textColor = UIColor.white
        //appDescription.insertText("Start typing...")
        //appDescription.textAlignment = .justified
        notesField.allowsEditingTextAttributes = true
        notesField.isScrollEnabled = true
        notesField.keyboardAppearance = .default
        notesField.keyboardDismissMode = .interactive
        notesField.isScrollEnabled = true
        notesField.showsVerticalScrollIndicator = true
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
        //imageView.isUserInteractionEnabled = false // remember to enable this, otherwise ImageView by default are not interactive
      //  imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto)))
        return imageView
    }()
   /* @objc private func handleSelectPhoto() {
        print("Trying to select photo")
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    } */
  /*  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        // ternary syntax
        navigationItem.title = application == nil ? "Save new idea" : "Edit the details"
    }
  */
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = application?.name
       // view.backgroundColor = .cellColor
        
        //setupUI()
      //  setupCancelButtonInNavBar()
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
        
    }

    
    @objc private func handleSave() {
       // print("Trying to save...")
        if application == nil {
       //     createApplication()
        } else {
           // saveApplicationChanges()
        }
    }
    
}
    

    



