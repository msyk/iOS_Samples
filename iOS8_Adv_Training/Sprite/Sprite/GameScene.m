//
//  GameScene.m
//  Sprite
//
//  Created by 新居雅行 on 2014/10/30.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "GameScene.h"

@interface GameScene () <SKPhysicsContactDelegate>

@property SKLabelNode *myLabel;
@property SKSpriteNode *ship;
@property NSTimer *timer;
@property long count;

- (void)flyingBox;
- (void)repeatTask: (NSTimer *)timer;

@end

@implementation GameScene

- (CGFloat)positionControl
{
    return 0.0;
}

- (void)setPositionControl:(CGFloat) value
{
    CGFloat newX = CGRectGetMidX(self.frame)
    + CGRectGetWidth(self.frame) * (value - 0.5);
    CGFloat newY = self.ship.position.y;
    self.ship.position = CGPointMake(newX, newY);
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    [self.timer invalidate];
    self.myLabel.text = @"Game Over!";
    self.backgroundColor = [UIColor redColor];
}

-(void)didMoveToView:(SKView *)view {
    
    srand([NSDate date].timeIntervalSince1970);
    self.physicsWorld.gravity = CGVectorMake(0,0);
    self.physicsWorld.contactDelegate = self;

    self.myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    self.myLabel.text = @"Hello, World!";
    self.myLabel.fontSize = 65;
    self.myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                        CGRectGetMidY(self.frame));
    
    [self addChild: self.myLabel];
    
    self.ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    self.ship.xScale = 0.3;
    self.ship.yScale = 0.3;
    self.ship.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame) - 150);
    self.ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: self.ship.size];
    self.ship.physicsBody.categoryBitMask = 0x01;
    self.ship.physicsBody.collisionBitMask = 0x03;
    self.ship.physicsBody.contactTestBitMask = 0x02;

    [self addChild: self.ship];
    
//    [self flyingBox];
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                                  target: self
                                                selector: @selector(repeatTask:)
                                                userInfo: nil
                                                 repeats: YES];
    
}

- (void)repeatTask: (NSTimer *)timer
{
    [self flyingBox];
    self.count++;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)flyingBox
{
    CGFloat range = 1000;
    CGFloat minX = CGRectGetMinX(self.frame);
//    CGFloat minY = CGRectGetMinY(self.frame);
//    CGFloat midX = CGRectGetMidX(self.frame);
    CGFloat midY = CGRectGetMidY(self.frame);
    CGFloat maxX = CGRectGetMaxX(self.frame);
//    CGFloat maxY = CGRectGetMaxY(self.frame);
    CGFloat xValue = (self.count % 2 == 0) ? maxX : minX;
    CGFloat xValueMove = (self.count % 2 == 0) ? minX : maxX;
//    CGFloat xValue = maxX;
//    CGFloat xValueMove = minX;
    CGFloat yValue = midY + 1000 + range * rand() / RAND_MAX;
    CGFloat yValueMove = midY - 1000 - range * rand() / RAND_MAX;

    UIColor *boxColor = [UIColor blueColor];
    CGSize boxSize = CGSizeMake(30.0, 30.0);
    CGPoint boxPos = CGPointMake(xValue, yValue);
    SKSpriteNode *box = [SKSpriteNode spriteNodeWithColor: boxColor
                                                     size: boxSize];
    box.position = boxPos;
    
    SKAction *rotateAction = [SKAction rotateByAngle: M_PI/2.0
                                            duration: 0.5];
    [box runAction: [SKAction repeatActionForever: rotateAction]];
    
    CGPoint movePos = CGPointMake(xValueMove, yValueMove);
    SKAction *moveAction = [SKAction moveTo: movePos
                                   duration: 6.0];
    [box runAction: moveAction completion: ^(){
        [box removeFromParent];
    }];
    [box runAction: moveAction];
    
    box.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: box.size];
    box.physicsBody.categoryBitMask = 0x02;
//    box.physicsBody.collisionBitMask = 0x01;
//    box.physicsBody.contactTestBitMask = 0x01;
    
    [self addChild: box];
}

@end
