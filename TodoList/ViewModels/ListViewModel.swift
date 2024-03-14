//
//  ListViewModel.swift
//  TodoList
//
//  Created by mac on 14.3.2024.
//

import Foundation
class ListViewModel : ObservableObject{
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItem()
        }
    }
    let itemKey: String = "item_list"
    
    init(){
        getItems()
    }
    
    func getItems(){
        guard 
            let data = UserDefaults.standard.data(forKey: itemKey),
            let savedItem = try? JSONDecoder().decode([ItemModel].self, from: data)
        else 
        { return }
        self.items = savedItem
        
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }){
            items[index] = item.updateCompletion()
        }
    }
    func saveItem() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemKey)
        }
    }
}
