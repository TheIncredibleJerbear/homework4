//
//  EntryViewController.swift
//  supertodolist
//
//  Created by Jerry Eapen on 4/7/21.
//

import UIKit

class EntryViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet var field: UITextField!
    
    
    var update: (() -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        //add button to save
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))

        // Do any additional setup after loading the view.
    }
    
    //save textfeild
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    @objc func saveTask() {
            
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
        //var
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        //how many tasks we have so far
        
        let newCount = count + 1
        
        //SAVE
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(newCount)")

    update?()
    
        navigationController?.popViewController(animated: true)

}
}

