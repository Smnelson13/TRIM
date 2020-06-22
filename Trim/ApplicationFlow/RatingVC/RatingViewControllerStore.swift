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
                        intelligence: String,
                           handler: @escaping Handler) {
        
        guard let userId = auth.currentUser?.uid else {
            return
        }
        ref.child(userId).setValuesForKeys(["UIKit": uikit,
                                            "Modular development": modularDevelopment,
                                            "Memory Management (ARC)": memoryManagement,
                                            "Testing": testing,
                                            "Core Data": coreData,
                                            "Debugging": debugging,
                                            "Problem Solving": problemSolving,
                                            "SwiftUI / Combine": swiftUI,
                                            "Working on a team": workingOnTeam,
                                            "Self Motivation": selfMotivation,
                                            "Communication": communication,
                                            "Energy Level": energyLevel,
            "Intelligence": intelligence])
    }
}
