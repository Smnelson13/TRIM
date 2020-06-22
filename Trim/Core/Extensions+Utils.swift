//
//  Extensions+Utils.swift
//  Trim
//
//  Created by Shane Nelson on 6/21/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import Foundation

extension UserDefaults {

    // Because user default keys are string literals, this helps ensure there are no misstypes.
    enum Keys: String {
        case userId
    }
}
