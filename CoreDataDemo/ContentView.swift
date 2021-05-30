//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by Begzod on 29/05/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)])
    private var books: FetchedResults<Book>

    @State private var isAddingBook: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    VStack(alignment: .leading) {
                        Text(book.title ?? "unknown")
                        Text(book.author ?? "unknown").font(.caption).fontWeight(.semibold)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle(Text("Books in CoreData"))
            .navigationBarItems(leading: Button(action: { isAddingBook.toggle() }) {
                Image(systemName: "plus.circle.fill")
            }, trailing: EditButton())
        }
        .sheet(isPresented: $isAddingBook) {
            AddBookView(showingEditor: $isAddingBook)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { books[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
