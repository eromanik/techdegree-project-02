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

let questions: [Question] = [
    Question(question: "This was the only US President to serve more than two consecutive terms.", answers: ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"], correctAnswerIndex: 1, asked: false),
    Question(question: "Which of the following countries has the most residents?", answers: ["Nigeria", "Russia", "Iran", "Vietnam"], correctAnswerIndex: 0, asked: false),
]
