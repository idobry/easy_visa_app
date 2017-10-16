//
//  textField.swift
//  easy_visa_app
//
//  Created by ido braunstain on 7.10.2017.
//  Copyright © 2017 ido braunstain. All rights reserved.
//

import Foundation


class TextFieldModel: Decodable, Encodable{
    
    var placeholder: String
    var text: String
    var detail: String
    
    init(placeholder: String, text: String, detail: String ){
        self.placeholder = placeholder
        self.text = text
        self.detail = detail
    }
    
}
