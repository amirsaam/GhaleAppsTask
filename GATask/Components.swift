//
//  Components.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/28/1402 AP.
//

import SwiftUI
import Neumorphic

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading...")
            .controlSize(.large)
            .font(.footnote)
            .textCase(.uppercase)
    }
}

struct PathView: View {
    var body: some View {
       Path { path in

            path.move(to: CGPoint(x: 0, y: uiHeight * 0.45))
            
            path.addCurve(
                to: CGPoint(x: uiWidth * 0.35, y: uiHeight * 0.25),
                control1: CGPoint(x: uiWidth * 0.2, y: uiHeight * 0.4),
                control2: CGPoint(x: uiWidth * 0.1, y: uiHeight * 0.15)
            )
            
            path.addCurve(
                to: CGPoint(x: uiWidth * 0.7, y: uiHeight * 0.2),
                control1: CGPoint(x: uiWidth * 0.6, y: uiHeight * 0.325),
                control2: CGPoint(x: uiWidth * 0.45, y: uiHeight * 0.1)
            )
            
            path.addCurve(
                to: CGPoint(x: uiWidth, y: uiHeight * 0.4),
                control1: CGPoint(x: uiWidth, y: uiHeight * 0.35),
                control2: CGPoint(x: uiWidth, y: uiHeight * 0.5)
            )
            
            path.addLine(to: CGPoint(x: uiWidth, y: uiHeight))
            path.addLine(to: CGPoint(x: 0, y: uiHeight))
            path.closeSubpath()
        }
       .stroke(secondaryColor, lineWidth: 4)
       .softOuterShadow()
    }
}

struct Logo: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(secondaryColor)
                .softOuterShadow()
            Circle()
                .fill(mainColor)
                .mask {
                    Path { path in
                        let width = 200.0
                        let height = 500.0
                        
                        path.move(to: CGPoint(x: 0, y: height * 0.1))
                        
                        path.addCurve(
                            to: CGPoint(x: width * 0.55, y: height * 0.06),
                            control1: CGPoint(x: width * 0.3, y: height * 0.3),
                            control2: CGPoint(x: width * 0.2, y: 0)
                        )
                        
                        path.addCurve(
                            to: CGPoint(x: width, y: height * 0.1),
                            control1: CGPoint(x: width, y: height * 0.15),
                            control2: CGPoint(x: width, y: height * 0.05)
                        )

                        path.addLine(to: CGPoint(x: width, y: height))
                        path.addLine(to: CGPoint(x: 0, y: height))
                        path.closeSubpath()
                    }
                }
        }
    }
}
