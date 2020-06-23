//
//  RatingViewController.swift
//  Trim
//
//  Created by Shane Nelson on 6/21/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import UIKit
import RxSwift

class RatingViewController: UIViewController {
    
    private let store = RatingViewControllerStore()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var pointsUsedLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
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
        self.backgroundView.backgroundColor = .trimGreen
        overrideUserInterfaceStyle = .light
        backgroundView.layer.cornerRadius = 2
        pointsUsedLabel.text = "0"
    }
    
    @IBAction func saveButtonTap(_ sender: Any) {
        if pointsAreValid() {
            saveInfo()
        } else {
            showAlert(title: "Error", message: "Points Cannot be greater than 50.", navigateOnCompletion: false)
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    func saveInfo() {
        store.saveUserInfoToFirebase(uikit: uikitTextField.text ?? "0",
            modularDevelopment: modularDevelopmentTextField.text ?? "0",
            memoryManagement: memoryManagementTextField.text ?? "0",
            testing: testingTextField.text ?? "0",
            coreData: coreDataTextField.text ?? "0",
            debugging: debuggingTextField.text ?? "0",
            swiftUI: SwiftUITextField.text ?? "0",
            problemSolving: problemSolvingTextField.text ?? "0",
            workingOnTeam: workingOnTeamTextField.text ?? "0",
            selfMotivation: selfMotivationTextField.text ?? "0",
            communication: communicationSkillsTextField.text ?? "0",
            energyLevel: energyLevelTextField.text ?? "0",
            intelligence: intelligenceTextField.text ?? "0").subscribe(onNext: { _ in
                
            }, onError: { error in
                self.render(.errorSaving(error))
            }, onCompleted: {
                self.render(.userSaved)
            }) {
                print("Disposed of the Garbage ;)")
        }.disposed(by: disposeBag)
    }
    
    func setTextFieldDelegates() {
        let textFields = getAllTextFields(fromView: self.view)
        textFields.forEach({ textField in
            textField.delegate = self
        })
    }
    
    // Getting all the textfields prove to be a common need. this helper gets all the textfield from a given view. 
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.compactMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
        }.flatMap({$0})
    }
    
    func updatePointsUsed() {
        pointsUsedLabel.text = ""
        var textFieldTextAsIntArray: [Int] = []
        
        let textfields = getAllTextFields(fromView: self.view)
        textfields.forEach({ textfield in
            if let text = textfield.text {
                if let textAsNumber = Int(text) {
                    textFieldTextAsIntArray.insert(textAsNumber, at: 0)
                }
            }
        })
        let pointsUsed = textFieldTextAsIntArray.reduce(0, +)
        pointsUsedLabel.text = "\(pointsUsed)"
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
            
            
            submitViewController.user = User(id: "",
                                             coreData: coreDataTextField.text ?? "0",
                                             uiKit: uikitTextField.text ?? "0",
                                             email: "",
                                             name: "",
                                             projectUrl: "",
                                             modularDevelopment: modularDevelopmentTextField.text ?? "0",
                                             memoryManagement: memoryManagementTextField.text ?? "0",
                                             testing: testingTextField.text ?? "0",
                                             debugging: debuggingTextField.text ?? "0",
                                             swiftUI: SwiftUITextField.text ?? "0",
                                             problemSolving: problemSolvingTextField.text ?? "0",
                                             workingOnTeam: workingOnTeamTextField.text ?? "0",
                                             selfMotivation: selfMotivationTextField.text ?? "0",
                                             communication: communicationSkillsTextField.text ?? "0",
                                             energyLevel: energyLevelTextField.text ?? "0",
                                             intelligence: intelligenceTextField.text ?? "0")
            
            submitViewController.modalPresentationStyle = .fullScreen
            self.present(submitViewController, animated: true, completion: nil)
        } else {
            preconditionFailure("Could not navigate to SubmitViewController")
        }
    }
    
    func showAlert(title: String, message: String, navigateOnCompletion: Bool) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        if !navigateOnCompletion {
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        } else {
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { _ in
                self.navigateToSubmitViewController()
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RatingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updatePointsUsed()
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
        case .userSaved:
            showAlert(title: "Success", message: "User successfully saved", navigateOnCompletion: true)
        case .errorSaving(let error):
            showAlert(title: "Error", message: "Unable to save user with error \(error)", navigateOnCompletion: false)
        }
    }
}
