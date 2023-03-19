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
    static let Google = Company(name: "Google", logo: "google_logo", description: "Google is an American multinational technology company that specializes in internet-related services and products.")
    static let Amazon = Company(name: "Amazon", logo: "amazon_logo", description: "Amazon is a multinational tech company known for its e-commerce platform, cloud computing services, digital streaming, and artificial intelligence products.")
    static let Meta = Company(name: "Meta", logo: "meta_logo", description: "Meta is a tech company that provides social networking and digital communication services.")
    static let Microsoft = Company(name: "Microsoft", logo: "microsoft_logo", description: "Microsoft is a technology company that offers software, hardware, and cloud services.")

}
