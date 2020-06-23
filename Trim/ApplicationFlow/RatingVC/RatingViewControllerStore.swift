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
import Firebase

class RatingViewControllerStore {
    
    typealias Handler = (RatingViewControllerState) -> Void
    let auth = Auth.auth()
    var db = Firestore.firestore()
    
    func saveTextFieldInfo(uikit: String,
                        modularDevelopment: String,
                        memoryManagement: String,
                        testing: String,
                        coreData: String,
                        debugging: String,
                        swiftUI: String,
                        problemSolving: String,
                        workingOnTeam: String,
                        selfMotivation: String,
                        communication: String,
                        energyLevel: String,
                        intelligence: String, handler: @escaping Handler) {
        
        guard let userId = auth.currentUser?.uid else {
            return
        }
      //  var ref: DocumentReference? = nil
        let dict: [String: String] = [
            "Modular development": modularDevelopment,
            "Memory Management (ARC)": memoryManagement,
            "Testing": testing,
            "Core Data": coreData,
            "Debugging": debugging,
            "Problem Solving Skills": problemSolving,
            "SwiftUI / Combine": swiftUI,
            "Working on a team": workingOnTeam,
            "Self motivation": selfMotivation,
            "Communications skills": communication,
            "Your own energy level": energyLevel,
            "Intelligence / Aptitude": intelligence
        ]
        
        db.collection("users").document(userId).setData(dict) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Created")
            }
        }
        
        
        
//        ref = db.collection("users").addDocument(data: dict) { error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print("User Created")
//            }
//        }
    }
    
}

