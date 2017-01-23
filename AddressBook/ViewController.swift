//
//  ViewController.swift
//  AddressBook
//
//  Created by Marc Santos on 2017-01-20.
//  Copyright © 2017 Marc Santos. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView = UITableView()
    var contacts : [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        lmao()
        
        tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = contacts[indexPath.row].first
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(contacts[indexPath.row].first!)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func lmao() {
        NetworkRequest.getRandomUsers(numberOfUsers: 3, successHandler: { (json: JSON) in
            for i in 0..<json["results"].count {
                let result = json["results"][i]
                
                let contact = Contact(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
                let location = result["location"]
                contact.city = location["city"].string
                contact.postcode =  location["postcode"].string
                contact.state = location["state"].string
                contact.street = location["street"].string
                
                let name = result["name"]
                contact.title = name["title"].string
                contact.first = name["first"].string
                contact.last = name["last"].string
                
                contact.phone = result["phone"].string
                contact.cell = result["cell"].string
                contact.gender = result["gender"].string
                contact.dob = result["dob"].string
                
                print(contact.first)
                //(UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            do {
                self.contacts = try (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext.fetch(Contact.fetchRequest())
            } catch {
                print("failed")
            }
            
            self.tableView.reloadData()
            
        })
    }
}

