//
//  MemoViewController.swift
//  originalApp
//
//  Created by kamano yurika on 2018/03/04.
//  Copyright © 2018年 釜野由里佳. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleTextField: UITextField!
    
    var todoArray: [String] = []
    var recieveValue: String!
    
    let saveData: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //まずsaveDataの中にtodoarrayがあるか確認してなかったら、todoArrayを作成。あったら、todoArrayをsaveDataから取り出す。
        if saveData.object(forKey: "todos") == nil {
            //return
        }else{
            todoArray = saveData.object(forKey: "todos") as! [String]
        }
        
        titleTextField.delegate = self
        titleTextField.text = saveData.object(forKey: "todos") as? String
        
        
        if recieveValue != nil {
            print(recieveValue)
            titleTextField.text = recieveValue
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //#007メモ帳　p.２５
    @IBAction func saveMemo() {
        //UserDefaultsに書き込み
        
        if recieveValue == nil {
            todoArray.append(titleTextField.text!)
            saveData.set(todoArray, forKey: "todos")
        }else if recieveValue != nil {
            let index = todoArray.index(of: recieveValue)
            todoArray.remove(at: index!)
            todoArray.insert(titleTextField.text!, at: index!)
            saveData.set(todoArray, forKey: "todos")
            
        }
        
        if titleTextField.text == nil {
            //return
        }
        
        //alertを出す
        let alert: UIAlertController = UIAlertController(title: "保存", message:"メモの保存が完了しました。",
                                                         preferredStyle: .alert)
        
        //OKボタン
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    //ボタンが押されましいたときの動作
                    //#007 メモ帳P.31
                    self.navigationController?.popViewController(animated: true)
                    print("OKボタンが押されました！")
            }
            )
        )
        present(alert, animated: true, completion: nil)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
