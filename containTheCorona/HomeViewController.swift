//
//  ViewController.swift
//  containTheCorona
//
//  Created by Elizabeth Bott on 5/21/20.
//  Copyright © 2020 Elizabeth Bott. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation


var buttonSound = true
var musicOn = true


var spaceGrid = [[UIButton]]()
var tutorialOn = false
var currentScore = 1
//var currentHighScore = UserDefaults.value(forKey: "highscore") as! Int
var currentHighScore = 1
let defaults = UserDefaults.standard

class HomeViewController: UIViewController {
    //MARK: Properties

    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var introImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tutorialButton: UIButton!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    //settings button
    @IBOutlet weak var settingsBackground: UIImageView!
    @IBOutlet weak var settingsLabel: UILabel!
    
    @IBOutlet weak var clickSoundButton: UIButton!
    @IBOutlet weak var backgroundMusicButton: UIButton!
    @IBOutlet weak var settingsDoneButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    //info button
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var creditsImage: UIImageView!
    @IBOutlet weak var developerLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var musicCreditLabel: UILabel!
    
    @IBOutlet weak var creditDoneButton: UIButton!
    
    //MARK: Functions
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        startButton.layer.cornerRadius = startButton.frame.height / 2
        tutorialButton.layer.cornerRadius = tutorialButton.frame.height / 2
        introLabel.layer.cornerRadius = introLabel.frame.height / 2
    
        highScoreLabel.layer.cornerRadius = highScoreLabel.frame.height / 2
        
        clickSoundButton.setImage(UIImage(named: "mute audio"), for: .selected)
        clickSoundButton.setImage(UIImage(named: "audio"), for: .normal)
        
        
        
        
        //MusicPlayer.shared.startBackgroundMusic()
        musicOn = defaults.bool(forKey: "musicOn")
        buttonSound = defaults.bool(forKey: "buttonSound")
        if !musicOn{
            GSAudio.sharedInstance.stopBackgroundMusicMp3(soundFileName: "slowmotion")
            GSAudio.sharedInstance.playSoundMp3(soundFileName: "slowmotion")
            
        }
        
        if buttonSound{
            clickSoundButton.isSelected = true
        }
        backgroundMusicButton.setImage(UIImage(named: "mute music"), for: .selected)
        backgroundMusicButton.setImage(UIImage(named: "music"), for: .normal)
        
        if musicOn{
            backgroundMusicButton.isSelected = true
        }
        
        var temp = defaults.integer(forKey: "highscore")
        if temp < currentHighScore{
            defaults.set(currentHighScore, forKey: "highschore")
            temp = defaults.integer(forKey: "highscore")
        }
        
        highScoreLabel.text = "High Score = " + String(temp)
        
        currentHighScore = temp
        
        //currentScore = currentScore
        
      
        
        levelCount = 1
        // Do any additional setup after loading the view.
    }//viewDidLoad


    @IBAction func animateStart(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        //MusicPlayer.shared.playSoundEffect(soundEffect: "button1")
        //MusicPlayer.shared.startBackgroundMusic()
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }//animate start
    
    

    
    @IBAction func animateTutorial(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        //MusicPlayer.shared.playSoundEffect(soundEffect: "button1")
        //MusicPlayer.shared.startBackgroundMusic()
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }//animate tutorial
   
    
    @IBAction func settingsButtonClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        settingsLabel.isHidden = false
        settingsBackground.isHidden = false
        backgroundMusicButton.isHidden = false
        clickSoundButton.isHidden = false
        settingsDoneButton.isHidden = false
        infoButton.isHidden = false
    }
    
    @IBAction func settingsDoneClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        settingsLabel.isHidden = true
        settingsBackground.isHidden = true
        backgroundMusicButton.isHidden = true
        clickSoundButton.isHidden = true
        settingsDoneButton.isHidden = true
        infoButton.isHidden = true
    }
    
    @IBAction func buttonSoundClicked(_ sender: UIButton) {
        if !buttonSound{
            buttonSound = true
            clickSoundButton.isSelected = true
        }else{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
            buttonSound = false
            clickSoundButton.isSelected = false
        }
    }
    @IBAction func musicButtonClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        if !musicOn{
            //MusicPlayer.shared.stopBackgroundMusic()
            
            GSAudio.sharedInstance.stopBackgroundMusicMp3(soundFileName: "slowmotion")
            musicOn = true
            backgroundMusicButton.isSelected = true
        }else{
            musicOn = false
            //MusicPlayer.shared.startBackgroundMusic()
            GSAudio.sharedInstance.playSoundMp3(soundFileName: "slowmotion")
            backgroundMusicButton.isSelected = false
        }
        
    }
    
    
    @IBAction func infoButtonClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        //close out settings
        settingsLabel.isHidden = true
        settingsBackground.isHidden = true
        backgroundMusicButton.isHidden = true
        clickSoundButton.isHidden = true
        settingsDoneButton.isHidden = true
        infoButton.isHidden = true
        
        //open info
        creditsImage.isHidden = false
        infoLabel.isHidden = false
        musicCreditLabel.isHidden = false
        developerLabel.isHidden = false
        contactLabel.isHidden = false
        creditDoneButton.isHidden = false
        
    }
    
    
    @IBAction func creditDoneClicked(_ sender: UIButton) {
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        //close out settings
        settingsLabel.isHidden = false
        settingsBackground.isHidden = false
        backgroundMusicButton.isHidden = false
        clickSoundButton.isHidden = false
        settingsDoneButton.isHidden = false
        infoButton.isHidden = false
        
        //open info
        creditsImage.isHidden = true
        infoLabel.isHidden = true
        musicCreditLabel.isHidden = true
        developerLabel.isHidden = true
        contactLabel.isHidden = true
        creditDoneButton.isHidden = true
    }
    
}//homeviewcontroller



class HighlightedButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .white : .black
        }
    }
}
