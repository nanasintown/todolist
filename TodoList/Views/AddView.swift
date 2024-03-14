//
//  AddView.swift
//  TodoList
//
//  Created by mac on 14.3.2024.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.isPresented) var isPresented
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listViewModel : ListViewModel
    @State var textFieldText : String = ""
    @State var alertTitle: String = ""
    @State var showAlert : Bool = false
    
    let barColor = #colorLiteral(red: 0.8926098347, green: 0.9038468003, blue: 0.9036490917, alpha: 1)
    var body: some View {
        ScrollView{
            VStack {
                TextField("Type something", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(barColor))
                    .cornerRadius(12)
                
                Button(action: saveButtonPressed,
                       label: {
                    Text("Save".uppercased())
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(Color.blue)
                        .cornerRadius(12)
                })
            }
                .padding(14)
            }
            .navigationTitle("Add an item")
            .alert(isPresented: $showAlert, content: getAlert)
        }
    
    func saveButtonPressed() {
        if checkTextLength(){
            listViewModel.addItem(title: textFieldText)
            if isPresented {
                dismiss()
            }
//            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    
    func checkTextLength() -> Bool{
        if textFieldText.count < 3 {
            alertTitle = "Make sure you type correctly!"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    }
    
#Preview {
    NavigationView{
        AddView()
    }
    .environmentObject(ListViewModel())
}
