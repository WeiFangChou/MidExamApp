//
//  Model.swift
//  MidExamApp
//
//  Created by WeiFangChou on 2022/8/9.
//

import Foundation
import UIKit

struct Quiz : Decodable{
    var question: String
    var imageUrl: String
    var answers: [Answer]
    
}

struct Answer: Decodable{
    var option: String
    var isCorrect: Bool
    
}

