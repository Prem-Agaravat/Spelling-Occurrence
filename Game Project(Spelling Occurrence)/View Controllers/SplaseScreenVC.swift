//
//  SplaseScreenVC.swift
//  Game Project(Spelling Occurrence)
//
//  Created by RWM on 17/12/21.
//  Copyright © 2021 Prem. All rights reserved.
//

import UIKit

class SplaseScreenVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var loadingProgressView: UIProgressView!
   //MARK: - Variables
    var count : Float = 1
    var timer : Timer = Timer()
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTimerForProgressView()
        navigationController?.isNavigationBarHidden = true
    }
    //MARK: - Intitial SetUp For ProgressBar
    private func setUpTimerForProgressView(){
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    //MARK: - Method For Timer
    @objc func updateTimer() {
        
        if count > 10 {
            timer.invalidate()
            navigateToHomeScreen()
        } else {
            count += 0.05
            loadingProgressView.progress = count/10
        }
    }
    //MARK: - Navigate To Home Screen
    private func navigateToHomeScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeScreenVC = storyBoard.instantiateViewController(withIdentifier: "HomeScreenVC") as! HomeScreenVC
        navigationController?.pushViewController(homeScreenVC, animated: true)
    }
}
