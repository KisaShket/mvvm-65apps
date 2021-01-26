//
//  Networker.swift
//  65-2internship
//
//  Created by Kisa Shket on 01.11.2020.
//  Copyright © 2020 Kisa Shket. All rights reserved.
//

import Foundation
import GoogleSignIn

class Networker {
    private let service = GoogleService()
    private let urlComponents = URLComponents()
    private var contactsURL: URL?
    var images: [UIImageView] = []
    
    private func request(completion: @escaping (Result<Data,Error>)->()) {
        guard let token = service.getAccessToken() else { return }
        guard let url = createUrl(withAccessToken: token) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error{
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
    
    func fetchContacts(response: @escaping (ContactsModel?) -> ()) {
        request() { result in
            switch result {
            case .success(let data):
                do{
                    let contacts = try JSONDecoder()
                        .decode(ContactsModel.self, from: data)
                    response(contacts)
                    print("Fetched")
                    
                }catch let jsonError{
                    print("Decode failed:", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                response(nil)
            }
        }
    }
    
    private func createUrl(withAccessToken accessToken: String) -> URL?{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.google.com"
        components.path = "/m8/feeds/gal/65apps.com/full"
        components.queryItems = [
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "alt", value: "json")
        ]
        return components.url
    }
}
