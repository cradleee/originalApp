//
//  ViewController.swift
//  originalApp
//
//  Created by kamano yurika on 2018/03/04.
//  Copyright © 2018年 釜野由里佳. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //Storyboardで扱うTableViewを宣言
    @IBOutlet var tableView: UITableView!
    
    var todos: [String] = []
    var recieveValue: Double!
    var value: String!
    
    let userDefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //テーブルビューのデータソースメソッドはViewControllerクラスに書くよ、という設定
        tableView.dataSource = self
        tableView.delegate = self
        
        
        if let aaa = userDefaults.object(forKey: "todos") {
            todos = aaa as! [String]
        }
        
        self.tableView.reloadData() //データをリロードする
        
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セルを呼び出す
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("todos")
        self.value = todos[indexPath.row]
        performSegue(withIdentifier: "ViewController", sender: self.value)
        
        tableView.deselectRow(at:indexPath, animated: true)
    }
    
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セルの内容を決める。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let todo = todos[indexPath.row]
        
        
        cell.textLabel?.text = todo
        
        return cell
    }
    //削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            userDefaults.set(todos, forKey: "todos")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let memoviewController: MemoViewController =
            segue.destination as! MemoViewController
        memoviewController.recieveValue = sender as? String
        
        
        
    }

}

