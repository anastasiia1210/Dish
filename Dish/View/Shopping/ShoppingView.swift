import SwiftUI

struct ShoppingView: View {
    @StateObject var viewModel = ShoppingViewModel()
    @State private var showAddAlert = false
    @State private var newItem = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.shoppingItems, id: \.self) { item in
                    HStack {
                        Image(systemName: item.isDone ? "checkmark.square.fill" : "square")
                            .foregroundColor(.green)
                            .onTapGesture {
                                viewModel.updateShoppingItem(item: item)
                            }
                        Text(item.name)
                            .strikethrough(item.isDone)
                    }
                }
                .onDelete(perform: delete)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddAlert = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert("Add Item", isPresented: $showAddAlert) {
                TextField("Name", text: $newItem)
                Button("Add", action: add)
                Button("Cancel", role: .cancel) { newItem = "" }
            }
        }.onAppear{
            viewModel.loadShoppingItems()
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let item = viewModel.shoppingItems[index]
            viewModel.deleteShoppingItem(item: item)
        }
    }
    
    private func add() {
        if !newItem.isEmpty {
            viewModel.addShoppingItem(name: newItem)
            newItem = ""
        }
    }
    
}

#Preview {
    ShoppingView()
}

