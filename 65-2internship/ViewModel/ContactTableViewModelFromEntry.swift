//
//  ContactTableViewModelFromEntry.swift
//  65-2internship
//
//  Created by Kisa Shket on 05.11.2020.
//  Copyright © 2020 Kisa Shket. All rights reserved.
//

import Foundation
import SDWebImage

protocol ContactTableViewModel {
    var dynamicContact: Dynamic<[ContactsData?]> { get }
    func fetchContacts(completionHandler: @escaping ([ContactsData?])->())
    func numberOfContacts()->Int
}

class ContactTableViewModelFromEntry: ContactTableViewModel {
    
    private let service = GoogleService()
    private let network = Networker()
    var dynamicContact: Dynamic<[ContactsData?]> = Dynamic([])
    
    init() {
    }
    
    func fetchContacts(completionHandler: @escaping ([ContactsData?])->()){
        let token = service.getAccessToken()
        var compData: [ContactsData?] = []
        network.fetchContacts { [self] contacts in
            let contact = contacts?.feed?.entry?.filter({type in type.profileType == "profile"})
            
            contact?.forEach{cont in
                compData.append(ContactsData.init(
                                    fullName: cont.fullName,
                                    eMail: cont.gdEmail?[0].address,
                                    phoneNumber: cont.gdPhoneNumber?[0].phoneNumber ?? "Телефон отсутствует.",
                                    imgUrl: URL(string: cont.link![0].href!+"?access_token=\(token!)")))
            }
            dynamicContact = Dynamic(compData)
            completionHandler(compData)
        }
    }
    
    func numberOfContacts()->Int {
        return dynamicContact.value.count
    }
}
