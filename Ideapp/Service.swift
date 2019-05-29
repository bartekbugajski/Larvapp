//
//  Service.swift
//  Ideapp
//
//  Created by Bartek Bugajski on 06/04/2019.
//  Copyright © 2019 Lightning Bulb. All rights reserved.
//

import Foundation
import CoreData
/*
struct Service {
    
    static let shared = Service()
    
    let urlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
    
    func downloadCompaniesFromServer(){
        print("Attempting to download companies.")
    
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to download companies:", err)
                return
            }
            
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            
            do {
            let jsonApplications = try jsonDecoder.decode([JSONApplication].self, from: data)
                let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                privateContext.parent = CoreDataManager.shared.persistentContainer.viewContext
                jsonApplications.forEach({ (jsonApplication) in
                    print(jsonApplication.name)
                    let application = Application(context: privateContext)
                    application.name = jsonApplication.name
                    
                    jsonApplication.tasks?.forEach({ (jsonTask) in
                        print("  \(jsonTask.name)")
                        
                        let task = Task(context: privateContext)
                        task.name = jsonTask.name
                        
                        task.application = application
                     })
                    
                    /*
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/MM/yyyy"
                    let dateCreated = dateFormatter.date(from: jsonApplication.created)
                    
                    application.created = dateCreated
                    */
                    do {
                        try privateContext.save()
                        try privateContext.parent?.save()
                        
                    } catch let saveErr {
                        print("Failed to save.", saveErr)
                    }
                })
                
            } catch let jsonDecoderErr {
                print("Failed to decode.", jsonDecoderErr)
            }
            
            print("Finished downloading.")
        }.resume() //please do not forget to make this call
    }
}

struct JSONApplication: Decodable {
    let name: String
    var tasks: [JSONTasks]?
}

struct JSONTasks: Decodable {
    let name: String
}
*/
