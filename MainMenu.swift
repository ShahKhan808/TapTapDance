//
//  MainMenuScene.swift
//  TapDiscs
//
//  Created by Abdullah on 03/04/2016.
//  Copyright © 2016 Abdullah Shah Apps. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    let clickSoundEffect = SKAction.playSoundFileNamed("click.wav", waitForCompletion: false)
    
    override func didMoveToView(view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "DiscsBackground")
        background.size = self.size
        background.zPosition = 1
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        let gameTitleLabel1 = SKLabelNode(fontNamed: "Pusab")
        gameTitleLabel1.text = "TapTap"
        gameTitleLabel1.fontSize = 60
        gameTitleLabel1.fontColor = SKColor.whiteColor()
        gameTitleLabel1.position = CGPoint(x: self.size.width/2, y: self.size.width*0.75)
        gameTitleLabel1.zPosition = 1
        self.addChild(gameTitleLabel1)
        
        let gameTitleLabel2 = SKLabelNode(fontNamed: "Pusab")
        gameTitleLabel2.text = "Discs"
        gameTitleLabel2.fontSize = 240
        gameTitleLabel2.fontColor = SKColor.whiteColor()
        gameTitleLabel2.position = CGPoint(x: self.size.width/2, y: self.size.width*0.6)
        gameTitleLabel2.zPosition = 1
        self.addChild(gameTitleLabel2)
        
        let howToPlayLabel = SKLabelNode(fontNamed: "Pusab")
        howToPlayLabel.text = "Tap discs as fast as you can!"
        howToPlayLabel.fontSize = 35
        howToPlayLabel.fontColor = SKColor.whiteColor()
        howToPlayLabel.position = CGPoint(x: self.size.width/2, y: self.size.width*0.04)
        howToPlayLabel.zPosition = 1
        self.addChild(howToPlayLabel)
        
        let descriptionLabel = SKLabelNode(fontNamed: "Pusab")
        descriptionLabel.text = "App by Abdullah Shah"
        descriptionLabel.fontSize = 40
        descriptionLabel.fontColor = SKColor.whiteColor()
        descriptionLabel.position = CGPoint(x: self.size.width/2, y: self.size.width*0.99)
        descriptionLabel.zPosition = 1
        self.addChild(descriptionLabel)
        
        let startLabel = SKLabelNode(fontNamed: "Pusab")
        startLabel.text = "PLAY"
        startLabel.fontSize = 150
        startLabel.fontColor = SKColor.whiteColor()
        startLabel.position = CGPoint(x: self.size.width/2, y: self.size.width*0.35)
        startLabel.zPosition = 1
        startLabel.name = "startButton"
        self.addChild(startLabel)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            let pointOnTouch = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(pointOnTouch)
            let tappedNodeName = tappedNode.name
            
            if tappedNodeName == "startButton" {
                
                self.runAction(clickSoundEffect)
                
                let sceneMoveTo = GameScene(size: self.size)
                sceneMoveTo.scaleMode = self.scaleMode
                let sceneTransition = SKTransition.fadeWithDuration(0.2)
                self.view?.presentScene(sceneMoveTo, transition: sceneTransition)            }
        }
    }
    
}
