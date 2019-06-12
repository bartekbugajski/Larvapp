//
//  EditApplicationDetailsControllerExtensions.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 28/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import CoreData
import UIKit

extension EditApplicationDetailsController: UITextViewDelegate {
    func didAddApplicationEditController(application: Application) { }
    func didEditApplicationEditController(application: Application) { }
    
    /*
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
     dismiss(animated: true, completion: nil)
     }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     print(info)
     if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
     applicationImageView.image = editedImage
     } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
     applicationImageView.image = originalImage
     }
     dismiss(animated: true, completion: nil)
     }
     */
    /*
    func textViewDidChange(_ textView: UITextView) {
        print(notesField.text ?? nil!)
}
    */
    
    func saveApplicationChanges() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        application?.name = nameTextField.text
        application?.notes = notesField.text
        //application?.created = dateTextField.text
        
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
        let application = NSEntityDescription.insertNewObject(forEntityName: "Application", into: context)
        application.setValue(nameTextField.text, forKey: "name")
        application.setValue(notesField.text, forKey: "notes")
        application.setValue(dateTextField, forKey: "created")
        // here I should add the created date application.setValue(nameTextField.text, forKey: "name")
        // if let applicationImage = applicationImageView.image {
        //      let imageData = applicationImage.jpegData(compressionQuality: 0.9)
        //      application.setValue(imageData, forKey: "imageData")
        //    }
        //perform the save
        do {
            try context.save()
            //success
            dismiss(animated: true, completion: {
                self.delegate?.didAddApplication(application: application as! Application)
            })
        } catch let saveErr {
            print("Failed to save company", saveErr)
        }
    }
    
    
    func setupUI() {
        //let lightPurpleBackgroundView = setupLightPurpleBackgroundView(height: 350)
        view.addSubview(applicationImageView)
        applicationImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        applicationImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        applicationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        applicationImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: applicationImageView.bottomAnchor, constant: 10).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //nameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        /*
        view.addSubview()
        displayDate.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        displayDate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        displayDate.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        displayDate.heightAnchor.constraint(equalToConstant: 10).isActive = true
        displayDate.widthAnchor.constraint(equalToConstant: 40).isActive = true
        //displayDate.bottomAnchor.constraint(equalTo: lightPurpleBackgroundView.bottomAnchor).isActive = true
        */
        
        /*
        view.addSubview(dateTextField)
        dateTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        //dateTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        //dateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
        dateTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //displayDate.bottomAnchor.constraint(equalTo: lightPurpleBackgroundView.bottomAnchor).isActive = true
         */
        
        view.addSubview(quickNotesField)
        quickNotesField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        quickNotesField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        quickNotesField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        quickNotesField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // nameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        // nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        /*
        view.addSubview(notesField)
        notesField.topAnchor.constraint(equalTo: quickNotesField.bottomAnchor, constant: 10).isActive = true
       // notesField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
       //notesField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        //applicationDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //applicationDescription.bottomAnchor.constraint(equalTo: lightPurpleBackgroundView.bottomAnchor).isActive = true
        //notesField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        notesField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        //notesField.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //applicationDescription.heightAnchor.constraint(equalToConstant: 300).isActive = true
        */
        
    }
    
    
}
 
