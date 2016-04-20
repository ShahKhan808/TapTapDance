//
//  GameScene.swift
//  TapDiscs
//
//  Created by Abdullah on 03/04/2016.
//  Copyright (c) 2016 Abdullah Shah Apps. All rights reserved.
//

import SpriteKit

var scoreNumber = 0

class GameScene: SKScene {
    
    
    let scoreLabel = SKLabelNode(fontNamed: "Pusab")
    let playCorrectSoundEffect = SKAction.playSoundFileNamed("Correct.wav", waitForCompletion: false)
    let playGameOverSoundEffect = SKAction.playSoundFileNamed("GameOverSound.wav", waitForCompletion: false)
    let gameArea: CGRect
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height/maxAspectRatio
        let gameAreaMargin = (size.width - playableWidth)/2
        gameArea = CGRect(x: gameAreaMargin, y: 0, width: playableWidth, height: size.height)
        
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    override func didMoveToView(view: SKView) {
        
        scoreNumber = 0
        
        let background = SKSpriteNode(imageNamed: "DiscsBackground")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        let disc = SKSpriteNode(imageNamed: "Disc2")
        disc.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        disc.zPosition = 2
        disc.name = "discObject"
        self.addChild(disc)
        
        scoreLabel.fontSize = 200
        scoreLabel.text = "0"
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.85 )
        self.addChild(scoreLabel)
    
    }
    
    func spawnNewDisc() {
        var randomImageNumber = arc4random()%4
        randomImageNumber += 1
        
        let disc = SKSpriteNode(imageNamed: "Disc\(randomImageNumber)")
        disc.zPosition = 2
        disc.name = "discObject"
        
        let randomX = random(CGRectGetMinX(gameArea) + disc.size.width/2, max: CGRectGetMaxX(gameArea) - disc.size.width/2)
        
        let randomY = random(
            CGRectGetMinY(gameArea) + disc.size.width/2,
            max: CGRectGetMaxX(gameArea) - disc.size.height/2)
        
        disc.position = CGPoint(x: randomX, y: randomY)
        self.addChild(disc)
        
        disc.runAction(SKAction.sequence([
            SKAction.scaleTo(0, duration: 3),
            
            playGameOverSoundEffect,
            SKAction.runBlock(runGameOver)
            ]))
        
        
        
    }
    
    
    //Code for game over
    func runGameOver(){
        
        let sceneToMoveTo = GameOverScene(size: self.size)
        sceneToMoveTo.scaleMode = self.scaleMode
        
        let sceneTransition = SKTransition.fadeWithDuration(0.2)
        
        self.view!.presentScene(sceneToMoveTo, transition: sceneTransition)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let positionOfTouch = touch.locationInNode(self)
            let tappedNode = nodeAtPoint(positionOfTouch)
            let nameOfTappedNode = tappedNode.name
            
            if nameOfTappedNode == "discObject" {
                
                tappedNode.name = ""
                
                tappedNode.runAction(SKAction.sequence([
                SKAction.fadeOutWithDuration(0.1), SKAction.removeFromParent()]))
                spawnNewDisc()
                
                self.runAction(playCorrectSoundEffect)
                
                scoreNumber += 1
                scoreLabel.text = "\(scoreNumber)"
                
                if scoreNumber == 10 || scoreNumber == 25 || scoreNumber == 75 || scoreNumber == 150 || scoreNumber == 225 || scoreNumber == 300 {
                    spawnNewDisc()
                }
            }
        }
    }
}

