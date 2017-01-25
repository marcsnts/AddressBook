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
   
    let nameRow = 0
    let phoneRow = 1
    let cellRow = 2
    let addressRow = 3
    
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        
        cell.selectionStyle = .none

        switch indexPath.row {
        case nameRow:
            if let first = selectedContact?.first, let last = selectedContact?.last {
                cell.textLabel?.text = "\(first) \(last)"
            }
        case phoneRow:
            cell.textLabel?.text = selectedContact?.phone
        case cellRow:
            cell.textLabel?.text = selectedContact?.cell
        case addressRow:
            cell.textLabel?.text = selectedContact?.street
            if let city = selectedContact?.city, let state = selectedContact?.state {
                cell.detailTextLabel?.text = "\(city), \(state)"
            }
        default:
            break
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        selectedContact = nil
    }

}
