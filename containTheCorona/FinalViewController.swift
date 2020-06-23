//
//  FinalViewController.swift
//  containTheCorona
//
//  Created by Elizabeth Bott on 5/25/20.
//  Copyright © 2020 Elizabeth Bott. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var finalImage: UIImageView!
    
    @IBOutlet weak var finalLabel: UILabel!
    
   
    @IBOutlet weak var nextLevelButton: UIButton!
    
    @IBOutlet weak var questionBackground: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var goHomeButton: UIButton!
    
    
    @IBOutlet weak var stayButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        design()
        //GSAudio.sharedInstance.stopBackgroundMusicMp3(soundFileName: "backgroundMusic")
        //GSAudio.sharedInstance.stopBackgroundMusicWav(soundFileName: "button1")
        for (_, _) in spaceGrid.enumerated() {
            spaceGrid.popLast()
        }

        // Do any additional setup after loading the view.
    }
    
    func design(){
        
        if currentScore > currentHighScore {
            defaults.set(currentScore, forKey: "highscore")
            currentHighScore = currentScore
        }
        if userWon == true{
            levelCount += 1
            finalImage.image = UIImage(named: "win")
            finalLabel.text = "You Won!"
            currentScore = levelCount
           // nextLevelButton.setTitle("Continue", for:[.normal, .selected, .highlighted])
            
            
        }else{
            currentScore = 1
            levelCount = 1
            finalImage.image = UIImage(named: "loss")
            finalLabel.text = "You Lost!"
           // currentScore = levelCount
           // nextLevelButton.setTitle("Start Over", for:[.normal, .selected, .highlighted])
            
           // nextLevelButton.setTitle("Try Again :(", for: .normal)
            
        }
        
        
    }
   
 
    @IBAction func animateNext(_ sender: UIButton) {
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
        
    }//animateStart
   
    @IBAction func animateHome(_ sender: UIButton) {
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
        if userWon{
            questionBackground.isHidden = false
            questionLabel.isHidden = false
            goHomeButton.isHidden = false
            stayButton.isHidden = false
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController")
            show(newViewController, sender: self)
        }
        
        
        
        
    }//animateHome
    
    @IBAction func stayButtonClicked(_ sender: UIButton) {
        if buttonSound{
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
        
        
        questionBackground.isHidden = true
        questionLabel.isHidden = true
        goHomeButton.isHidden = true
        stayButton.isHidden = true
    }//staybuttonclicked
    
    
    @IBAction func goHomeClicked(_ sender: UIButton) {
        if buttonSound{
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
    }
    
    
}
