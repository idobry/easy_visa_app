//
//  FormViewModel.swift
//  easy_visa_app
//
//  Created by ido braunstain on 7.10.2017.
//  Copyright © 2017 ido braunstain. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FormViewModel{
    
    var ref: DatabaseReference?
    var formModel: FormModel?
    var welcomeViewController: WelcomeViewController?
    
    init(welcomeViewController: WelcomeViewController) {
        self.welcomeViewController = welcomeViewController
    }
    
    func getFormId() -> String{
        return self.formModel!.formId!
    }
    
    func newUser(password: String) {
        
        let newFormId = Utilities.FireBase.addNewUser(password: password)
        Utilities.FireBase.getForm(formId: Utilities.FireBase.mainForm){ form in
            self.formModel = form!
            form?.formId = newFormId
            form?.password = password
            //go to main screen with main(empty) form
            self.welcomeViewController?.goToHomeView()
        }
        
    }
    
    func signIn(formId: String, password: String) {
        
        Utilities.FireBase.validUserSignIn(formId: formId, password: password){
            (ans, msg) in
            if ans!{
                Utilities.FireBase.getForm(formId: formId){ form in
                    self.formModel = form!
                    //go to main screen with the uplaoded form
                }
            }
            else{
                print(msg ?? "wrong password")
            }
        }
    }
    
    func saveForm(formId: String){
        Utilities.FireBase.postForm(form: self.formModel!){
            (ans, msg) in
            if ans!{
                print("form saved")
            }
            else{
                print(msg ?? "error")
            }
        }
    }
    
}
