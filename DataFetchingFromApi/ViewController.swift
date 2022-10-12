//
//  ViewController.swift
//  DataFetchingFromApi
//
//  Created by Aishwarya Phatak on 11/07/22.
//  Copyright © 2022 Aishwarya Phatak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var urlTableView: UITableView!
    
    var fetchedData = [FetchedData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTableView.dataSource = self
        urlTableView.delegate = self
        
        //Get the path
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        
        //get url
        guard let url = URL(string: urlString) else{
            print("URL Invalid")
            return
        }
        
        //request & method of request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //URL session
        let session = URLSession(configuration: .default)
        
        //data Task
        let dataTask = session.dataTask(with: request) { data, response, error in
            
             print("The error is \(error)")
             print("The Data is \(data)")
            
            guard let data  = data else{
               print("Data Not found")
                return
            }
            
            guard let getJsonObject = try? JSONSerialization.jsonObject(with: data) as! [[String : Any]] else{
                print("JSON Not Found")
                return
            }
            
            for dictionary in getJsonObject
            {
                let eachDictionary = dictionary as [String : Any]
                let pId = eachDictionary["id"] as! Int
                let pTitle = eachDictionary["title"] as! String
                let pBody = eachDictionary["body"] as! String
                
                let newData = FetchedData(postId: pId, postTitle: pTitle, postBody: pBody)
                self.fetchedData.append(newData)
            }
                DispatchQueue.main.async {
                       self.urlTableView.reloadData()
            }
        }
        dataTask.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedData.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.urlTableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        
        let pId = String(fetchedData[indexPath.row].postId)
        let pTitle = fetchedData[indexPath.row].postTitle
        let pBody = fetchedData[indexPath.row].postBody
    
        cell.idLabel.text = String(pId)
        cell.titleLabel.text = pTitle
        cell.bodyLabel.text = pBody
        
        return cell
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}
