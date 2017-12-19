//
//  Question.swift
//  TrueFalseStarter
//
//  Created by Eric Romanik on 12/9/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import GameKit

// Variable used to identify the current question during a round of play

var indexOfSelectedQuestion: Int = 0

// Struct to hold question data

struct Question {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
    
    // Check the player's answer against the correctAnswerIndex
    
    func checkAnswer(forPlayerAnswer selected: Int) -> Bool {
        if selected == self.correctAnswerIndex {
            return true
        } else {
            return false
        }
    }
}

// Generate array of question data to be used for each round of play

let questionData: [Question] = [
    Question(question: "Who played the guitar solo on the Beatles' \"While My Guitar Gently Weeps\"?", answers: ["Jimi Hendrix", "Eric Claption", "George Harrison", "Jeff Beck"], correctAnswerIndex: 1),
    Question(question: "What songwriting duo is known as \"The Glimmer Twins\"?", answers: ["Mick Jagger and Keith Richards", "John Lennon and Paul McCartney", "Elton John and Bernie Taupin"], correctAnswerIndex: 0),
    Question(question: "Ozzy Osbourne once bit the head off of a bat on stage.", answers: ["True", "False"], correctAnswerIndex: 0),
    Question(question: "Which member of ZZ Top does not have a beard?", answers: ["Dusty Hill", "Billy Gibbons", "Frank Beard"], correctAnswerIndex: 2),
    Question(question: "What was Jimi (James) Hendrix's middle name?", answers: ["Gibson", "Fender", "Marshall", "Luther"], correctAnswerIndex: 2),
    Question(question: "What city is Aerosmith from?", answers: ["London", "Chicago", "Los Angeles", "Boston"], correctAnswerIndex: 3),
    Question(question: "Brian May, Queen's guitarist, is also...", answers: ["An astrophysicist", "An identical twin", "A marine biologist", "Ambidextrous"], correctAnswerIndex: 0)
]

// Empty array to hold the set of questions for each round

var questions: [Question] = []

// Intialize the array of questions for use during each round -- this is needed because during each round, questions are removed from the array as they are used

func initializeQuestions() {
    questions = []
    questions.append(contentsOf: questionData)
}

// Return a random question from the array of remaining questions

func getNextQuestion() -> Question {
    indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
    let question = questions[indexOfSelectedQuestion]
    
    return question
}
