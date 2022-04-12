//
//  SinglePlayerNameVC.swift
//  Game Project(Spelling Occurrence)
//
//  Created by RWM on 30/12/21.
//  Copyright © 2021 Prem. All rights reserved.
//

import UIKit

class PlayerNameVC: UIViewController {
    //MARK: -  IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    //MARK: - Variables
    var arrPlayersName: [String] = []
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStartButton()
    }
    //MARK: - Button Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if nameTextField.text != "" {
            arrPlayersName.append(nameTextField.text!)
            UserDefaults.standard.set(arrPlayersName, forKey: "playersName")
            navigateToDifficultiScreen()
        } else {
            showBlankTextFieldAlert()
        }
    }
    //MARK: - Initial SetUp For Start Button
    private func setUpStartButton() {
        startButton.layer.cornerRadius = 15
        startButton.layer.masksToBounds = true
    }
    //MARK: - Navigation
    private func navigateToDifficultiScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let difficultySelectionScreenVC = storyBoard.instantiateViewController(withIdentifier: "DifficultySelectionScreenVC") as! DifficultySelectionScreenVC
        navigationController?.pushViewController(difficultySelectionScreenVC, animated: true)
    }
    //MARK: - Alert For Blank Text Field 
    private func showBlankTextFieldAlert() {
        let alert: UIAlertController = UIAlertController(title: "Oops!", message: "You forgot to enter your name", preferredStyle: .alert)
        let okButton: UIAlertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
