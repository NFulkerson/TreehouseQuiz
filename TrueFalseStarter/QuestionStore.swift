//
//  QuestionStore.swift
//  TrueFalseStarter
//
//  Created by Nathan Fulkerson on 8/15/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

struct Trivia {
    let questions: [Question] = [
        Question(text: "What is the name of Daenerys' benefactor from Pentos?", choices: ["Illyrio Mopatis", "Jaqen H'ghar", "Valar Morghulis", "Ned Stark"]),
        Question(text: "Joffrey gave his Valyrian sword what name?", choices: ["Widow's Wail", "Widow's Bane", "Weepinbell", "Kingslayer"]),
        Question(text: "The rivalry between Starks and Lannisters was inspired by the War of the Roses.", choices: ["True", "False"]),
        Question(text: "Which name is not part of Arya's 'prayer'?", choices: ["Podrick Payne", "Raff the Sweetling", "Queen Cersei", "Ser Gregor"]),
        Question(text: "Maester Aemon of the Night's Watch is a former member of what Westerosi family?", choices: ["Targaryen", "Stark", "Lannister", "Mormont"]),
        Question(text: "Which is not a name of one of Daenerys' three dragons?", choices: ["Balerion", "Viserion", "Rhaegal"]),
        Question(text: "'The Eyrie' is a castle belonging to which great house?", choices: ["Arryn","Stark", "Tully", "Baratheon"]),
        Question(text: "The Lord of Light is also known by what other name?", choices: ["R'hllor", "Arthur Dayne", "The Stranger", "The Imp"])
    ]
}

struct Question {
    var text: String
    var choices: [String]
    // assumes first choice in array will be correct answer.
    // This saves us from having to define choices and then repeat ourselves
    // by defining an answer, as the repetition leaves us open to mistakes/typos.
    // May be another way to do this without repetition.
    var correctAnswer : String {
        return choices[0]
    }
}