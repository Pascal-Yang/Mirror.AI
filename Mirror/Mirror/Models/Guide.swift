//
//  Guide.swift
//  Mirror
//
//  Created by Zhiyi Tang on 3/28/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation

struct Guide {
    let description: String
    let title: String
    let img: String
}

let config = Guide(description: "Start by configuring your interview room by selecting from given parameters.",
                        title: "Practice Setting",
                        img: "config")

let chatButton = Guide(description: "An interview room will be generated based on your selected parameters. For each question, you can request a hint and an exmple answer.",
                            title: "AI Interview Room",
                            img: "chatButton")

let record = Guide(description: "To start answering the question, simply hit the record button at the button of the screen. Your answer will be automatically transcribed and assessed by Mirror.",
                        title: "Record Answer",
                        img: "recordMic")

let introSlides: [Guide] = [config, chatButton, record]
