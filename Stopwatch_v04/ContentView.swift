//
//  ContentView.swift
//  Stopwatch_v04
//
//  Created by Max Franz Immelmann on 4/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTime = 0.0
    
    let circleDiameter = UIScreen.main.bounds.width * 0.9
    
    var body: some View {
        let lineWidth = circleDiameter / 100
        let handLength = circleDiameter * 0.85
        
        VStack {
            Spacer()
            ZStack {
                CircleView(circleDiameter: circleDiameter,
                           lineWidth: lineWidth)
                
                OrangeHand(lineWidth: lineWidth,
                           handLength: handLength,
                           currentTime: currentTime,
                           circleDiameter: circleDiameter
                )
            }
            Spacer()
        }
        .padding()
    }
}

struct CircleView: View {
    let circleDiameter: CGFloat
    let lineWidth: CGFloat
    
    var body: some View {
        Circle()
            .fill(Color.white)
            .frame(width: circleDiameter,
                   height: circleDiameter)
        
        ForEach(0..<60, id: \.self) { tick in
            Tick(tick: tick,
                 lineWidth: lineWidth,
                 circleDiameter: circleDiameter)
        }
    }
    
    
}

struct Tick: View {
    var tick: Int
    var lineWidth: CGFloat
    var circleDiameter: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: 2,
                   height: tick % 5 == 0 ? lineWidth * 6 : lineWidth * 3)
            .offset(y: -circleDiameter / 2 + lineWidth * 3)
            .rotationEffect(Angle.degrees(Double(tick) / 60 * 360))
    }
}

struct OrangeHand: View {
    let lineWidth: CGFloat
    let handLength: CGFloat
    let currentTime: Double
    let circleDiameter: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: geometry.size.width / 2,
                                      y: geometry.size.height / 2
                                      - handLength / 10))
                path.addLine(to: CGPoint(x: geometry.size.width / 2,
                                         y: handLength))
            }
            .stroke(Color.orange, lineWidth: lineWidth)
            .rotationEffect(Angle.degrees(Double(currentTime.truncatingRemainder(dividingBy: 60)) / 60 * 360 + 180), anchor: .center)
        }
        .frame(width: lineWidth * 2, height: handLength)
        
        Circle()
            .fill(Color.orange)
            .frame(width: circleDiameter * 0.04,
                   alignment: .center)
        
        Circle()
            .fill(Color.white)
            .frame(width: circleDiameter * 0.02,
                   alignment: .center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
