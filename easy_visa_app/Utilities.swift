//
//  Utilities.swift
//  easy_visa_app
//
//  Created by ido braunstain on 9.10.2017.
//  Copyright © 2017 ido braunstain. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

struct Utilities{
    
    static var passwordLen = 7
    
    static func randomString(length: Int) -> String {
        
        let letters : NSString = "0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    struct FireBase {
        
        static var dbURL = "https://easyvisaapp-38c3c.firebaseio.com/forms/"
        static var mainForm = "form"
        
        static func validUserSignIn(formId: String, password: String, completionHandler:@escaping (_ ans: Bool?, _ msg: String?)->()){
           
            let ref = Database.database().reference()
            
            ref.child("forms").child(formId).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                let db_password = value?["password"] as? String ?? ""
                
                if password == db_password {
                    completionHandler(true, "all good")
                }
                else{
                    completionHandler(false, "wrong password")
                }
            }) { (error) in
                print(error.localizedDescription)
            }
            
        }
        
        static func addNewUser(password: String) -> String{
            
            let ref = Database.database().reference()
            let newFormId = Utilities.randomString(length: Utilities.passwordLen)
            ref.child("users").child(newFormId).setValue(["password": password])
            return newFormId            
        }
        
        static func postForm(form: FormModel, completionHandler:@escaping (_ form: Bool?, _ msg: String?)->()) {
            
            let jsonToGet = dbURL+form.formId!+".json"
            let jsonData: Data
            let url = URL(string: jsonToGet)
            
            // Encode data
            let jsonEncoder = JSONEncoder()
            do {
                jsonData = try jsonEncoder.encode(form)
                var request = URLRequest(url: url!)
                request.httpMethod = "PUT"
                request.httpBody = jsonData
                
                URLSession.shared.getAllTasks { (openTasks: [URLSessionTask]) in
                    NSLog("open tasks: \(openTasks)")
                }
                
                let task = URLSession.shared.dataTask(with: request, completionHandler: { (responseData: Data?, response: URLResponse?, error: Error?) in
                    //NSLog("\(response)")
                    if (error != nil) {
                        completionHandler(false, error?.localizedDescription)
                    }
                    else{
                        completionHandler(true, "all good")
                    }
                })
                task.resume()
            }
            catch {
                print("error in Utilities.FireBase.postForm")
            }
        }
        
        
        static func getForm(formId: String, completionHandler:@escaping (_ form: FormModel?)->()){
            
            var form = FormModel()
            let jsonToGet = dbURL+formId+".json"
            
            //guard let url = URL(string: jsonToGet) else {return}
            let url = URL(string: jsonToGet)
            
            URLSession.shared.dataTask(with: url!) { (data, response, err) in
                //check err
                //check status 200
                guard let data = data else {return}
                
                do{
                    form = try JSONDecoder().decode(FormModel.self, from: data)
                    completionHandler(form)
                } catch let jsonErr{
                    print(jsonErr)
                    completionHandler(nil)
                }
                
            }.resume()
       }
    }
        
}
    

