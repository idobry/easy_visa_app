//
//  ViewController.swift
//  easy_visa_app
//
//  Created by ido braunstain on 7.10.2017.
//  Copyright © 2017 ido braunstain. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var formViewModel: FormViewModel? = nil

    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var formIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPasswordTextField.isHidden = true
        formViewModel = FormViewModel(welcomeViewController: self)
    }
    
    @IBAction func Signin(_ sender: UIButton) {
        formViewModel?.signIn(formId: formIdTextField.text!, password: passwordTextField.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func newUser(_ sender: UIButton) {
        
        if newPasswordTextField.isHidden{
            sender.setTitle("Confirm", for: .normal)
            newPasswordTextField.isHidden = false
        }
        else{
            formViewModel?.newUser(password: newPasswordTextField.text!)
        }
    }
    
    func goToHomeView(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        
        homeViewController.formViewModel = self.formViewModel
        DispatchQueue.main.sync {            
            self.present(homeViewController, animated:true, completion:nil)
        }
    }
    
}

