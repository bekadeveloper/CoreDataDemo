//
//  AddBookView.swift
//  CoreDataDemo
//
//  Created by Begzod on 30/05/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Binding var showingEditor: Bool
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: String = ""
    @State private var otherGenre: String = ""
    
    private static let genres = ["Non-Fiction", "Drama", "Fiction", "Thriller", "Fantasy", "Sci-Fi", "Other"]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                Text("Add Book").font(.headline)
                HStack {
                    Spacer()
                    Button("Done") {
                        let newBook = Book(context: moc)
                        newBook.author = author
                        newBook.title = title
                        newBook.genre = genre
                        newBook.id = UUID()
                        
                        try? moc.save()
                        
                        showingEditor.toggle()
                    }
                }
            }.padding()
            
            Image(systemName: "text.book.closed.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75)
                .padding()
                .foregroundColor(.blue)
            
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                
                Picker("Genre", selection: $genre) {
                    ForEach(Self.genres, id: \.self) { genre in
                        Text(genre).tag(genre)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
                if genre == "Other" {
                    TextField("Type genre", text: $otherGenre)
                }
            }
        }
    }
}
