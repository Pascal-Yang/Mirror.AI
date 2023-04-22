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

let dashboard = Guide(description: "Initiate a mock interview with mirror by selecting one of the options.",
                        title: "Dashboard",
                        img: "dashboard")

let history = Guide(description: "Click on the 'Calendar' tab to view a list of your practice problem history.",
                        title: "Practice History",
                        img: "history")

let chart = Guide(description: "Click on the 'Chart' tab to view your practice trend.",
                        title: "Practice Trend",
                        img: "chart")

let profile = Guide(description: "Click on your profile image to switch your animal avatar. Update the number of questions you want to practice per day by entering a value in the text field.",
                        title: "Profile Setting",
                        img: "profile")

let config = Guide(description: "Start by configuring your interview room by selecting from given parameters.",
                        title: "Practice Setting",
                        img: "config")

let chatButton = Guide(description: "An interview room will be generated based on your selected parameters. For each question, you can request a hint and an exmple answer.",
                            title: "AI Interview Room",
                            img: "chatButton")

let record = Guide(description: "To start answering the question, simply hit the record button at the button of the screen. Your answer will be automatically transcribed and assessed by Mirror.",
                        title: "Record Answer",
                        img: "recordMic")

let start = Guide(description: "", title: "",
                        img: " ")

let introSlides: [Guide] = [dashboard, config, chatButton, record, history, chart, profile, start]
