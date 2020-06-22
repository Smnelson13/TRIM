//
//  CreateAccountViewControllerStore.swift
//  Trim
//
//  Created by Shane Nelson on 6/21/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import Foundation
import FirebaseAuth

class CreateAccountStore {
    
    typealias Handler = (CreateAccountViewControllerState) -> Void
    let defaults = UserDefaults.standard
    
    func createUser(withEmail email: String, withPassword password: String, handler: @escaping Handler) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            if let error = error {
                switch (error as NSError).code {
                case 17007: // Error code Google Firebase returns if a user with that email already exists.
                    handler(.userAlreadyExists)
                case 17008: // Same as above
                    handler(.invalidEmail)
                case 8196:
                    handler(.invalidPassword)
                default:
                    print(error.localizedDescription)
                }
            }
            else if let user = result?.user {
                let key = UserDefaults.Keys.userId.rawValue
                self.defaults.set(user.uid, forKey: key)
                handler(.userCreated)
            }
        })
    }
}
