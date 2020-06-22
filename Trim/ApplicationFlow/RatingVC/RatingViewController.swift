//
//  RatingViewController.swift
//  Trim
//
//  Created by Shane Nelson on 6/21/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    var pointsRemaining: Int?
    var textFieldTextAsIntArray: [Int]?

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var pointsRemainingTextField: UITextField!
    
    @IBOutlet weak var uikitTextField: UITextField!
    @IBOutlet weak var modularDevelopmentTextField: UITextField!
    @IBOutlet weak var memoryManagementTextField: UITextField!
    @IBOutlet weak var testingTextField: UITextField!
    @IBOutlet weak var coreDataTextField: UITextField!
    @IBOutlet weak var debuggingTextField: UITextField!
    @IBOutlet weak var problemSolvingTextField: UITextField!
    @IBOutlet weak var SwiftUITextField: UITextField!
    @IBOutlet weak var workingOnTeamTextField: UITextField!
    @IBOutlet weak var selfMotivationTextField: UITextField!
    @IBOutlet weak var communicationSkillsTextField: UITextField!
    @IBOutlet weak var energyLevelTextField: UITextField!
    @IBOutlet weak var intelligenceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        backgroundView.layer.cornerRadius = 2
        pointsRemainingTextField.isUserInteractionEnabled = false
    }
    
    @IBAction func saveButtonTap(_ sender: Any) {
        navigateToSubmitViewController()
    }
    
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.compactMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
        }.flatMap({$0})
    }
    
    func updatePointsRemaining() {
        textFieldTextAsIntArray = [] // Reset the array each time.
        pointsRemaining = 0
        
        let textFields = getAllTextFields(fromView: self.view)
        
        textFields.forEach({ textField in
            if let text = textField.text, var textFieldArray = textFieldTextAsIntArray {
                if let textAsNumber = Int(text) {
                    textFieldArray.insert(textAsNumber, at: 0)
                }
            }
        })
        let sumOfTextFields = textFieldTextAsIntArray?.reduce(0, +)
        pointsRemainingTextField.text = "\(String(describing: sumOfTextFields))"
        //pointsRemaining = sumOfTextFields
    }
    
    func navigateToSubmitViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let submitViewController = storyboard.instantiateViewController(withIdentifier: "SubmitViewController") as? SubmitViewController {
            submitViewController.modalPresentationStyle = .fullScreen
            self.present(submitViewController, animated: true, completion: nil)
        } else {
            preconditionFailure("Could not navigate to SubmitViewController")
        }
    }
    
}

extension RatingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updatePointsRemaining()
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
