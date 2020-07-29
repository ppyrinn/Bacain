//
//  OnboardingView.swift
//  MC3-SwiftUI
//
//  Created by Muhamad Vicky on 24/07/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    var subviews = ["onboarding1-progresif","onboarding2-kuis","onboarding3-trackprogress","onboarding4-eksplorasi"
    ]
    
    var titles = ["Daftar Sekolah & Kelas", "Kuis", "Track Progress Murid", "Eksplorasi"]
    
    var captions =  ["Kamu bisa memasukkan nama sekolah dan kelas yang kamu ajar.", "Kamu bisa memberikan kuis kepada murid - muridmu untuk melihat perkembangan membaca mereka.", "Kamu bisa melihat perkembangan membaca muridmu melalui progress bar.", "Kamu bisa mengajak muridmu untuk lebih mengenal fonik dan suku kata."]
    
    @State var step = 0
    @State var dragged = CGSize.zero
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack(alignment: .center) {
            HStack{
                Text("Selamat Datang di")
                .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(.black)
                Text("Bacain")
                .font(.system(size: 50, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.79, green: 0.26, blue: 0.00))
                }.accessibility(label: Text("Selamat Datang di Bacain"))
                .padding()
            GeometryReader{ gr in
                HStack{
                    ForEach(0..<4) { index in
                        HStack(alignment: .center){
                            Image(self.subviews[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                                .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2)
                                .padding()
                            VStack(alignment: .leading) {
                                Text(self.titles[index])
                                    .font(.system(size: 25, weight: .bold, design: .default))
                                
                                    .accessibility(label: Text(self.titles[index]))

                                Text(self.captions[index])
                                    .font(.system(size: 17, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                .frame(alignment: .leading)
                                .accessibility(label: Text(self.captions[index]))
                            }.padding()
                        }
                        .frame(width: gr.frame(in: .global).width)
                        .gesture(self.swipeBackOrNext())

                    }
                }
                .frame(maxHeight: .infinity)
                .animation(Animation.interpolatingSpring(stiffness: 48, damping: 8))
                .offset(x: self.calculateOffsetFor(currentPage: self.step,
                                                   basedOnPageWidth: gr.frame(in: .global).width,
                                                   andPageCount: self.subviews.count))
            }
            
                .padding()
            
            PageControl(numberOfPages: subviews.count, currentPageIndex: $step)
                Button(action: {
                    if self.step+1 == self.subviews.count {
                        self.viewRouter.currentView = "homeView"
                        
                    } else {
                        self.step += 1
                    }
                }) {
                    if self.step+1 == self.subviews.count{
                        Image("mulai-button")
                        .renderingMode(.original)
                        .padding()
                        .cornerRadius(30)
                        .accessibility(label: Text("Mulai"))
                    }else{
                        Image("lanjut-button")
                        .renderingMode(.original)
                        .padding()
                        .cornerRadius(30)
                        .accessibility(label: Text("Lanjut"))

                    }

                }
            
                .padding()
        }
    }
}





extension OnboardingView{
    func calculateOffsetFor(currentPage: Int, basedOnPageWidth pageWidth: CGFloat, andPageCount pageCount: Int) -> CGFloat {
        let alignToLeadingEdge = pageWidth * CGFloat(pageCount - 1)/2
        let presentCurrentPage = pageWidth * -CGFloat(currentPage)
        // Compensate for odd margins: If the currentPage is the first one, it is offset 2 to the left. Any subsequent view is first offset to the left and some more per page progression.
        let compensateForOddMargins = currentPage == 0 ? CGFloat(-2) : CGFloat(currentPage * -7 - 5)

        return alignToLeadingEdge + presentCurrentPage + compensateForOddMargins
    }
    
    func swipeBackOrNext() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        return DragGesture().onChanged { value in
            self.dragged = value.translation
        }
        .onEnded { _ in
            // 40 is my preferred sensitivity.
            if self.dragged.width > 40 {
                guard self.step != 0 else {
                    self.dragged = .zero
                    return }
                withAnimation { self.step -= 1 }
            }
            if self.dragged.width < -40 {
                guard self.isThereMoreToLearn else {
                    self.viewRouter.currentView = "homeView"
                    return }
                self.step += 1
            }
            self.dragged = .zero
        }
    }
    var isThereMoreToLearn: Bool {
        guard step == self.subviews.count - 1 else { return withAnimation { true } }
        return withAnimation { false }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewRouter: ViewRouter())
        
    }
}
