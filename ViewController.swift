import UIKit

//Create a subclass with
class ViewController: UIViewController {

    //Create a outlet to connect the tableview
    @IBOutlet var tableView: UITableView!
    
    //Create an array to hold the string
    var tasks = [String]()
    
    //create a function to add swipe-to-delete functionality to your table view controller
    func tableView(_ tableView: UITableView, canEditRowAt
       indexPath: IndexPath) -> Bool {
           return true
       }
    //delete button
    func tableView(_ tableView: UITableView, commit
       editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:
       IndexPath) {
           if editingStyle == .delete {
               tasks.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Tasks"
        
        //where you send the messages
        tableView.delegate = self
        tableView.dataSource = self
        
        //Store small pieces of data as the launch opens
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            
        }
        updateTasks()
    }
    
    //function to add each single cell
    func updateTasks() {
        
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        //increment task by one
        for x in 0..<count {
            
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
        }
        //reload every cell
            tableView.reloadData()
    }
    
    //action assigned with button
    @IBAction func didTapAdd() {
        
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

//connect other view controllers

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
            }
        }

//return tasks and count them
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    //connect identifier with table view cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        
        return cell
}
}


 

        

    
