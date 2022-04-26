//
//  GamePlayScreenVC.swift
//  Game Project(Spelling Occurrence)
//
//  Created by RWM on 23/12/21.
//  Copyright © 2021 Prem. All rights reserved.
//

import UIKit

class GamePlayScreenVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var spellingLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var timerProgressView: UIProgressView!
    //MARK: - Variables
    var arrPlayersName: [String] = []
    var score: Int = 0
    var highScore: Int = 0
    var second: Float = 0
    var selectedDificultyMode: String = ""
    var arrOfSpellings: [String] = ["Prem","Table","Cat","Dog","Cow","Classroom","Break","Glass","Car","Board","Lock","Key","Lime","Moon","Sun","Sea","Bat","Beach"]
    var count : Float = 10
    var timer : Timer = Timer()
    var dictionaryOfSpelling: [String:Int] = [:]
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        arrPlayersName = UserDefaults.standard.value(forKey: "playersName") as! [String] 
        setSecondForTimer()
        setUpTimerForProgressView()
        displayRandomSpelling()
    }
    //MARK: - Buttons Action
    @IBAction func backButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        navigationController?.popViewController(animated: true)
    }
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            checkAnswer()
            updateScore(number: 0)
        case 1:
            checkAnswer()
            updateScore(number: 1)
        case 2:
            checkAnswer()
            updateScore(number: 2)
        case 3:
            checkAnswer()
            updateScore(number: 3)
        case 4:
            checkAnswer()
            updateScore(number: 4)
        case 5:
            checkAnswer()
            updateScore(number: 5)
        case 6:
            checkAnswer()
            updateScore(number: 6)
        case 7:
            checkAnswer()
            updateScore(number: 7)
        case 8:
            checkAnswer()
            updateScore(number: 8)
        case 9:
            checkAnswer()
            updateScore(number: 9)
        case 10:
            checkAnswer()
            updateScore(number: 10)
        case 11:
            checkAnswer()
            updateScore(number: 11)
        default:
            break
        }
    }
    //MARK: - Intitial SetUp for timer
    private func setSecondForTimer() {
        if selectedDificultyMode == "easy" {
            second = 0.005
        } else if selectedDificultyMode == "medium" {
            second = 0.01
        } else {
            second = 0.03
        }
    }
    //MARK: - Initial Setup For ProgressBar
    private func setUpTimerForProgressView(){
        count = 10
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    //MARK: - Method for Timer
    @objc func updateTimer() {
        if count < 0 {
            timer.invalidate()
            showGameOverAlert(title: "Times Up")
        } else {
            if count <= 5 && count > 2 {
                timerProgressView.tintColor = .yellow
            } else if count <= 2 {
                 timerProgressView.tintColor = .red
            }
            count -= second
            timerProgressView.progress = count/10
        }
    }
    //MARK: - Func To Show Random Spelling
    func displayRandomSpelling() {
        let randomIndex = Int(arc4random_uniform(UInt32(arrOfSpellings.count)))
        spellingLable.text = arrOfSpellings[randomIndex]
    }
    //MARK: - Func To Check Answer
    func checkAnswer(){
        if let count = dictionaryOfSpelling[spellingLable.text!] {
            dictionaryOfSpelling[spellingLable.text!] = count + 1
        } else {
            dictionaryOfSpelling[spellingLable.text!] = 0
        }
    }
    //MARK: - Func To Update Score
     func updateScore(number: Int) {
        if dictionaryOfSpelling[spellingLable.text!] == number {
            timer.invalidate()
            score += 1
            if score >= highScore {
                highScore = score
            }
            scoreLable.text = "Score = \(score)"
            timerProgressView.tintColor = .white
            displayRandomSpelling()
            setUpTimerForProgressView()
        } else {
            showGameOverAlert(title: "Game Over")
            score = 0
            dictionaryOfSpelling.removeAll()
        }
    }
   //MARK: - Func To Store Player Score
    private func savePlayerScore(score: Int) {
        for i in 0..<arrPlayersName.count {
            ScoareBoardScreenVC.dictionaryOfPlayerScore[arrPlayersName[i]] = score
        }
    }
    //MARK: - Alert For Game Over
    private func showGameOverAlert(title: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: "Score: \(score)\nHighest Score: \(highScore)", preferredStyle: .alert)
        let homeButton: UIAlertAction = UIAlertAction(title: "HOME", style: .default) { (home) in
            self.savePlayerScore(score: self.highScore)
            UserDefaults.standard.set(ScoareBoardScreenVC.dictionaryOfPlayerScore, forKey: "playerScores")
            self.timer.invalidate()
            self.navigateToHomeScreen()
        }
        let replayButton: UIAlertAction = UIAlertAction(title: "Re-Play", style: .default) { (replay) in
            self.timer.invalidate()
            self.timerProgressView.tintColor = .white
            self.setUpTimerForProgressView()
            self.score = 0
            self.scoreLable.text = "0"
            self.dictionaryOfSpelling.removeAll()
        }
        alert.addAction(homeButton)
        alert.addAction(replayButton)
        present(alert, animated: true, completion: nil)
    }
    //MARK: - Navigation
    private func navigateToHomeScreen() {
        navigationController?.popToViewController((self.navigationController?.viewControllers[1] as! HomeScreenVC), animated: true)
    }
}
