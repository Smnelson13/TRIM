//
//  SubmitViewController.swift
//  Trim
//
//  Created by Shane Nelson on 6/22/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import UIKit
import MessageUI

class SubmitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonTap(_ sender: Any) {
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
            self.present(controller, animated: true, completion: nil)
        }
    }
    

}

//MARK: - Render
extension SubmitViewController {

}


extension SubmitViewController: MFMailComposeViewControllerDelegate {
    
}
