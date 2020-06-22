//
//  RatingViewControllerState.swift
//  Trim
//
//  Created by Shane Nelson on 6/22/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import Foundation

enum RatingViewControllerState {
    case saving
    case saved
    case errorSaving(Error)
}
