//
//  ViewController.swift
//  MultiPhoto
//
//  Created by Masayuki Nii on 2015/10/04.
//  Copyright © 2015年 Masayuki Nii. All rights reserved.
//

import UIKit
import AVFoundation

class MultiPhotoViewController:
    UIViewController, UIScrollViewDelegate {
    
    private var insideView: UIView?
    private var player: AVAudioPlayer?
    
    //パネルの縦横のサイズを変数に記録
    private let panelWidth: Float = 1000.0
    private let panelHeight: Float = 1000.0
    
    func playSound(fired: NSTimer)  {
        self.player?.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let musicPath = NSBundle.mainBundle()
            .pathForResource("music", ofType: "m4a")
        let musicURL = NSURL(fileURLWithPath: musicPath!)
        //サウンドファイルのパスを得て
        do {
            try self.player = AVAudioPlayer(contentsOfURL: musicURL)
                    //プレイヤにサウンドを設定
            self.player?.prepareToPlay()	//鳴らす準備をさせる
            self.player?.numberOfLoops = 100;	//繰り返し回数の設定
            self.player?.play()	//実際に鳴らす
            NSTimer.scheduledTimerWithTimeInterval(5.0,
                target: self,
                selector: #selector(MultiPhotoViewController.playSound(_:)),
                userInfo: nil, repeats: false)
        } catch {
            print("Error in AVAudioPlayer")
        }
        
        let photoFiles = ["photo1", "photo2", "photo3",
            "photo4", "photo5", "photo6"]	  //画像ファイル名を配列に入れる
        let count_x = Int(sqrt(Float(photoFiles.count)))
        let count_y = photoFiles.count /  count_x
        //縦横いくつの画像を並べるのかを決定する
        let backRect = CGRect(x: 0.0, y: 0.0,
            width: CGFloat(self.panelWidth),
            height: CGFloat(self.panelHeight))
        self.insideView = UIView(frame: backRect)  //背景のビュー
        let scrollView = self.view as! UIScrollView
        //スクロールビューがビューコントローラ配下にすでに存在
        if let inView = self.insideView {
            scrollView.addSubview(inView)
        }
        //スクロールビューに背景のビューをサブビューとして追加
        scrollView.contentSize = CGSize(
            width: CGFloat(self.panelWidth),
            height: CGFloat(self.panelHeight))
        //スクロールの中身はサブビューと同じサイズに
        scrollView.contentOffset = CGPointZero
        //スクロールビューの原点を設定
        var x = 0, y = 0
        let width = self.panelWidth / Float(count_x)
        let height = self.panelHeight / Float(count_y)
        for oneItem in photoFiles   {	//それぞれのファイル名について
            let path = NSBundle.mainBundle()
                .pathForResource(oneItem, ofType: "jpg")	//パスを取得
            let imageFrame = CGRect(
                x: CGFloat(Float(x) * width),
                y: CGFloat(Float(y) * height),
                width: CGFloat(width),
                height: CGFloat(height))  //画像の位置と大きさを求める
            let oneImage = MyImageView(frame: imageFrame)
            //イメージビューを生成し
            oneImage.userInteractionEnabled = true;  //イベントを受け付ける
            oneImage.image = UIImage(contentsOfFile: path!)
            //画像データを取得してイメージビューに画像を設定する
            self.insideView?.addSubview(oneImage)
            //イメージビューをサブビューとして追加
            x += 1
            if ( x >= count_x)  {	//カウンターが横方向の個数を超えると
                x = 0
                y += 1	//縦方向の個数のカウンターをアップ
            }
        }
        
    }
    
    func viewForZoomingInScrollView(
        scrollView: UIScrollView) -> UIView? {
            return self.insideView;
    }
    
    func scrollViewDidEndZooming(
        scrollView: UIScrollView,
        withView view: UIView?,
        atScale scale: CGFloat) {
            print("scrollViewDidEndZooming atScale \(scale)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

