//
//  Question.swift
//  TrueFalseStarter
//
//  Created by Eric Romanik on 12/9/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameKit

var indexOfSelectedQuestion: Int = 0

struct Question {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
    
    func checkAnswer(forPlayerAnswer selected: Int) -> Bool {
        if selected == self.correctAnswerIndex {
            return true
        } else {
            return false
        }
    }
}

// create array of questions

let questionData: [Question] = [
    Question(question: "Who played the guitar solo on the Beatles' \"While My Guitar Gently Weeps\"?", answers: ["Jimi Hendrix", "George Harrison", "Eric Claption", "Jeff Beck"], correctAnswerIndex: 2),
    Question(question: "What songwriting duo is known as \"The Glimmer Twins\"?", answers: ["Mick Jagger and Keith Richards", "John Lennon and Paul McCartney", "Elton John and Bernie Taupin"], correctAnswerIndex: 0),
    Question(question: "Ozzy Osbourne once bit the head off of a bat on stage.", answers: ["True", "False"], correctAnswerIndex: 0),
    Question(question: "Which member of ZZ Top does not have a beard?", answers: ["Dusty Hill", "Billy Gibbons", "Frank Beard"], correctAnswerIndex: 2)
]

var questions: [Question] = []

func initializeQuestions() {
    questions = []
    questions.append(contentsOf: questionData)
}

func getNextQuestion() -> Question {
    indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
    let question = questions[indexOfSelectedQuestion]
    
    return question
}
