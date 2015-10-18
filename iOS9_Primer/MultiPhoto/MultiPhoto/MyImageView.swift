//
//  MyImageView.swift
//  MultiPhoto
//
//  Created by Masayuki Nii on 2015/10/04.
//  Copyright © 2015年 Masayuki Nii. All rights reserved.
//

import UIKit

class MyImageView: UIImageView {

    private var previousFrame: CGRect?
    
    override func touchesBegan( //タッチイベントを開始した
        touches: Set<UITouch>,
        withEvent event: UIEvent?) {
        print(__FUNCTION__) //呼び出された関数名をコンソールへ
        
        if event?.allTouches()?.count == 1 {  //1本指なら
            self.previousFrame = frame; //現在のframeをプロパティに退避
            let shrinked = CGRect(  //点になった時のCGRectを求めて
                x: self.frame.origin.x + self.frame.size.width / 2,
                y: self.frame.origin.y + self.frame.size.height / 2,
                width: 0.0,
                height: 0.0)
            UIView.animateWithDuration( 1.0,
                animations: {self.frame = shrinked})
                //アニメーションしながら画像が小さくなる
        }
    }
    
    override func touchesEnded( //タッチベントを終了した
        touches: Set<UITouch>,
        withEvent event: UIEvent?) {
        print(__FUNCTION__) //呼び出された関数名をコンソールへ
        
        UIView.animateWithDuration( 1.0,
            animations: {   //アニメーションしながら
                if let changedFrame = self.previousFrame {
                    self.frame = changedFrame
                        //覚えておいたサイズと位置に戻す
                }
        })
    }
    
    override func touchesMoved( //タッチ中にポイントを移動した
        touches: Set<UITouch>,
        withEvent event: UIEvent?) {
        print(__FUNCTION__)
    }
}
