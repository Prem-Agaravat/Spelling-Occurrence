//
//  HomeScreenVC.swift
//  Game Project(Spelling Occurrence)
//
//  Created by RWM on 17/12/21.
//  Copyright © 2021 Prem. All rights reserved.
//

import UIKit

class HomeScreenVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    //MARK: - Variable
    var message: String = "1.There will be one spelling.\n2.A player has tap on number as per occurrence of word.\n3.Ex,If 'Table' comes for the first time,press 0 and if 'Table' word comes again,press 1."
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons(arrButton: [playButton,scoreButton])
    }
    //MARK: - Buttons Action
    @IBAction func playButtonTapped(_ sender: UIButton) {
        showGameInstructions()
    }
    @IBAction func scoreButtonTapped(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let scoareBoardScreenVC = storyBoard.instantiateViewController(withIdentifier: "ScoareBoardScreenVC") as! ScoareBoardScreenVC
        navigationController?.pushViewController(scoareBoardScreenVC, animated: true)
    }
    //MARK: - Intitial SetUp For Buttons
    private func setUpButtons(arrButton: [UIButton]) {
        for button in arrButton {
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            button.backgroundColor = .yellow
        }
    }
    //MARK: - Navigation To Next Screen
    private func navigateToNextScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let playerNameVC = storyBoard.instantiateViewController(withIdentifier: "PlayerNameVC") as! PlayerNameVC
        navigationController?.pushViewController(playerNameVC, animated: true)
    }
    //MARK: - Initial SetUp For Game Instruction Alert
    private func showGameInstructions() {
        let alert: UIAlertController = UIAlertController(title: "How To Play", message: message, preferredStyle: .alert)
        let okButton: UIAlertAction = UIAlertAction(title: "OK", style: .default) { (ok) in
            self.navigateToNextScreen()
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
