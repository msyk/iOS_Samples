//
//  PlaceDatabase.swift
//  PlaceMap
//
//  Created by Masayuki Nii on 2015/10/04.
//  Copyright © 2015年 Masayuki Nii. All rights reserved.
//

import UIKit

class PlaceDatabase: NSObject {

    var places = []
    
    override init() {
        
        self.places = [
            ["pref":"北海道", "name":"札幌市", "latitude":43.0642, "longitude":141.3469],
            ["pref":"青森県", "name":"青森市", "latitude":40.8244, "longitude":140.7400],
            ["pref":"岩手県", "name":"盛岡市", "latitude":39.7036, "longitude":141.1525],
            ["pref":"宮城県", "name":"仙台市", "latitude":38.2689, "longitude":140.8719],
            ["pref":"秋田県", "name":"秋田市", "latitude":39.7186, "longitude":140.1025],
            ["pref":"山形県", "name":"山形市", "latitude":38.2406, "longitude":140.3633],
            ["pref":"福島県", "name":"福島市", "latitude":37.7500, "longitude":140.4678],
            ["pref":"茨城県", "name":"水戸市", "latitude":36.3414, "longitude":140.4467],
            ["pref":"栃木県", "name":"宇都宮市", "latitude":36.5658, "longitude":139.8836],
            ["pref":"群馬県", "name":"前橋市", "latitude":36.3911, "longitude":139.0608],
            ["pref":"埼玉県", "name":"さいたま市", "latitude":35.8569, "longitude":139.6489],
            ["pref":"千葉県", "name":"千葉市", "latitude":35.6047, "longitude":140.1233],
            ["pref":"東京都", "name":"新宿区", "latitude":35.6894, "longitude":139.6917],
            ["pref":"神奈川県", "name":"横浜市", "latitude":35.4478, "longitude":139.6425],
            ["pref":"新潟県", "name":"新潟市", "latitude":37.9022, "longitude":139.0236],
            ["pref":"富山県", "name":"富山市", "latitude":36.6953, "longitude":137.2114],
            ["pref":"石川県", "name":"金沢市", "latitude":36.5944, "longitude":136.6256],
            ["pref":"福井県", "name":"福井市", "latitude":36.0653, "longitude":136.2219],
            ["pref":"山梨県", "name":"甲府市", "latitude":35.6639, "longitude":138.5683],
            ["pref":"長野県", "name":"長野市", "latitude":36.6514, "longitude":138.1811],
            ["pref":"岐阜県", "name":"岐阜市", "latitude":35.3911, "longitude":136.7222],
            ["pref":"静岡県", "name":"静岡市", "latitude":34.9769, "longitude":138.3831],
            ["pref":"愛知県", "name":"名古屋市", "latitude":35.1803, "longitude":136.9067],
            ["pref":"三重県", "name":"津市", "latitude":34.7303, "longitude":136.5086],
            ["pref":"滋賀県", "name":"大津市", "latitude":35.0044, "longitude":135.8683],
            ["pref":"京都府", "name":"京都市", "latitude":35.0214, "longitude":135.7556],
            ["pref":"大阪府", "name":"大阪市", "latitude":34.6864, "longitude":135.5200],
            ["pref":"兵庫県", "name":"神戸市", "latitude":34.6914, "longitude":135.1831],
            ["pref":"奈良県", "name":"奈良市", "latitude":34.6853, "longitude":135.8328],
            ["pref":"和歌山県", "name":"和歌山市", "latitude":34.2261, "longitude":135.1675],
            ["pref":"鳥取県", "name":"鳥取市", "latitude":35.5036, "longitude":134.2383],
            ["pref":"島根県", "name":"松江市", "latitude":35.4722, "longitude":133.0506],
            ["pref":"岡山県", "name":"岡山市", "latitude":34.6617, "longitude":133.9350],
            ["pref":"広島県", "name":"広島市", "latitude":34.3964, "longitude":132.4594],
            ["pref":"山口県", "name":"山口市", "latitude":34.1858, "longitude":131.4714],
            ["pref":"徳島県", "name":"徳島市", "latitude":34.0658, "longitude":134.5594],
            ["pref":"香川県", "name":"高松市", "latitude":34.3403, "longitude":134.0433],
            ["pref":"愛媛県", "name":"松山市", "latitude":33.8417, "longitude":132.7661],
            ["pref":"高知県", "name":"高知市", "latitude":33.5597, "longitude":133.5311],
            ["pref":"福岡県", "name":"福岡市", "latitude":33.6064, "longitude":130.4181],
            ["pref":"佐賀県", "name":"佐賀市", "latitude":33.2494, "longitude":130.2989],
            ["pref":"長崎県", "name":"長崎市", "latitude":32.7447, "longitude":129.8736],
            ["pref":"熊本県", "name":"熊本市", "latitude":32.7897, "longitude":130.7417],
            ["pref":"大分県", "name":"大分市", "latitude":33.2381, "longitude":131.6125],
            ["pref":"宮崎県", "name":"宮崎市", "latitude":31.9111, "longitude":131.4239],
            ["pref":"鹿児島県", "name":"鹿児島市", "latitude":31.5603, "longitude":130.5581],
            ["pref":"沖縄県", "name":"那覇市", "latitude":26.2125, "longitude":127.6811],
        ]
        
        print(places)
    }
}
