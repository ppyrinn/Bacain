//
//  SusunKataView.swift
//  MC3-SwiftUI
//
//  Created by Reyhan Rifqi on 18/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct SusunKataView: View {
    
    @State private var textField = ""

    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 1, green: 0.81, blue: 0.42))
            VStack{
                HStack{
                    ForEach(0..<5) {  index in
                        Button(action: {
                            print("\(index)")
                        }) {
                            Text("A")
                                .font(.system(size: 28, weight: .bold, design: .default))
                        }
                        .buttonStyle(SelectableButtonStyle())

                    }
                    
                }
                .padding()
                HStack{
                    ForEach(0..<5) {  index in
                        Button(action: {
                            if self.textField == ""{
                                self.textField += "\(index)"

                            }else{
                                self.textField += " - \(index)"
                            }
                        }) {
                            Text("B")
                            .font(.system(size: 28, weight: .bold, design: .default))
                        }
                    .buttonStyle(SelectableButtonStyle())
                    .padding()
                    }
                }
                .padding()
                
                HStack{
                    TextField("", text: $textField)
                        .multilineTextAlignment(.center)
                        .disabled(true)
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .frame(width: 350, height: 80, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.leading)
                    
                    Button(action: {
                        self.textField = ""
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(Color.red)

                .padding()
                }
                .padding()
                
                Button(action: {
                    print("btn")
                }) {
                    Text("Btn SUARA")
                }
            .padding()
            }
        }
    }
}

struct SusunKataView_Previews: PreviewProvider {
    static var previews: some View {
        SusunKataView()
    }
}
