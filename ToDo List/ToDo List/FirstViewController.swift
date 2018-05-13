//
//  FirstViewController.swift
//  ToDo List
//
//  Created by Evgeney Kuznetsov on 13/05/2018.
//  Copyright © 2018 Evgeney Kuznetsov. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static public let listDefaultsKey = "list"

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count")
        
        if let list = UserDefaults.standard.object(forKey: FirstViewController.listDefaultsKey) as? Array<String> {
            return list.count
        }
        return 0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let list = UserDefaults.standard.object(forKey: FirstViewController.listDefaultsKey) as? Array<String> {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
                cell.textLabel?.text = list[indexPath.row]
                return cell
            }
        }
        //TODO: remove
        return UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "error")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if var data = UserDefaults.standard.object(forKey: FirstViewController.listDefaultsKey) as? Array<String> {
                data.remove(at: indexPath.row)
                UserDefaults.standard.set(data, forKey: FirstViewController.listDefaultsKey)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

