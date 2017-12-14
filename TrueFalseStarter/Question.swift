//
//  Question.swift
//  TrueFalseStarter
//
//  Created by Eric Romanik on 12/9/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

struct Question {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
    var asked: Bool = false
    
}
