//
//  CreateAccountViewController.swift
//  Trim
//
//  Created by Shane Nelson on 6/21/20.
//  Copyright © 2020 Shane Nelson. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    private let store = CreateAccountStore()
    
    var userEmail: String?
    var userPassword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        setDelegates()
    }
    
    func setupUI() {
        backgroundView.layer.cornerRadius = 2
    }
    
//    init(store: CreateAccountStore) {
//        self.store = store
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        self.store = CreateAccountStore()
//        super.init(nibName: nil, bundle: nil)
//    }

    @IBAction func createAccountButtonTap(_ sender: Any) {
        createUser()
    }
    
    @IBAction func loginButtonTap(_ sender: Any) {
        navigateToRatingViewController()
    }
    
    func setDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    func createUser() {
        if textFieldsSatisfied() {
            // TODO - Add Spinner and disable user taps.
            if let email = userEmail, let password = userPassword {
                store.createUser(withEmail: email, withPassword: password, handler: { handler in
                    self.render(handler)
                })
            }
        } else {
            print("NOT Satisfied")
        }
    }
    
    func textFieldsSatisfied() -> Bool {
        if emailTextField.text != "" && passwordTextField.text == confirmPasswordTextField.text {
            // Capture the values
            userEmail = emailTextField.text
            userPassword = passwordTextField.text
            return true
        }
        return false
    }
    
    func navigateToRatingViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let ratingViewController = storyboard.instantiateViewController(withIdentifier: "RatingViewController") as? RatingViewController {
            ratingViewController.modalPresentationStyle = .fullScreen
            self.present(ratingViewController, animated: true, completion: nil)
        } else {
            preconditionFailure("Could not navigate to RatingViewController")
        }
    }
    
    // TODO - Make into it's own init that is shared between views.
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithNavigation() {
        let alert = UIAlertController(title: "Success", message: "User Saved", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                 self.navigateToRatingViewController()
             }))
        self.present(alert, animated: true, completion: nil)
    }

}

extension CreateAccountViewController: UITextFieldDelegate {
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

// MARK: - Render
private extension CreateAccountViewController {
    func render(_ state: CreateAccountViewControllerState) {
        switch state {
        case .creatingUserFailure(let error):
            print(error.localizedDescription)
            break
        case .invalidEmail:
            break
        case .userAlreadyExists:
            showAlert(title: "Error", message: "A user with that email already exists.")
        case .userCreated:
            showAlertWithNavigation()
            print("User Created!")
        case .invalidPassword:
            break
        }
    }
}
