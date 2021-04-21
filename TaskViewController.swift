//
//  TaskViewController.swift
//  supertodolist
//
//  Created by Jerry Eapen on 4/7/21.
//

import UIKit

class TaskViewController: UIViewController {
    
    //view controller that acts as string and label
    
    @IBOutlet var label: UILabel!
    
    var task: String?


    override func viewDidLoad() {
        super.viewDidLoad()

        
        label.text = task
    }
        }
