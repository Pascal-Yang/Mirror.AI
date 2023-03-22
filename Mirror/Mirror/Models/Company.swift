//
//  Company.swift
//  Mirror
//
//  Created by Zhiyi Tang on 2/23/23.
//  Copyright © 2023 Duy Bui. All rights reserved.
//

import Foundation
import SwiftUI

struct Company: Hashable {
    var name: String
    var logo: String
    var description: String
}


struct Companies {
    static let Default = Company(name: "default", logo: "", description: "")
    static let Google = Company(name: "Google", logo: "google_logo", description: "Google is an American multinational technology company that specializes in internet-related services and products.")
    static let Amazon = Company(name: "Amazon", logo: "amazon_logo", description: "Amazon is a multinational tech company known for its e-commerce platform, cloud computing services, digital streaming, and artificial intelligence products.")
    static let Meta = Company(name: "Meta", logo: "meta_logo", description: "Meta is a tech company that provides social networking and digital communication services.")
    static let Microsoft = Company(name: "Microsoft", logo: "microsoft_logo", description: "Microsoft is a technology company that offers software, hardware, and cloud services.")
}

struct Topics {
    static let React = Company(name: "React", logo: "react_logo", description: "A JavaScript library for building user interfaces using a component-based approach.")
    static let Python = Company(name: "Python", logo: "python_logo", description: "A high-level programming language used for web development, scientific computing, data analysis, AI, and more.")
    static let Swift = Company(name: "Swift", logo: "swift_logo", description: "A general-purpose programming language developed by Apple for developing apps for iOS, macOS, watchOS, and tvOS.")
    static let Javascript = Company(name: "Javascript", logo: "js_logo", description: "A programming language used to create dynamic web content, as well as backend development with Node.js.")
}

let companies : [Company] = [Companies.Google, Companies.Amazon, Companies.Meta, Companies.Microsoft]

let topics : [Company] = [Topics.React, Topics.Python, Topics.Swift, Topics.Javascript]
