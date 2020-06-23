//
//  TutorialViewController.swift
//  containTheCorona
//
//  Created by Elizabeth Bott on 5/28/20.
//  Copyright © 2020 Elizabeth Bott. All rights reserved.
//

import UIKit




class TutorialViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var stack3: UIStackView!
    @IBOutlet weak var stack4: UIStackView!
    @IBOutlet weak var stack5: UIStackView!
    @IBOutlet weak var stack6: UIStackView!
    @IBOutlet weak var stack7: UIStackView!
    @IBOutlet weak var stack8: UIStackView!
    @IBOutlet weak var stack9: UIStackView!
    @IBOutlet weak var stack10: UIStackView!
    @IBOutlet weak var stack11: UIStackView!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var tutLabel1: UILabel!
    
    @IBOutlet weak var okayButton1: UIButton!
    
    //@IBOutlet weak var freeLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var soundButton: UIButton!
    
    @IBOutlet weak var musicButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBOutlet weak var questionImage: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var goHomeButton: UIButton!
    
    @IBOutlet weak var stayButton: UIButton!
    
    
    var tutorialCount = 0
    
    var disCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tutorialOn = true
        okayButton1.layer.cornerRadius = okayButton1.frame.height / 2
        tutLabel1.layer.cornerRadius = tutLabel1.frame.height / 2
        
        goHomeButton.layer.cornerRadius = goHomeButton.frame.height / 2
        stayButton.layer.cornerRadius = stayButton.frame.height / 2
        
       // MusicPlayer.shared.startBackgroundMusic()
        
        soundButton.setImage(UIImage(named: "mute audio"), for: .selected)
        soundButton.setImage(UIImage(named: "audio"), for: .normal)
        
        if buttonSound{
            soundButton.isSelected = true
        }
        
        musicButton.setImage(UIImage(named: "mute music"), for: .selected)
        musicButton.setImage(UIImage(named: "music"), for: .normal)
        
        if musicOn{
            musicButton.isSelected = true
        }
        
        if (!tutorialOn){
            tutLabel1.isHidden = true
            okayButton1.isHidden = true
        }
        levelUp()
        setUp()
       // MusicPlayer.shared.stopBackgroundMusic()
        
        // play()
    }
    
    
    @IBAction func okayButton(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
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
        
    }
    
    func levelUp(){
        
        
        //levelCount = levelCount + 1
        levelLabel.text = "Level " + String(levelCount)
        
        
        
    }
    
    func setUp(){
        winner = false
        stackSetUp()
        userWon = false
        
        //freeLabel.text = "place 3 more disinfectants!"
        
        
        for row in 0...10{
            for col in 0...5{
                spaceGrid[row][col].isSelected = false
                
                
                spaceGrid[row][col].setImage(UIImage(named: "default"), for: .normal)
                spaceGrid[row][col].setImage(UIImage(named: "blocker"), for: .selected)
            }
        }
        
        //NEED TO RANDOMLY PICK spots to have beginning
        let spotsGiven = Int.random(in: 1 ... 5)
        
        for _ in 0..<spotsGiven{
            let row = Int.random(in: 1 ... 9)
            let col = Int.random(in: 1 ... 4)
            
            spaceGrid[row][col].isSelected = true
            
        }
        
        //picking starting spot for the virus
        
        let row = Int.random(in: 1 ... 9)
        let col = Int.random(in: 1 ... 4)
        
        coronaRow = row
        coronaCol = col
        
        
        spaceGrid[row][col].isSelected = true
        
        spaceGrid[row][col].setImage(UIImage(named: "corona"), for: .normal)
        spaceGrid[row][col].setImage(UIImage(named: "corona"), for: .selected)
        
    }//setUp()
    
    
    func stackSetUp(){
        
        for (_, _) in spaceGrid.enumerated() {
            spaceGrid.popLast()
        }
        
        
        stack(stackView: stack1)
        stack(stackView: stack2)
        stack(stackView: stack3)
        stack(stackView: stack4)
        stack(stackView: stack5)
        stack(stackView: stack6)
        stack(stackView: stack7)
        stack(stackView: stack8)
        stack(stackView: stack9)
        stack(stackView: stack10)
        stack(stackView: stack11)
        
        
        
    }
    
   
    func stack(stackView: UIStackView){
        
        var spaces = [UIButton]()
        for _ in 0..<6 {
            
            let button = UIButton()
            // Set the button images
            button.setImage(UIImage(named: "default"), for: .normal)
            button.setImage(UIImage(named: "blocker"), for: .selected)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 64).isActive = true
            button.widthAnchor.constraint(equalToConstant: 64).isActive = true
            spaces.append(button)
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(GridControl.GridButtonTapped(button:)), for: .touchUpInside)
            
            
        }
        spaceGrid.append(spaces)
        
    }
    
    
    @objc func GridButtonTapped(button: UIButton) {
        //print("Button pressed 👍")
       // MusicPlayer.shared.playSoundEffect(soundEffect: "button1")
        //MusicPlayer.shared.startBackgroundMusic()
        
    
    
        
        if winner == false{
            if !button.isSelected{
                if !buttonSound{
                    GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
                }
                
                userPlayed = true
                button.isSelected = true
                
                print("YOU MOVED")
                
                if disCounter < 2{
                    disCounter += 1
                   // freeLabel.text = "place " + String(3 - disCounter) + " more disinfectants!"
                }else{
                    disCounter += 1
                    GamePlay().play()
                   // if coronaRow == 0 || coronaRow == 10 || coronaCol == 0 || coronaCol == 5{
                   // freeLabel.isHidden = true
                    //}
                    if winner{
                        print(winner)
                        if (!userWon){
                            tutLabel1.text = "Whoops, you let it escape. Good luck!"
                        }else{
                            tutLabel1.text = "Congrats, you contained the corona. Good luck!"
                        }
                        tutLabel1.isHidden = false
                        okayButton1.isHidden = false
                        
                      
                    }//if winner
                
                
                }//else disCounter
                
            }//if button isnt selected
            
            
            
        }//if not winner
        
        if tutorialCount == 1 && disCounter == 3{
            tutLabel1.text = "Don't let the virus reach the edge!"
            tutLabel1.isHidden = false
            okayButton1.isHidden = false
           // freeLabel.isHidden = true
            
        }
    }//grid button tapped
    
    
    @IBAction func gameDone(_ sender: UITapGestureRecognizer) {
        
        if winner{
            stack1.isHidden = true
            stack2.isHidden = true
            stack3.isHidden = true
            stack4.isHidden = true
            stack5.isHidden = true
            stack6.isHidden = true
            stack7.isHidden = true
            stack8.isHidden = true
            stack9.isHidden = true
            stack10.isHidden = true
            stack11.isHidden = true
            // nextButton.isHidden = false
            //nextLabel.isHidden = false
            winner = false
        }else{
            print("tapped")
        }
    }//gamedone
    
    
    @IBAction func Okay1Button(_ sender: UIButton) {
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
        //MusicPlayer.shared.playSoundEffect(soundEffect: "button1")
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        tutLabel1.isHidden = true
        okayButton1.isHidden = true
        
        tutorialCount += 1
        
        if tutorialCount == 2{
            tutLabel1.text = "Keep placing disinfectants to contain the corona"
            tutLabel1.isHidden = false
            okayButton1.isHidden = false
        }
        
        if winner{
            print("winner")
            stack1.isHidden = true
            stack2.isHidden = true
            stack3.isHidden = true
            stack4.isHidden = true
            stack5.isHidden = true
            stack6.isHidden = true
            stack7.isHidden = true
            stack8.isHidden = true
            stack9.isHidden = true
            stack10.isHidden = true
            stack11.isHidden = true
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "finalViewController")
            show(newViewController, sender: self)
           
        }
        
    }//okay1button
    
    
    @IBAction func settingsButtonClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        if settingsButton.isSelected {
            settingsButton.isSelected = false
            musicButton.isHidden = true
            soundButton.isHidden = true
            homeButton.isHidden = true
        }else{
            settingsButton.isSelected = true
            musicButton.isHidden = false
            soundButton.isHidden = false
            homeButton.isHidden = false
        }
        
    }
    
    
    @IBAction func soundButtonClicked(_ sender: UIButton) {
        if !buttonSound{
            buttonSound = true
            soundButton.isSelected = true
        }else{
            
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
            buttonSound = false
            soundButton.isSelected = false
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
            musicButton.isSelected = true
        }else{
            musicOn = false
            //MusicPlayer.shared.startBackgroundMusic()
            GSAudio.sharedInstance.playSoundMp3(soundFileName: "slowmotion")
            musicButton.isSelected = false
        }
    }
    
    @IBAction func homeButtonClicked(_ sender: UIButton) {
        if !buttonSound{
            GSAudio.sharedInstance.playSoundWav(soundFileName: "button1")
        }
        
        questionImage.isHidden = false
        questionLabel.isHidden = false
        goHomeButton.isHidden = false
        stayButton.isHidden = false
    }
    
    @IBAction func stayButtonClicked(_ sender: UIButton) {
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
        questionImage.isHidden = true
        questionLabel.isHidden = true
        goHomeButton.isHidden = true
        stayButton.isHidden = true
    }
    
    @IBAction func goHomeClicked(_ sender: UIButton) {
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
    }
    
    
}//view controller
