//
//  User.swift
//  Trim
//
//  Created by Shane Nelson on 6/23/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

class User: Codable {
    
    let id: String
    let coreData: String
    let uiKit: String
    let email: String
    let name: String
    let projectUrl: String
    let modularDevelopment: String
    let memoryManagement: String
    let testing: String
    let debugging: String
    let swiftUI: String
    let problemSolving: String
    let workingOnTeam: String
    let selfMotivation: String
    let communication: String
    let energyLevel: String
    let intelligence: String
    
    init(id: String, coreData: String, uiKit: String, email: String, name: String, projectUrl: String, modularDevelopment: String, memoryManagement: String, testing: String, debugging: String, swiftUI: String, problemSolving: String, workingOnTeam: String, selfMotivation: String, communication: String, energyLevel: String, intelligence: String) {
        self.id = id
        self.coreData = coreData
        self.uiKit = uiKit
        self.email = email
        self.name = name
        self.projectUrl = projectUrl
        self.modularDevelopment = modularDevelopment
        self.memoryManagement = memoryManagement
        self.testing = testing
        self.debugging = debugging
        self.swiftUI = swiftUI
        self.problemSolving = problemSolving
        self.workingOnTeam = workingOnTeam
        self.selfMotivation = selfMotivation
        self.communication = communication
        self.energyLevel = energyLevel
        self.intelligence = intelligence
    
    }
}
