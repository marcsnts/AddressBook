//
//  ContactDetailsViewController.swift
//  AddressBook
//
//  Created by Marc Santos on 2017-01-23.
//  Copyright © 2017 Marc Santos. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedContact: Contact?
    
    var tableView: UITableView = UITableView()
   
    //let nameRow = 0
    let phoneRow = 0
    let cellRow = 1
    let addressRow = 0
    let sectionTitles = ["Contact Information", "Address"]
    let sectionRows = [["phone", "cell"],["address"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let first = selectedContact?.first, let last = selectedContact?.last {
            title = "\(first) \(last)"
        }
        
        tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionRows[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  sectionTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        switch indexPath.section {
        //Contact information
        case 0:
            switch indexPath.row {
            case phoneRow:
                cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
                cell?.textLabel?.text = "Phone"
                cell?.detailTextLabel?.text = selectedContact?.phone
            case cellRow:
                cell = UITableViewCell(style: .value2, reuseIdentifier: nil)
                cell?.textLabel?.text = "Cell"
                cell?.detailTextLabel?.text = selectedContact?.cell
            default: break
            }
        //Address
        case 1:
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell?.textLabel?.text = selectedContact?.street
            if let city = selectedContact?.city, let state = selectedContact?.state {
                cell?.detailTextLabel?.text = "\(city), \(state)"
            }
        default: break
        }
        
        cell?.selectionStyle = .none

        return cell ?? UITableViewCell(style: .default, reuseIdentifier: nil)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        selectedContact = nil
    }

}
