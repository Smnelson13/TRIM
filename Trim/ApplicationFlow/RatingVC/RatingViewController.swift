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
    private let store = RatingViewControllerStore()
    
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
        self.setTextFieldDelegates()
    }
    
    func setupUI() {
        backgroundView.layer.cornerRadius = 2
        pointsRemainingTextField.isUserInteractionEnabled = false
        pointsRemainingTextField.text = "50"
    }
    
    @IBAction func saveButtonTap(_ sender: Any) {
//        self.view.isUserInteractionEnabled = false
//
//        if pointsAreValid() {
//            print("Points are valid")
//            saveInfo()
//        } else {
//            showAlert(title: "Error", message: "Points Cannot be greater than 50.")
//        }
        navigateToSubmitViewController()
    }
    
    func saveInfo() {
        store.saveTextFieldInfo(uikit: uikitTextField.text ?? "",
                                modularDevelopment: modularDevelopmentTextField.text ?? "",
                                memoryManagement: memoryManagementTextField.text ?? "",
                                testing: testingTextField.text ?? "",
                                coreData: coreDataTextField.text ?? "",
                                debugging: debuggingTextField.text ?? "",
                                problemSolving: problemSolvingTextField.text ?? "",
                                swiftUI: SwiftUITextField.text ?? "",
                                workingOnTeam: workingOnTeamTextField.text ?? "",
                                selfMotivation: selfMotivationTextField.text ?? "",
                                communication: communicationSkillsTextField.text ?? "",
                                energyLevel: energyLevelTextField.text ?? "",
                                intelligence: intelligenceTextField.text ?? "", handler: { handler in
                                    self.render(handler)
        })
    }
    
    func setTextFieldDelegates() {
        let textFields = getAllTextFields(fromView: self.view)
        textFields.forEach({ textField in
            textField.delegate = self
        })
    }
    
    // Shared function use for setting delegates and updating the remaining points.
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
        var textFieldTextAsIntArray: [Int] = []
        //textFieldTextAsIntArray = [] // Reset the array each time.
        pointsRemaining = 0
        
        let textFields = getAllTextFields(fromView: self.view)
        
        textFields.forEach({ textField in
            if let text = textField.text {
                if let textAsNumber = Int(text) {
                    textFieldTextAsIntArray.insert(textAsNumber, at: 0)
                }
//                else {
//                    print("Failed to cast string as Int.")
//                }
            }
        })
        let sumOfTextFields = (50 - textFieldTextAsIntArray.reduce(0, +))
        pointsRemainingTextField.text = "\(sumOfTextFields)"
        //pointsRemaining = sumOfTextFields
    }
    
    func pointsAreValid() -> Bool {
        var textFieldValues: [Int] = []
        let textFields = getAllTextFields(fromView: self.view)
        
        textFields.forEach({ textField in
            if let text = textField.text {
                if let textAsNumber = Int(text) {
                    textFieldValues.insert(textAsNumber, at: 0)
                }
            }
        })
        
        let sumOfTextFieldValues = textFieldValues.reduce(0, +)
        
        if sumOfTextFieldValues > 50 {
            return false
        }
        return true
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
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RatingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
        
        self.view.isUserInteractionEnabled = true
        
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
