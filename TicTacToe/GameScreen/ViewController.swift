//
//  ViewController.swift
//  TicTacToe
//
//  Created by Konstantin Kostadinov on 12.11.19.
//  Copyright © 2019 Konstantin Kostadinov. All rights reserved.
//

import UIKit

struct Player {
    var name = ""
    var playerID = 0
    var hisTurn = false
    var markedPositions: IndexPath = []
}

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var playersTurnLabel: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var resetGameButton: UIButton!
    
    var player1 = Player()
    var player2 = Player()
     let gridSize = 3
    var cellBackgroudColor: UIColor?
    var isRunning = true
    var winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[2,5,8],[0,4,8],[2,4,6],[1,4,7]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGameButton.isHidden = true
        self.navigationController?.navigationBar.barTintColor = cellBackgroudColor
        flowLayoutConfig()
        playersConfig()
    }
    
    fileprivate func flowLayoutConfig(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myCollectionView.collectionViewLayout = flowLayout
        myCollectionView.backgroundColor = .black
    }
    fileprivate func playersConfig(){
        if player1.name == "" {
            player1.name = "Player 1"
        }
        if player2.name ==  "" {
            player2.name = "Player 2"
        }
        player1.playerID = 1
        player1.hisTurn = true
        playersTurnLabel.text = "\(player1.name)'s turn"
        player2.playerID = 2
        player2.hisTurn = false
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridSize*gridSize
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width-10) / 3
        let height = width
        return CGSize(width: width, height: height)
    }
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELL", for: indexPath) as! GameCell
        cell.markLabel.text = ""
        cell.backgroundColor = cellBackgroudColor
       return cell
   }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isRunning{
            let cell = collectionView.cellForItem(at: indexPath) as! GameCell
            if cell.markLabel.text == "" {
                if player1.hisTurn {
                    cell.markLabel.text = "O"
                    cell.playerID = player1.playerID
                    cell.markLabel.textColor = .green
                    player1.markedPositions.append(indexPath.row)
                    playersTurnLabel.text = "\(player2.name)'s turn"
                    player1.hisTurn = false
                    player2.hisTurn = true
                }else{
                    cell.markLabel.text = "X"
                    cell.playerID = player2.playerID
                    cell.markLabel.textColor = .red
                    playersTurnLabel.text = "\(player1.name)'s turn"
                    player2.markedPositions.append(indexPath.row)
                    player2.hisTurn = false
                    player1.hisTurn = true
                }
            }
            checkForWinner(collection: collectionView)
        }
    }
    func checkForWinner(collection: UICollectionView){
        print("Player 1: \(player1.markedPositions)")
        print("Player 2: \(player2.markedPositions)")
        checkCells(player: player1)
        checkCells(player: player2)
        if (player1.markedPositions.count + player2.markedPositions.count == gridSize*gridSize ){
            playersTurnLabel.text = "It's a Tie!"
            showAlert(title: "TIE", message: "It's a tie game!")
            isRunning = false
            resetGameButton.isHidden = false
        }
    }
    
    func checkCells(player: Player){
        let positions = player.markedPositions
        for winPositions in 0...7 {
            if positions.contains(winningCombinations[winPositions]){
                showWinner(player: player)
                isRunning = false
            }
        }
    }
    func showWinner(player: Player){
        playersTurnLabel.text = "The winner is: \(player.name)"
        showAlert(title: "You won!", message: "\(player.name) won the game!")
        resetGameButton.isHidden = false
    }
    func showAlert(title: String, message: String) {
        let alert =  UIAlertController.init(title: title, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: message, style: .default, handler: nil))
        self.present(alert, animated: true, completion:  nil)
    }
    @IBAction func resetGameButton(_ sender: Any) {
        resetGameConfig()
    }
    fileprivate func resetGameConfig(){
        resetGameButton.isHidden = false
        player1.markedPositions = []
        player2.markedPositions = []
        isRunning = true
        playersConfig()
        myCollectionView.reloadData()
    }
}

