//
//  UserListModel.swift
//  ShankarSystemTask
//
//  Created by Sridhar Karnatapu on 06/06/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit
import CoreData
class UserListModel: NSObject {
    
    var name : String!
    var userName : String!
    var emailid : String!
    var companyName : String! 
    var profileImage : String!
    override init() {
        super.init()
    }
    convenience init(withDict dict: NSDictionary){
        self.init()
        name = (dict.value(forKey: "name") as? String)
        userName = (dict.value(forKey: "username") as? String)
        emailid = (dict.value(forKey: "email") as? String)
        if (dict.object(forKey: "company") is NSDictionary){
            let CompanyDict = (dict.object(forKey: "company") as! NSDictionary)
            companyName = (CompanyDict.value(forKey: "name") as? String)
        }
        profileImage = (dict.value(forKey: "profile_image") as? String)
        
    }
    
    convenience init(withManagedObject Object: NSManagedObject){
        self.init()
        name = (Object.value(forKey: "name") as? String)
        userName = (Object.value(forKey: "username") as? String)
        emailid = (Object.value(forKey: "emailid") as? String)
        companyName = (Object.value(forKey: "companyname") as? String)
        profileImage = (Object.value(forKey: "profileimage") as? String)
        
    }
}
