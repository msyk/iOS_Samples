//
//  ViewController.h
//  CollectionView
//
//  Created by 新居雅行 on 2014/10/29.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UICollectionViewController
<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@end

