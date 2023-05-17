//
//  BoardingView.swift
//  GATask
//
//  Created by Amir Mohammadi on 2/23/1402 AP.
//

import SwiftUI
import Neumorphic

struct BoardingView: View {
    @State private var showLoginForm = false
    var body: some View {
        GeometryReader { geo in
            PathView()
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button {
                        showLoginForm = true
                    } label: {
                        Text("Login")
                            .textCase(.uppercase)
                            .font(.headline.bold())
                            .frame(width: geo.size.width * 0.65)
                    }
                    .softButtonStyle(
                        RoundedRectangle(cornerRadius: 10),
                        pressedEffect: .flat
                    )
                    Text("Hop into our [Waitlist](https://www.example.com) to gain early access!")
                        .font(.subheadline)
                        .padding(.top)
                }
                Spacer()
            }
            .padding(.bottom, 50)
        }
        .sheet(isPresented: $showLoginForm) {
            LoginView(showLoginView: $showLoginForm)
        }
    }
}

struct PathView: View {
    var body: some View {
       Path { path in
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            
            path.move(to: CGPoint(x: 0, y: height * 0.45))
            
            path.addCurve(
                to: CGPoint(x: width * 0.35, y: height * 0.25),
                control1: CGPoint(x: width * 0.2, y: height * 0.4),
                control2: CGPoint(x: width * 0.1, y: height * 0.15)
            )
            
            path.addCurve(
                to: CGPoint(x: width * 0.7, y: height * 0.2),
                control1: CGPoint(x: width * 0.6, y: height * 0.325),
                control2: CGPoint(x: width * 0.45, y: height * 0.1)
            )
            
            path.addCurve(
                to: CGPoint(x: width, y: height * 0.4),
                control1: CGPoint(x: width, y: height * 0.35),
                control2: CGPoint(x: width, y: height * 0.5)
            )
            
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.closeSubpath()
        }
       .stroke(secondaryColor, lineWidth: 4)
       .softOuterShadow()
    }
}

struct BoardingView_Previews: PreviewProvider {
    static var previews: some View {
        BoardingView()
    }
}
