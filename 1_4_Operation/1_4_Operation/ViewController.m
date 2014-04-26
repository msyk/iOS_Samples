//
//  ViewController.m
//  1_4_Operation
//
//  Created by Masayuki Nii on 2014/02/26.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "ViewController.h"
#import "SampleOperation.h"

@interface ViewController ()

@property (nonatomic, strong) SampleOperation *sample;

- (IBAction)test1:(id)sender;
- (IBAction)test2:(id)sender;
- (void)timerTask: (NSTimer *)timer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test1:(id)sender
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    long c = 10000;
    NSBlockOperation *b1 = [NSBlockOperation blockOperationWithBlock: ^(){
        for( int i = 0 ; i < c ; i++)   {  NSLog(@"block1"); }
    }];
    NSBlockOperation *b2 = [NSBlockOperation blockOperationWithBlock: ^(){
        for( int i = 0 ; i < c ; i++)   {  NSLog(@"block2"); }
    }];
    //======== メソッドの置き換えを行う開始点
    NSOperationQueue *q = [[NSOperationQueue alloc]init];
    [q addOperation: b1];	//2つのオペレーションは新たなスレッドで実行
    [q addOperation: b2];	//2つのオペレーションは並行して実行される
    //======== メソッドの置き換えを行う終了点

    /************************************************
     // の付与や解除は、行を選択してCommand+/が手軽です。
     ************************************************/
    // 以下のメソッドを上記の開始点〜終了点に置き換えれば、2つのオペレーションは連続的に実行できる
    //========
//    NSOperationQueue *q = [NSOperationQueue mainQueue];
//    NSLog(@"maxConcurrentOperationCount = %d", [q maxConcurrentOperationCount]);
//    [q addOperation: b1];	// b1、b2ともに、メインスレッドで実行される
//    [q addOperation: b2];	// b1のオペレーションが実行するのを待って実行する
    //========
//    NSOperationQueue *q = [[NSOperationQueue alloc]init];
//    [q addOperation: b1];	//2つのオペレーションは新たなスレッドで実行
//    [b1 addDependency: b2];	//ここでb1はb2に依存することを設定
//    [q addOperation: b2];	//その結果、先にb2が行われ、終了を待ってb1が始まる
    //========
//    NSOperationQueue *q = [[NSOperationQueue alloc]init];
//    [q addOperation: b1];	//オペレーションは新たなスレッドで実行
//    [b1 waitUntilFinished];	//b1の処理が終わるのを待つ
//    [q addOperation: b2];	//オペレーションは新たなスレッドで実行
    //========
//    NSOperationQueue *q = [[NSOperationQueue alloc]init];
//    [q setMaxConcurrentOperationCount: 1];	//最大並列数を1にする
//    [q addOperation: b1];	//オペレーションは新たなスレッドで実行
//    [q addOperation: b2];	//b1終了後にb2が開始、いずれも同じスレッド
}

- (IBAction)test2:(id)sender
{
#ifdef DEBUG
    NSLog( @"%s", __FUNCTION__ );
#endif
    SampleOperation *op1 = [[SampleOperation alloc] init];
    op1.label = @"operation-1";
    SampleOperation *op2 = [[SampleOperation alloc] init];
    op2.label = @"operation-2";
    [op2 addDependency: op1];
    
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [q addOperation: op1];
    [q addOperation: op2];
    
//    self.sample = op1;
//    [NSTimer scheduledTimerWithTimeInterval: 0.3
//                                     target: self
//                                   selector: @selector(timerTask:)
//                                   userInfo: nil
//                                    repeats: NO];
 }

- (void)timerTask: (NSTimer *)timer
{
    [self.sample cancel];
}

@end
