//
//  HomeViewController.swift
//  easy_visa_app
//
//  Created by ido braunstain on 14.10.2017.
//  Copyright © 2017 ido braunstain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var formIdLabel: UILabel!
    
    var formViewModel: FormViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formIdLabel.text = formViewModel?.getFormId()
    }

    @IBAction func saveNewForm(_ sender: UIButton) {
        self.formViewModel?.saveForm(formId: (self.formViewModel?.getFormId())!)
    }
}
