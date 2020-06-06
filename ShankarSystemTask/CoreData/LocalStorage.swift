//
//  LocalStorage.swift
//  ShankarSystemTask
//
//  Created by Sridhar Karnatapu on 06/06/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class LocalStorage: NSObject {
    
   
    var localStoredDataArray : [UserListModel] = [UserListModel]()
    func saveDataToCoreData(responseData: [UserListModel]) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WhiteRabbit", in: context)
        for userList in responseData {
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(userList.userName, forKey: "username")
            newUser.setValue(userList.name, forKey: "name")
            newUser.setValue(userList.emailid, forKey: "emailid")
            newUser.setValue(userList.profileImage, forKey: "profileimage")
            newUser.setValue(userList.companyName, forKey: "companyname")
        }
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func fetechDataFromCoreData(finished: () -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WhiteRabbit")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
               let userData = UserListModel.init(withManagedObject: data)
               self.localStoredDataArray.append(userData)
            }
              finished()
        } catch {
            print("Failed")
        }
    }
    
}
