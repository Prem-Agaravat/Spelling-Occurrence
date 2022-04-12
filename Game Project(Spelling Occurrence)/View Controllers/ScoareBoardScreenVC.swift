//
//  ScoareBoardScreenVC.swift
//  Game Project(Spelling Occurrence)
//
//  Created by RWM on 05/01/22.
//  Copyright © 2022 Prem. All rights reserved.
//

import UIKit

class ScoareBoardScreenVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var scoreBoardTableView: UITableView!
    //MARK: - Variables
    static var dictionaryOfPlayerScore: [String:Int] = [:]
    var arrOfPlayerNames: [String] = []
    var arrOfPlayersScore: [Int] = []
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        savePlayersNameAndScoreArray()
        setUpPlayersScore()
        scoreBoardTableView.delegate = self
        scoreBoardTableView.dataSource = self
        scoreBoardTableView.register(UINib(nibName: "SinglePlayerScoreCell", bundle: nil), forCellReuseIdentifier: "SinglePlayerScoreCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savePlayersNameAndScoreArray()
        setUpPlayersScore()
    }
    //MARK: - Back Button Action
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    //MARK: - setUp players Score
    private func setUpPlayersScore() {
        if let playerScores = UserDefaults.standard.value(forKey: "playerScores") {
            ScoareBoardScreenVC.dictionaryOfPlayerScore = playerScores as! [String : Int]
            arrOfPlayerNames = UserDefaults.standard.value(forKey: "arrPlayerName") as! [String]
            arrOfPlayersScore = UserDefaults.standard.value(forKey: "arrPlayerScore") as! [Int]
        }
    }
    //MARK: - Store Player Score And Name In Array
    private func savePlayersNameAndScoreArray() {
        var arrPlayersName: [String] = []
        var arrPlayersScore: [Int] = []
        for name in ScoareBoardScreenVC.dictionaryOfPlayerScore.keys {
            arrPlayersName.append(name)
            UserDefaults.standard.set(arrPlayersName, forKey: "arrPlayerName")
        }
        for score in ScoareBoardScreenVC.dictionaryOfPlayerScore.values {
            arrPlayersScore.append(score)
            UserDefaults.standard.set(arrPlayersScore, forKey: "arrPlayerScore")
        }
    }
}
//MARK: - TableView Delegate & DataSource Methods
extension ScoareBoardScreenVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfPlayerNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singlePlayerCell = scoreBoardTableView.dequeueReusableCell(withIdentifier: "SinglePlayerScoreCell", for: indexPath) as! SinglePlayerScoreCell
        singlePlayerCell.playerNameLabel.text = arrOfPlayerNames[indexPath.row]
        singlePlayerCell.playerScoreLabel.text = "Highest Score: \(arrOfPlayersScore[indexPath.row])"
        return singlePlayerCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



