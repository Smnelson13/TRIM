//
//  SubmitViewController.swift
//  Trim
//
//  Created by Shane Nelson on 6/22/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import UIKit
import MessageUI

class SubmitViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitButtonTap(_ sender: Any) {
        //showMailComposeViewController()
        launchMailComposeViewController()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["you@yoursite.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func launchMailComposeViewController() {
        if MFMailComposeViewController.canSendMail() {
            let controller = SMMailComposeViewController(recepients: ["swiftyshane@gmail.com"], subject: "Shane Nelson Coding Challenge", messageBody: "Body", messageBodyIsHTML: false)
            controller.mailComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
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

