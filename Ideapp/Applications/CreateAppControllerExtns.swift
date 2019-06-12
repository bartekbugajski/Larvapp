//
//  CreateApplicationsControllerExtensions.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 18/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import CoreData
import UIKit

extension CreateApplicationController: UITextViewDelegate {
    func didAddApplication(application: Application) { }
    func didEditApplication(application: Application) { }
  
    func setupCircularImageStyle() {
        applicationImageView.layer.cornerRadius = applicationImageView.frame.width / 2
        applicationImageView.clipsToBounds = true
        applicationImageView.layer.borderColor = UIColor.black.cgColor
        applicationImageView.layer.borderWidth = 2
    }
    func saveApplicationChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        application?.name = nameTextField.text
        application?.notes = notesField.text
        //application?.created = dateLabel
        // here I should add the created date application?.date = dateField sth like that
      //  if let applicationImage = applicationImageView.image {
      //      let imageData = applicationImage.jpegData(compressionQuality: 0.8)
     //       application?.imageData = imageData
     //   }
        do {
            try context.save()
            // save succeeded
            dismiss(animated: true, completion: {
                self.delegate?.didEditApplication(application: self.application!)})
        } catch let saveErr {
            print("Failed to save application.", saveErr)
        }
    }
    
    
    func createApplication() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let application = NSEntityDescription.insertNewObject(forEntityName: "Application", into: context) as! Application
        application.setValue(nameTextField.text, forKey: "name")
        application.setValue(notesField.text, forKey: "notes")
        
        /*
        guard let dateText = dateTextField.text else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        _ = dateFormatter.date(from: dateText)
        
        application.setValue(dateTextField.text, forKey: "created")
        
        //application.setValue(displayDate, forKey: "date")
        // here I should add the created date application.setValue(nameTextField.text, forKey: "name")
    // if let applicationImage = applicationImageView.image {
      //      let imageData = applicationImage.jpegData(compressionQuality: 0.9)
      //      application.setValue(imageData, forKey: "imageData")
    //    }
 */
        
        //perform the save
        do {
            try context.save()
            //success
            dismiss(animated: true, completion: {
                self.delegate?.didAddApplication(application: application)
            })
        } catch let saveErr {
            print("Failed to save company", saveErr)
        }
    }

    
    func setupUI() {
        
        let lightPurpleBackgroundView = setupLightPurpleBackgroundView(height: 150)
        
        view.addSubview(applicationImageView)
        applicationImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        applicationImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        applicationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        applicationImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //applicationImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: applicationImageView.bottomAnchor, constant: 10).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        /*
        view.addSubview(dateTextField)
        dateTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        //dateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        //dateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dateTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dateTextField.bottomAnchor.constraint(equalTo: lightPurpleBackgroundView.bottomAnchor).isActive = true
        */
        
        /*
        view.addSubview(appDescrLabel)
        appDescrLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        appDescrLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        appDescrLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        appDescrLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // nameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        // nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        */
        
        
        view.addSubview(notesField)
        notesField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        //applicationDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notesField.bottomAnchor.constraint(equalTo: lightPurpleBackgroundView.bottomAnchor).isActive = true
        //applicationDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        notesField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        notesField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        //applicationDescription.heightAnchor.constraint(equalToConstant: 300).isActive = true
        notesField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notesField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
 
        

        
    }
    
    
}
