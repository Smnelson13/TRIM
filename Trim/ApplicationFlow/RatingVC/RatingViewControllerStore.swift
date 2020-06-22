//
//  RatingViewControllerStore.swift
//  Trim
//
//  Created by Shane Nelson on 6/22/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import RxSwift

class RatingViewControllerStore {
    
    typealias Handler = (RatingViewControllerState) -> Void
    let auth = Auth.auth()
    let ref = Database.database().reference()
    
    
    func saveTextFieldInfo(_ user: User) -> Observable<User> {
        guard let userId = auth.currentUser?.uid else {
            return Observable.error(RxError.noElements)
        }
        return Observable.create { observer in
            
        }
    }
}


/*
 func saveTextFieldInfo(uikit: String,
                     modularDevelopment: String,
                     memoryManagement: String,
                     testing: String,
                     coreData: String,
                     debugging: String,
                     problemSolving: String,
                     swiftUI: String,
                     workingOnTeam: String,
                     selfMotivation: String,
                     communication: String,
                     energyLevel: String,
                     intelligence: String) -> Observable<User> {
     
     guard let userId = auth.currentUser?.uid else {
         return Observable.error(RxError.noElements)
     }
 }
 */
