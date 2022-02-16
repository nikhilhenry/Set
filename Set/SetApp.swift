//
//  SetApp.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        WindowGroup {
          let game = ShapeSetGame()
          ContentView(viewModel:game)
        }
    }
}
