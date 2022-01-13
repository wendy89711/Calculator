//
//  MainController.swift
//  Calculator
//
//  Created by Wendy Wu on 2022/1/11.
//

import UIKit

var username = "";

class MainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationItem.title = "首頁"
    }
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var NavigationItem: UINavigationItem!
    
    @IBAction func GoCalcu(_ sender: Any) {
        if Button.isTouchInside {
            username = Name.text!;
            debugPrint(username)
            if Name.text == "" {
                let alert = UIAlertController(title: "提醒", message: "請填寫姓名！", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                present(alert, animated: true, completion: nil)
            }
            if let controller = storyboard?.instantiateViewController(withIdentifier: "resultPage") {
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}
