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
    let disposeBag = DisposeBag()
    
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
                handler(.errorSaving(error))
            } else {
                handler(.userSaved)
                print("User Created")
            }
        }
    }
    
//    typealias Handler = (RatingViewControllerState) -> Void
//
//    func saveTextFieldInfo(name: String, handler: @escaping Handler) {
//
//        guard let userId = auth.currentUser?.uid else {
//            return
//        }
//        let dict: [String: String] = [
//            "Name": name
//        ]
//
//        db.collection("users").document(userId).setData(dict) { error in
//            if let error = error {
//                handler(.errorSaving(error))
//            } else {
//                handler(.userSaved)
//                print("User Created")
//            }
//        }
//    }
    
    
//    func observe(name: String) -> Single<RatingViewControllerState> {
//
//        let dictionary: [String: String] = [:]
//
//        return Single<RatingViewControllerState>.create(subscribe: { single in
//            guard let userId = Auth.auth().currentUser?.uid else {
//                return single(.error())
//            }
//            db.collection("users").document(userId)
//
//            return Disposables.create()
//        })
//
////        return Observable.create { observer in
////            db.collection("users").document("userId").setData(dictionary)
////        }
//    }
    
    
    func saveUserInfoToFirebase(uikit: String,
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
                         intelligence: String) -> Observable<Bool> {
                
            let dictionary: [String: String] = [
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
        
         return Observable.create { observer in
            guard let userId = Auth.auth().currentUser?.uid else {
                return Disposables.create()
            }
            self.db.collection("users").document(userId).setData(dictionary) { error in
                if let  error = error {
                    observer.onError(error)
                } else {
                    observer.onCompleted()
                }
            }
             return Disposables.create()
         }
     }

    
}

