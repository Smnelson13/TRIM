//
//  CreateAccountViewControllerState.swift
//  Trim
//
//  Created by Shane Nelson on 6/21/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

enum CreateAccountViewControllerState {
    case userCreated
    case creatingUserFailure(Error)
    case invalidEmail
    case userAlreadyExists
    case invalidPassword
}

