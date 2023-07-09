//
//  Diamond.swift
//  Set
//
//  Created by Nikhil Henry on 16/02/22.
//

import SwiftUI

struct Diamond: Shape {

  func path(in rect: CGRect) -> Path {
    let start = CGPoint(
      x: rect.midX ,
      y: rect.minY
    )
    var path = Path()

    path.move(to: start)
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
    path.addLine(to: start)

    return path
  }
}
