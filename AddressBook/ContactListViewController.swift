//
//  ContactListViewController.swift
//  AddressBook
//
//  Created by Marc Santos on 2017-01-20.
//  Copyright © 2017 Marc Santos. All rights reserved.
//

import UIKit
import SwiftyJSON

class ContactListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView = UITableView()
    var contacts : [Contact] = []
    var selectedContact: Contact?
    let detailsSegueIdentifier = "ContactDetails"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"
        getContacts()
        
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
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
 
        let contact = contacts[indexPath.row]

        if let picture = contact.picture {
            let url = URL(string: picture)
            let data = try? Data(contentsOf: url!)
            cell.imageView?.image = UIImage(data: data!)
        }
        
        if let first = contact.first, let last = contact.last {
            cell.textLabel!.text = "\(first) \(last)"
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedContact = contacts[indexPath.row]
        performSegue(withIdentifier: detailsSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailsSegueIdentifier {
            let detailsVC = segue.destination as! ContactDetailsViewController
            detailsVC.selectedContact = selectedContact
        }
        
    }
    
    func getContacts() {
        NetworkRequest.getRandomUsers(numberOfUsers: Constants.DEFAULT_NUMBER_CONTACTS, successHandler: { (json: JSON) in
            for i in 0..<json["results"].count {
                let result = json["results"][i]
                
                let contact = Contact(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
                
                contact.picture = result["picture"]["medium"].string
                
                let location = result["location"]
                contact.city = location["city"].string?.capitalized
                contact.postcode =  location["postcode"].string?.capitalized
                contact.state = location["state"].string?.capitalized
                contact.street = location["street"].string?.capitalized
                
                let name = result["name"]
                contact.title = name["title"].string?.capitalized
                contact.first = name["first"].string?.capitalized
                contact.last = name["last"].string?.capitalized
                
                contact.phone = result["phone"].string
                contact.cell = result["cell"].string
                contact.gender = result["gender"].string?.capitalized
                contact.dob = result["dob"].string
                
                //(UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            do {
                self.contacts = try (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext.fetch(Contact.fetchRequest())
            } catch {
                print("Failed to retrieve contacts")
            }
            
            self.tableView.reloadData()
            
        })
    }
}

