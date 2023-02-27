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
}
