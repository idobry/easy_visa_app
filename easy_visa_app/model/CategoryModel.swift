//
//  category.swift
//  easy_visa_app
//
//  Created by ido braunstain on 7.10.2017.
//  Copyright © 2017 ido braunstain. All rights reserved.
//

import Foundation


class CategoryModel: Decodable, Encodable{
    
    var title: String
    var textFieldList: [TextFieldModel]
    
    init(title: String, textFieldList: [TextFieldModel]) {
        self.title = title
        self.textFieldList = textFieldList
    }
    
}
