//
//  grid.swift
//  containTheCorona
//
//  Created by Elizabeth Bott on 5/21/20.
//  Copyright © 2020 Elizabeth Bott. All rights reserved.
//

import UIKit
import os.log

func delete(){
    
}


@IBDesignable class GridControl: UIStackView{
    
    
    //MARK: Properties
    
    //2d array of spaces
    
    
     var spaces = [UIButton]()
    
   
    
    @IBInspectable var spaceSize: CGSize = CGSize(width: 64.0, height: 64.0){
        didSet {
            setupSpaces()
        }
    }
    @IBInspectable var spaceCount: Int = 6{
        didSet {
            setupSpaces()
        }
    }
    @IBInspectable var rowCount: Int = 11{
        didSet {
            setupSpaces()
        }
    }
    
    //MARK: Initalization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSpaces()
    }
    
    
    //MARK: Button Action
   
    
   
    @objc func GridButtonTapped(button: UIButton) {
        //print("Button pressed 👍")
        if winner == false{
            userPlayed = true
            guard spaces.firstIndex(of: button) != nil else {
                fatalError("The button, \(button), is not in the ratingButtons array: \(spaces)")
            }
            button.isSelected = true
            
            print("YOU MOVED")
            
            GamePlay().play()
        }else{
           for button in spaces {
                removeArrangedSubview(button)
                button.removeFromSuperview()
             }
            spaces.removeAll()
            for (_, _) in spaceGrid.enumerated() {
                //removeArrangedSubview(button)
               // button.removeFromSuperview()
                //button.isEnabled = false
                spaceGrid.popLast()
            }
            
            
            let label = UILabel()
            label.text = "Click Again!"
            addArrangedSubview(label)
        }
        
       // play()
       
        
    }
    
    
    
    private func setupSpaces() {
        /*for button in spaces {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }*/
        let bundle = Bundle(for: type(of: self))
        let filledSpace = UIImage(named: "blocker", in: bundle, compatibleWith: self.traitCollection)
        let emptySpace = UIImage(named:"default", in: bundle, compatibleWith: self.traitCollection)
        
        //for _ in 0..<rowCount{
        
            for _ in 0..<spaceCount {
                
                let button = UIButton()
                // Set the button images
                button.setImage(emptySpace, for: .normal)
                button.setImage(filledSpace, for: .selected)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: spaceSize.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: spaceSize.width).isActive = true
                
                
                
                //button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                
                
                // Setup the button action
                button.addTarget(self, action: #selector(GridControl.GridButtonTapped(button:)), for: .touchUpInside)
                
                
                // Add the button to the stack
                addArrangedSubview(button)
                
                spaces.append(button)
                
            
            }
        
            spaceGrid.append(spaces)
            
       // }
        
    }//setupSpaces
    
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupSpaces()
    }//init
    
    
   
   
   

}//GridContrrol
