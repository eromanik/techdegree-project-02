//
//  PlayGame.swift
//  TrueFalseStarter
//
//  Created by Eric Romanik on 12/14/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameKit

var indexOfSelectedQuestion: Int = 0

func getNextQuestion() -> Question {
    indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
    let question = questions[indexOfSelectedQuestion]

    return question
}
