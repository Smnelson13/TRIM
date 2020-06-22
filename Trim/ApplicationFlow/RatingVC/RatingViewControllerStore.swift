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

class RatingViewControllerStore {
    
    typealias Handler = (RatingViewController) -> Void
    let auth = Auth.auth()
    let ref = Database.database().reference()
    
    
    func saveTextFieldInfo(withRating uikit: Int,
                           withRating modularDevelopment: Int,
                           withRating memoryManagement: Int,
                           withRating testing: Int,
                           withRating coreData: Int,
                           withRating debugging: Int,
                           withRating problemSolving: Int,
                           withRating swiftUI: Int,
                           withRating workingOnTeam: Int,
                           withRating selfMotivation: Int,
                           withRating communication: Int,
                           withRating energyLevel: Int,
                           withRating intelligence: Int,
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
