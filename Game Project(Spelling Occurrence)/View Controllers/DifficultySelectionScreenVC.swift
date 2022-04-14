//
//  DifficultySelectionScreenVC.swift
//  Game Project(Spelling Occurrence)
//
//  Created by RWM on 17/12/21.
//  Copyright © 2021 Prem. All rights reserved.
//

import UIKit

class DifficultySelectionScreenVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var buttondBackgroundView: UIView!
    @IBOutlet weak var easyModeButton: UIButton!
    @IBOutlet weak var mediumModeButton: UIButton!
    @IBOutlet weak var hardModeButton: UIButton!
    //MARK: - Variables
    var difficultyMode: String = ""
    var secondForTimer: Float = 0
    //MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buttondBackgroundView.layer.cornerRadius = 15
        setUpButtons(arrButtons: [easyModeButton,mediumModeButton,hardModeButton])
    }
    //MARK: - Buttons Action
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func easyButtonTapped(_ sender: UIButton) {
        navigateToGamePlayScreen(diffiCultyMode: "easy")
    }
    @IBAction func mediumButtonTapped(_ sender: UIButton) {
        navigateToGamePlayScreen(diffiCultyMode: "medium")
    }
    @IBAction func hardButtonTapped(_ sender: UIButton) {
        navigateToGamePlayScreen(diffiCultyMode: "hard")
    }
    //MARK: - Initial SetUp For Button
    private func setUpButtons(arrButtons: [UIButton]) {
        for button in arrButtons {
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.backgroundColor = .yellow
        }
    }
    //MARK: - Navigation
    private func navigateToGamePlayScreen(diffiCultyMode: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let  gamePlayScreenVC = storyBoard.instantiateViewController(withIdentifier: "GamePlayScreenVC") as! GamePlayScreenVC
        navigationController?.pushViewController(gamePlayScreenVC, animated: true)
        gamePlayScreenVC.selectedDificultyMode = diffiCultyMode
    }
}

