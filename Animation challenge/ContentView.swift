//
//  ContentView.swift
//  Animation challenge
//
//  Created by Abigail De Micco on 29/03/22.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State var scale : CGFloat = 1
    @State var audio : AVAudioPlayer!
    let rouge = Color(red: 0.22, green: 0.05, blue: 0.14)
    var body: some View {
        
        ZStack {
            ForEach (1...50, id:\.self) { _ in
                Circle ()
                    .foregroundColor(Color (red: .random(in: 0.3...1),
                                            green: 0.1,
                                            blue: .random(in: 0.2...1)))
                
                    .blendMode(.colorDodge) // The bottom circle is lightened by an amount determined by the top layer
                    .animation (Animation.spring (dampingFraction: 0.5)
                                    .repeatForever()
                                    .speed (.random(in: 0.05...0.4))
                                    .delay(.random (in: 0...1)), value: scale
                    )
                
                    .scaleEffect(self.scale * .random(in: 0.1...3))
                    .frame(width: .random(in: 1...100),
                           height: CGFloat.random (in:20...100),
                           alignment: .center)
                    .position(CGPoint(x: .random(in: 0...1112),
                                      y: .random (in:0...834)))
            }
        }
        .onAppear {
            
            let song = NSDataAsset (name: "AmbientMusic")
            self.audio = try! AVAudioPlayer(data: song!.data, fileTypeHint: "mp3")
            self.audio.play()
            self.scale = 1.2 // default circle scale
        }
        
        .drawingGroup(opaque: false, colorMode: .linear)
        .background(
            Rectangle()
                .foregroundColor(rouge))
        .ignoresSafeArea()
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
