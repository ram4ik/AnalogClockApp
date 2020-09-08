//
//  Home.swift
//  AnalogClockApp
//
//  Created by Ramill Ibragimov on 08.09.2020.
//

import SwiftUI

struct Home: View {
    @Binding var isDark: Bool
    
    var width = UIScreen.main.bounds.width
    
    @State var currentTime = Time(min: 0, sec: 0, hour: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                Text("Analog Clock")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    isDark.toggle()
                }, label: {
                    Image(systemName: isDark ? "sun.min.fill" : "moon.fill")
                        .font(.system(size: 22))
                        .foregroundColor(isDark ? .black : .white)
                        .padding()
                        .background(Color.primary)
                        .clipShape(Circle())
                })
            }.padding()
            
            Spacer(minLength: 0)
            
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                
                ForEach(0..<60, id: \.self) { i in
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 2, height: (i % 5) == 0 ? 15 : 5)
                        .offset(y: (width - 110) / 2)
                        .rotationEffect(.init(degrees: Double(i) * 6))
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 2, height: (width - 180) / 2)
                        .offset(y: -(width - 180) / 4)
                        .rotationEffect(.init(degrees: Double(currentTime.sec) * 6))
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 4, height: (width - 200) / 2)
                        .offset(y: -(width - 200) / 4)
                        .rotationEffect(.init(degrees: Double(currentTime.min) * 6))
                    
                    Rectangle()
                        .fill(Color.primary)
                        .frame(width: 4.5, height: (width - 240) / 2)
                        .offset(y: -(width - 240) / 4)
                        .rotationEffect(.init(degrees: Double(currentTime.hour) * 30))
                    
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 15, height: 15)
                }
                
            }
            .frame(width: width - 80, height: width - 80)
            
            Spacer(minLength: 0)
        }
        .onAppear() {
            let calendar = Calendar.current
            
            let sec = calendar.component(.second, from: Date())
            let min = calendar.component(.minute, from: Date())
            let hour = calendar.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)) {
                
                currentTime = Time(min: min, sec: sec, hour: hour)
            }
        }
        .onReceive(receiver, perform: { _ in
            
            let calendar = Calendar.current
            
            let sec = calendar.component(.second, from: Date())
            let min = calendar.component(.minute, from: Date())
            let hour = calendar.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)) {
                
                currentTime = Time(min: min, sec: sec, hour: hour)
            }
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(isDark: .constant(true))
    }
}
