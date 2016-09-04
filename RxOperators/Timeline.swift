//
//  Timeline.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit

struct Timeline {
    let id: Int
    let profileImage: String
    let title: String
    let mainImage: String
    let price: Int
    
    init(id: Int, profileImage: String, title: String, mainImage: String, price: Int) {
        self.id = id
        self.profileImage = profileImage
        self.title = title
        self.mainImage = mainImage
        self.price = price
    }
}

extension Timeline {
    static var values: [Timeline] {
        return [
            Timeline(id: 1, profileImage: "", title: "Fabolous Sea Cottage in archipelago", mainImage: "house1", price: 2300),
            Timeline(id: 2, profileImage: "", title: "VILLA C. ALTO ECO WSurfR, ERICEIRA", mainImage: "house2", price: 8900),
            Timeline(id: 3, profileImage: "", title: "The Seashell House ~ Casa Caracol", mainImage: "house3", price: 12800),
            Timeline(id: 4, profileImage: "", title: "Old Smock Windmil in rural Kent", mainImage: "house4", price: 8760),
            Timeline(id: 5, profileImage: "", title: "Amaizing View - Moderne apartment", mainImage: "house5", price: 8900),
            Timeline(id: 6, profileImage: "", title: "Charming House in La Trinite s/mer", mainImage: "house6", price: 7500),
            Timeline(id: 7, profileImage: "", title: "Exclusive Villa apartment", mainImage: "house7", price: 5450),
            Timeline(id: 8, profileImage: "", title: "The bunk house", mainImage: "house8", price: 8900)
        ]
    }
}
