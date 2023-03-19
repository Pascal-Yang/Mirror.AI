//
//  Config.swift
//  Mirror
//
//  Created by Zhiyi Tang on 2/23/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation


struct ConfigPage {
    let selectedParam: String = ""
    let options: [String]
    let title: String
}

struct Options {
    static var positions = ["Software Engineer","Data Scientist","DevOps Engineer","Product Manager","UI/UX Designer","Systems Administrator", "Others"]
    
    static var questionTypes = ["Technical questions","Behavioral questions", "Situational questions"]
    
    static var numQuestions = ["1 question", "1 to 3 questions","3 to 5 questions","5 to 7 questions"]

}

struct msgOptions {
    
}


let choosePos = ConfigPage(options: Options.positions, title: "Choose Position")
let chooseType = ConfigPage(options: Options.questionTypes, title: "Choose Question Type")
let chooseNum = ConfigPage(options: Options.numQuestions, title: "Choose Number of Questions")
let startPractice = ConfigPage(options: [], title: "Start Practice")

let pages: [ConfigPage] = [chooseType, choosePos, chooseNum, startPractice]

