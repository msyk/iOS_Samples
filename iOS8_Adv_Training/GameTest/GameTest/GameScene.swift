//
//  GameScene.swift
//  GameTest
//
//  Created by 新居雅行 on 2014/10/26.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var message: SKLabelNode?
    var timer: NSTimer?
    var count: Int32 = 0
    var ship: SKSpriteNode = SKSpriteNode(imageNamed:"Spaceship")
    var positionControl: CGFloat {
        set(aValue)    {
            let newX = self.frame.midX + self.frame.width * (aValue - 0.5)
            let newY = ship.position.y
            ship.position = CGPointMake(newX, newY)
        }
        get    {
            return 0.0
        }
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        message = SKLabelNode(fontNamed:"Chalkduster")
        if let message = message{
        message.text = "Go ahead!";
        message.fontSize = 65;
        message.position = CGPoint(x: self.frame.midX, y: self.frame.midY);
            self.addChild(message)
        }
        
        
        spaceShip()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: "repeatingTask:", userInfo: nil, repeats: true)
        println(self.frame)
        println(self.anchorPoint)
        println(self.size)
    }
    
    func didBeginContact(contact: SKPhysicsContact)    {
        println("#####")
        timer?.invalidate()
        message?.text = "Game Over!";
        self.backgroundColor = UIColor.redColor()
    }
    
    func repeatingTask(timer: NSTimer)  {
        flyingBall()
    }
    
    func randFloat() -> CGFloat    {
        return CGFloat(rand()) / CGFloat(RAND_MAX)
    }
    
    func flyingBall()   {
        let newBall = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(30, 30))
        let range: CGFloat = 1000;
        let middleY = self.frame.midX
        let yValue = middleY + range * randFloat()
        let yValueMove = middleY - range * randFloat()
        let xValue = (count % 2 == 0) ? self.frame.maxX : self.frame.minX;
        let xValueMove = (count % 2 == 0) ? self.frame.minX : self.frame.maxX;
        //newBall.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        newBall.position = CGPointMake(xValue, yValue);
        let rotateAction = SKAction.rotateByAngle(CGFloat(M_PI), duration:0.2)
        let moveAction = SKAction.moveTo(CGPointMake(xValueMove,yValueMove), duration: 3.0)
        let repeatAction = SKAction.repeatActionForever(rotateAction)
        newBall.runAction(repeatAction)
        newBall.runAction(moveAction, completion: {
            println("=====")
            newBall.removeFromParent()
        })
        newBall.physicsBody = SKPhysicsBody(rectangleOfSize: newBall.size);
            newBall.physicsBody?.categoryBitMask = 0x02;
            newBall.physicsBody?.collisionBitMask = 0x03;
            newBall.physicsBody?.contactTestBitMask = 0x03;
        self.addChild(newBall)
        count++
    }
    
    func spaceShip()    {
       // let ship = SKSpriteNode(imageNamed:"Spaceship")
        ship.xScale = 0.3
        ship.yScale = 0.3
        ship.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
        ship.physicsBody = SKPhysicsBody(rectangleOfSize: ship.size);
        ship.physicsBody?.categoryBitMask = 0x01;
        ship.physicsBody?.collisionBitMask = 0x03;
        ship.physicsBody?.contactTestBitMask = 0x03;
        self.addChild(ship)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        //        for touch: AnyObject in touches {
        //            let location = touch.locationInNode(self)
        //
        //            let sprite = SKSpriteNode(imageNamed:"Spaceship")
        //
        //            sprite.xScale = 0.5
        //            sprite.yScale = 0.5
        //            sprite.position = location
        //
        //            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        //
        //            sprite.runAction(SKAction.repeatActionForever(action))
        //
        //            self.addChild(sprite)
        //        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
