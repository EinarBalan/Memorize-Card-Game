//
//  ThemeWrapper.swift
//  Memorize
//
//  Created by Einar Balan on 7/5/20.
//  Copyright © 2020 Einar Balan. All rights reserved.
//

import SwiftUI

let themes: [Theme] = [
    Theme(
        name: "Halloween",
        emojis: ["🎃", "👻", "💀", "😈", "🍬", "👽", "🤖", "🧛🏻‍♂️", "🕷", "👹", "🐉", "🐍", "🤡", "👁"],
        numPairs: 6,
        primaryColor: UIColor.RGB(uiColor: UIColor.orange),
        id: 0
    ),
    Theme(
        name: "Faces",
        emojis: ["🙂", "🙃", "🥰", "🤪", "🤩", "😳", "🥵", "🤢", "🤥", "😭", "😤", "🥺", "🧐"],
        numPairs: 6,
        primaryColor: UIColor.RGB(uiColor: UIColor.yellow),
//        gradient: Gradient(colors: [.yellow, .orange]),
        id: 1
    ),
    Theme(
        name: "Animals",
        emojis: ["🐶", "🐱", "🐔", "🐣", "🐳", "🦁", "🐮", "🐷", "🐸", "🐧", "🐙", "🦕", "🦧", "🦥"],
        numPairs: 6,
        primaryColor: UIColor.RGB(uiColor: UIColor.purple),
//        gradient: Gradient(colors: [.purple, .pink]),
        id: 2
    ),
    Theme(
        name: "Nature",
        emojis: ["🍄", "🌴", "🌺", "🌵", "🐚", "🍁", "🌼", "🌻", "💐", "🌳", "🌲", "🎋", "🌷"],
        numPairs: 6,
        primaryColor: UIColor.RGB(uiColor: UIColor.cyan),
//        gradient: Gradient(colors: [.blue, .green]),
        id: 3
    ),
    Theme(
        name: "Food",
        emojis: ["🍊", "🍌", "🍉", "🍒", "🥑", "🍆", "🍖", "🌯", "🍕", "🍣", "🍭", "🍺", "🍦"],
        numPairs: 6,
        primaryColor: UIColor.RGB(uiColor: UIColor.magenta),
//        gradient: Gradient(colors: [.pink, .red, .orange]),
        id: 4
    ),
    Theme(
        name: "Weather",
        emojis: ["🌪", "🌈", "☀️", "🌤", "☁️", "🌧", "⚡️", "❄️", "☔️", "💫", "☄️", "🔥", "🌬"],
        numPairs: 6,
        primaryColor: UIColor.RGB(uiColor: UIColor.blue),
        id: 5
    )
]

struct Theme: Identifiable, Codable {
    var name: String
    var emojis: [String]
    var numPairs: Int?
    var primaryColor: UIColor.RGB
//    var gradient: Gradient?
    var secondaryColor = UIColor.RGB(uiColor: UIColor.white)
    var id: Int
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    static var currentTheme: Theme = themes.randomElement()!
    
    static func setUniqueRandomTheme() {
        var theme: Theme
        repeat {
            theme = themes.randomElement()!
        } while theme.id == currentTheme.id
        currentTheme = theme
        
    }
}
