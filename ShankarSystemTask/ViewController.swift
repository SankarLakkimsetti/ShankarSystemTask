//
//  ViewController.swift
//  ShankarSystemTask
//
//  Created by Shankar Lakkimsetti on 06/06/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var userDataArr : [UserListModel] = [UserListModel]()
    var localStorageInstance = LocalStorage()
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        getDataFromServer()
    }
    func getDataFromServer() {
        ServiceCalls.sharedInstance.getDataFromUrl(urlString: "http://www.mocky.io/v2/5d565297300000680030a986") { (success, data) in
            if (success){
                let dataArray = data as! [[String:AnyObject]]
                for dataDict in dataArray {
                    let userData = UserListModel.init(withDict: dataDict as NSDictionary)
                    self.userDataArr.append(userData)
                }
                self.saveDataToLocalData(dataArray: self.userDataArr)
            }
        }
    }
    func saveDataToLocalData(dataArray : [UserListModel] ) {
        DispatchQueue.main.async {
            self.localStorageInstance.saveDataToCoreData(responseData: dataArray)
            self.localStorageInstance.fetechDataFromCoreData {
                self.listTableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localStorageInstance.localStoredDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companylistcell", for: indexPath as IndexPath) as! CompanyListCell
        let data : UserListModel = localStorageInstance.localStoredDataArray[indexPath.row]
        if (data.profileImage != nil) {
            cell.imageView?.loadImageUsingCache(withUrl: data.profileImage)
        }
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 33
        cell.nameLabel.text = data.name!
        cell.companyNameLabel.text = (data.companyName != nil) ? data.companyName! : ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



