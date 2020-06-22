//
//  RatingViewController.swift
//  Trim
//
//  Created by Shane Nelson on 6/21/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        backgroundView.layer.cornerRadius = 2
    }

}

extension RatingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

//MARK: - Render
private extension RatingViewController {
    func render(_ state: RatingViewControllerState) {
        switch state {
        case .saving:
            break
        case .saved:
            break
        case .errorSaving(let error):
            print(error.localizedDescription)
        }
    }
}
