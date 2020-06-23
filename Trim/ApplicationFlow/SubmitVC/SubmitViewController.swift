//
//  SubmitViewController.swift
//  Trim
//
//  Created by Shane Nelson on 6/22/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import UIKit
import MessageUI
import FirebaseAuth

class SubmitViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var projectRepoTextField: UITextField!
    @IBOutlet weak var projectUrlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        setDelegates()
        prepopulateTextFields()
    }
    
    @IBAction func submitButtonTap(_ sender: Any) {
        if textFieldsSatisfied() {
            launchMailComposeViewController()
        } else {
            showAlert(title: "Error", message: "One or more TextFields is missing info. ")
        }
    }
    
    func textFieldsSatisfied() -> Bool {
        if emailTextField.text != "",
            nameTextField.text != "",
            projectUrlTextField.text != "",
            projectRepoTextField.text != "" {
            return true
        }
        return false
    }
    
    func prepopulateTextFields() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        emailTextField.text = user.email
        projectRepoTextField.text = "What?"
        projectUrlTextField.text = "https://github.com/Smnelson13/TRIM/tree/develop"
    }
    
    func setDelegates() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        projectUrlTextField.delegate = self
        projectRepoTextField.delegate = self
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func launchMailComposeViewController() {
        if MFMailComposeViewController.canSendMail() {
            let controller = SMMailComposeViewController(recepients: ["swiftyshane@gmail.com"], subject: "Shane Nelson Coding Challenge", messageBody: "Body", messageBodyIsHTML: false)
            controller.mailComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            showAlert(title: "Error", message: "Device cannot send emails.")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

//MARK: - MailComposeDelegate
extension SubmitViewController: MFMailComposeViewControllerDelegate {
   
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            showAlert(title: "Success", message: "Your email / Submission has succeffully been sent, good luck candidate.")
        case .failed:
            showAlert(title: "Error", message: "Unable to send email.")
        @unknown default:
            print("Unknown default occurred.")
        }
        
        if let error = error {
            print(error.localizedDescription)
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

//MARK: - TextFieldDelegate
extension SubmitViewController: UITextFieldDelegate {
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
extension SubmitViewController {
    func render(_ state: SubmitViewControllerState) {
        switch state {
        case .submitError(_):
            break
        case .submitSuccess:
            break
        }
    }
}

