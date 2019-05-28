//
//  ApplicationCell.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 16/02/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import UIKit

class ApplicationCell: UITableViewCell {
    
    var application: Application? {
    didSet {
        nameCreatedDateLabel.text = application?.name
        
      //  if let imageData = application?.imageData {
      //   applicationImageView.image = UIImage(data: imageData)
         
       //  }
        
        if let name = application?.name { //} let created = application.created {
            // MM, dd, yyyy
            // let dateFormatter = DateFormatter()
            // dateFormatter.dateFormat = "MM/yyyy"
            // let createdDateString = dateFormatter.string(from: created)
            let nameString = "\(name)" // " from \(createdDateString)"
            nameCreatedDateLabel.text = nameString
             } else {
            nameCreatedDateLabel.text = application?.name
        
        }
    }
}
    
    //can't declare another imageView because UITableViewCell's already have a property like that
    let applicationImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "think"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 0
        
        return imageView
    }()
    
    let nameCreatedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Application Name"
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = .defaultFont
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .cellColor
        
    
        addSubview(applicationImageView)
        applicationImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        applicationImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        applicationImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        applicationImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nameCreatedDateLabel)
        nameCreatedDateLabel.leftAnchor.constraint(equalTo: applicationImageView.rightAnchor, constant: 8).isActive = true
        nameCreatedDateLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        nameCreatedDateLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nameCreatedDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



