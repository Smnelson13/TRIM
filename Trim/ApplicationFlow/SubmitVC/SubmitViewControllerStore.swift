//
//  SubmitViewControllerStore.swift
//  Trim
//
//  Created by Shane Nelson on 6/22/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import Foundation
import Firebase


class SubmitViewControllerStore {
    
    typealias Handler = (SubmitViewControllerState) -> Void
    
    func saveUserInfo(fullName: String, profectRepo: String, projectUrl: String, handler: @escaping Handler) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let dictionary: [String: String] = [
            "Full Name": fullName,
            "Project Repo": profectRepo,
            "Project URL": projectUrl
        ]
        
        Firestore.firestore().collection("users").document(userId).setData(dictionary) { error in
            if let error = error {
                handler(.submitError(error))
            } else {
                handler(.submitSuccess)
            }
        }
    }
    
}
