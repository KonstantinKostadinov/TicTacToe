//
//  ViewController.swift
//  TicTacToe
//
//  Created by Konstantin Kostadinov on 12.11.19.
//  Copyright © 2019 Konstantin Kostadinov. All rights reserved.
//

import UIKit
class GameConfigVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var enterDetailsLabel: UILabel!
    @IBOutlet weak var playerOneNameLabel: UILabel!
    @IBOutlet weak var playerTwoNameLabel: UILabel!
    @IBOutlet weak var backgroundColorLabel: UILabel!
    @IBOutlet weak var playerOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    @IBOutlet weak var backgroundColorDropDown: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "TicTacToe"
        setupDropDownMenu()
        // Do any additional setup after loading the view.
    }
    fileprivate func setupDropDownMenu(){
        backgroundColorDropDown.text = "white"
        backgroundColorDropDown.optionArray = ["white","cyan","blue","gray"]
        backgroundColorDropDown.optionIds = [1,2,3,4]
        backgroundColorDropDown.textAlignment = .center
        backgroundColorDropDown.selectedRowColor = .lightGray
        backgroundColorDropDown.isSearchEnable =  false
        backgroundColorDropDown.didSelect{(selectedText , index ,id) in
            var backgroundColor = self.backgroundColorDropDown.text
            backgroundColor = "\(selectedText)"
            if backgroundColor == "white"{
                self.view.backgroundColor = .white
                self.navigationController?.navigationBar.barTintColor = .white
            } else if backgroundColor == "cyan"{
                self.view.backgroundColor = .cyan
                self.navigationController?.navigationBar.barTintColor = .cyan
            }else if backgroundColor == "blue"{
                self.view.backgroundColor = .blue
                self.navigationController?.navigationBar.barTintColor = .blue
            }else if backgroundColor == "gray"{
                self.view.backgroundColor = .gray
                self.navigationController?.navigationBar.barTintColor = .gray
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    @IBAction func startButton(_ sender: Any) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        destinationVC.player1.name = playerOneTextField.text ?? "Player 1"
        destinationVC.player2.name = playerTwoTextField.text ?? "Player 2"
        destinationVC.view.backgroundColor = self.view.backgroundColor
        destinationVC.cellBackgroudColor = self.view.backgroundColor
    }

}
