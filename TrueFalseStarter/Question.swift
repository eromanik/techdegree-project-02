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

// create array of questions

let questionData: [Question] = [
    Question(question: "Who played the guitar solo on the Beatles' \"While My Guitar Gently Weeps\"", answers: ["Jimi Hendrix", "George Harrison", "Eric Claption", "Jeff Beck"], correctAnswerIndex: 2, asked: false),
    Question(question: "What songwriting duo is known as \"The Glimmer Twins\"", answers: ["Mick Jagger and Kieth Richards", "John Lennon and Paul McCartney", "Elton John and Bernie Taupin"], correctAnswerIndex: 0, asked: false),
    Question(question: "In what year was the United Nations founded?", answers: ["1918", "1919", "1945", "1954"], correctAnswerIndex: 2, asked: false),
    Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", answers: ["Paris", "Washington, D.C", "New York City", "Boston"], correctAnswerIndex: 2, asked: false)
]

var questions: [Question] = []

func initializeQuestions() {
    questions = []
    questions.append(contentsOf: questionData)
}
