//
//  NoItemView.swift
//  TodoList
//
//  Created by mac on 14.3.2024.
//

import SwiftUI

struct NoItemView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10){
                Text("No tasks created")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                NavigationLink(
                    destination: AddView(),
                    label: {
                    Text("Create task")
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(animate ? Color.color : Color.color1)
                            .cornerRadius(10)
                })
                .padding(.horizontal, animate ? 50 : 55)
                .shadow(
                    color: animate ? Color.green.opacity(0.3) : Color.green.opacity(0.4),
                    radius: animate ? 10 : 7)
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
    
    func addAnimation() {
        guard !animate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
            Animation
                .easeInOut(duration: 2.0)
                .repeatForever()){
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationStack{
        NoItemView()
            .navigationTitle("Something")
    }
    
}
