//
//  HomeView.swift
//  SleepTimer
//
//  Created by Snow Lukin on 07.02.2022.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: Properties
    @State var startAngle: Double = 0
    // Since toProgress 0.5
    // 0.5 * 360 = 180
    @State var toAngle: Double = 180
    
    @State var startProgress: CGFloat = 0
    @State var toProgress: CGFloat = 0.5
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                VStack (alignment: .leading, spacing: 8) {
                    
                    Text("Today")
                        .font(.title.bold())
                    Text("Good Morning, Snow")
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    // Button Action...
                } label: {
                    Image("Pic")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }
            }
            
            sleepTimeSlider()
                .padding(.top, 50)
        }
        .padding()
        // Moving to the top without using Spacer
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: Sleep time circular slider
    @ViewBuilder
    func sleepTimeSlider() -> some View {
        
        GeometryReader { proxy in
            
            let width = proxy.size.width
            
            ZStack {
                
                // MARK: Clock design
                ZStack {
                    
                    ForEach(1...60, id: \.self) { index in
                        Rectangle()
                            .fill(index % 5 == 0 ? .black : .gray)
                        // Each hour will have bigger line
                            .frame(width: 2, height: index % 5 == 0 ? 10 : 5)
                        // Setting into circle
                            .offset(y: (width - 60) / 2)
                            .rotationEffect(.init(degrees: Double(index) * 6))
                    }
                    
                    // MARK: Clock text
                    let hours = [6, 9, 12, 3]
                    ForEach(hours.indices, id: \.self) { index in
                        
                        Text("\(hours[index])")
                            .font(.caption.bold())
                            .foregroundColor(.black)
                            .rotationEffect(.init(degrees: Double(index) * -90))
                            .offset(y: (width - 90) / 2)
                            .rotationEffect(.init(degrees: Double(index) * 90))
                    }
                    
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                onDrag(value: value)
                            })
                    )
                    .rotationEffect(Angle(degrees: -90))
                    
                    // MARK: Hour text
                    VStack(spacing: 6) {
                        Text("4hr")
                            .font(.largeTitle.bold())
                        
                        Text("30min")
                            .foregroundColor(.gray)
                    }
                    .scaleEffect(1.1)
                    
                }
                
                
                Circle()
                    .stroke(.black.opacity(0.06), lineWidth: 40)
                
                Circle()
                    .trim(from: startProgress, to: toProgress)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 40, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: -90))
                
                // Slider Buttons
                Image(systemName: "moon.fill")
                    .font(.callout)
                    .foregroundColor(.red)
                    .frame(width: 30, height: 30)
                // Rotating Image inside the circle
                    .rotationEffect(Angle(degrees: 90))
                    .rotationEffect(.init(degrees: startAngle))
                    .background(.white, in: Circle())
                // Moving to Right & Rotation
                    .offset(x: width / 2)
                    .rotationEffect(Angle(degrees: -90))
                    .rotationEffect(.init(degrees: startAngle))
                
                // Slider Buttons
                Image(systemName: "alarm")
                    .font(.callout)
                    .foregroundColor(.red)
                    .frame(width: 30, height: 30)
                // Rotating Image inside the circle
                    .rotationEffect(Angle(degrees: 90))
                    .rotationEffect(.init(degrees: toAngle))
                    .background(.white, in: Circle())
                // Moving to Right & Rotation
                    .offset(x: width / 2)
                    .rotationEffect(Angle(degrees: -90))
                // To the current angle
                    .rotationEffect(.init(degrees: toAngle))
            }
            
        }
        .frame(width: screenBounds().width / 1.6, height: screenBounds().width / 1.6)
    }
    
    func onDrag(value: DragGesture.Value) {
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 13 Pro Max")
    }
}

// MARK: Extentions
extension View {
    func screenBounds() -> CGRect {
        return UIScreen.main.bounds
    }
}
