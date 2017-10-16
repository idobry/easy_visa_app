//
//  Form.swift
//  easy_visa_app
//
//  Created by ido braunstain on 7.10.2017.
//  Copyright © 2017 ido braunstain. All rights reserved.
//

import Foundation


class FormModel: Decodable, Encodable{
    
    var formId: String?
    var password: String?
    var categoryList: [CategoryModel]?
    
    init(){
        
    }
    
    init(password: String, categoryList: [CategoryModel]){
        self.formId = Utilities.randomString(length: Utilities.passwordLen)
        self.password = password
        self.categoryList = categoryList
    }
    
    init(formId: String, password: String, categoryList: [CategoryModel]){
        self.formId = formId
        self.password = password
        self.categoryList = categoryList
    }
    
    
    
}
