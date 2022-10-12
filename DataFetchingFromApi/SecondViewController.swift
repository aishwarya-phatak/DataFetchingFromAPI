//
//  SecondViewController.swift
//  DataFetchingFromApi
//
//  Created by Aishwarya Phatak on 13/07/22.
//  Copyright © 2022 Aishwarya Phatak. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var urlTableView: UITableView!
    var fetchedInfo = [FetchedInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTableView.delegate = self
                      urlTableView.dataSource = self
        
        downloadJSON {
            self.urlTableView.reloadData()
          //  print("Successful")
        }
       
    }
    
    func downloadJSON(completed: @escaping () -> ()){
        //let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        
        let url = "https://jsonplaceholder.typicode.com/posts"
        let urlS = URL(string: url)
        URLSession.shared.dataTask(with: urlS!) { data, response, error in
            if (error == nil){
                do{
                    self.fetchedInfo = try JSONDecoder().decode([FetchedInfo].self, from : data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("Error")
                }
            }
        }.resume()
    }
}

extension SecondViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension SecondViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            
        cell.textLabel!.text = String(fetchedInfo[indexPath.row].id)

        return cell
    }
}
