//
//  SubmitViewControllerStore.swift
//  Trim
//
//  Created by Shane Nelson on 6/22/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import Foundation
import Firebase
import RxSwift


class SubmitViewControllerStore {
    
    typealias Handler = (SubmitViewControllerState) -> Void
    var db = Firestore.firestore()
    let disposeBag = DisposeBag()
    
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
    
    func saveUserInfoToFirebase(name: String, projectRepo: String, projectUrl: String) -> Observable<Bool> {
        
        let dictionary = [
            "Name": name,
            "Project Repo": projectRepo,
            "ProjectURL": projectUrl
        ]
        
        return Observable.create { observer in
            guard let userId = Auth.auth().currentUser?.uid else {
                return Disposables.create()
            }
            self.db.collection("users").document(userId).setData(dictionary) { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
}
