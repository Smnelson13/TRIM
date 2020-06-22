//
//  SMMailComposeViewController.swift
//  Trim
//
//  Created by Shane Nelson on 6/22/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import MessageUI

class SMMailComposeViewController: MFMailComposeViewController {
    
    init(recepients: [String]?, subject: String = "", messageBody: String = "", messageBodyIsHTML: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        setToRecipients(recepients)
        setSubject(subject)
        setMessageBody(messageBody, isHTML: messageBodyIsHTML)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
