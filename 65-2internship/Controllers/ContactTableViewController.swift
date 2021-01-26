//
//  ContactTableViewController.swift
//  65-2internship
//
//  Created by Kisa Shket on 29.10.2020.
//  Copyright © 2020 Kisa Shket. All rights reserved.
//

import UIKit
import SDWebImage
class ContactTableViewController: UITableViewController {
    
    let service = GoogleService()
    
    var viewModel: ContactTableViewModel?{
        didSet{
            viewModel?.fetchContacts{ (_) in
                DispatchQueue.main.async {
                    [weak self] in
                    print("ViewModel set")
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Контакты 65apps"
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfContacts() ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "contactCell") as! ContactTableViewCell
        
        viewModel?.dynamicContact.bindAndFire{ contact in
            cell.contactName.text = contact[indexPath.row]?.fullName
            cell.contactMail.text = contact[indexPath.row]?.eMail
            cell.contactNumber.text = contact[indexPath.row]?.phoneNumber
            cell.contactImage.sd_setImage(with: contact[indexPath.row]?.imgUrl, placeholderImage: UIImage(named: "Image"), options: .allowInvalidSSLCertificates, completed: nil)
        }
        return cell
    }
    
    @IBAction func signOut(_ sender: Any) {
        self.service.signOut()
        print("signed out")
        dismiss(animated: true, completion: nil)
    }
}
