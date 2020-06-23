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
    //let ref = Database.database().reference(
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
        
//        guard let userId = auth.currentUser else {
//            return
//        }
        var ref: DocumentReference? = nil
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
        
        ref = db.collection("users").addDocument(data: dict) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Created")
            }
        }
    }
    
//    func createUser(
//      name: String,
//      age: Int,
//      gender: String,
//      hobbies: String,
//      profileImage: Data?,
//      onFinish: @escaping () -> (),
//      onError: @escaping (Error) -> ()) {
//
//      let timeStamp = Int(Date().timeIntervalSince1970)
//      let userId = timeStamp
//      UIApplication.shared.isNetworkActivityIndicatorVisible = true
//      let docRef = self.usersTable.document("\(userId)")
//      docRef.getDocument { (document, error) in
//        docRef.setData([
//          "name": name,
//          "age": age,
//          "gender": gender,
//          "id": userId,
//          "hobbies": hobbies,
//          ]) { err in
//            if let err = err {
//              print("Error adding document: \(err)")
//              onError(err)
//            } else {
//              onFinish()
//              if let image = profileImage {
//                image.uploadToFirebaseStorage(
//                  withFileName: "profileImages/\(userId).jpg",
//                  onFinish: { metadata in
//                    print("image uploaded", metadata)
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                }, onError: { error in
//                  print("image failed to upload", error)
//                })
//              }
//            }
//        }
//      }
//    }
    
}

