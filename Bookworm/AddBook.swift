//
//  AddBook.swift
//  Bookworm
//
//  Created by Дмитрий Геращенко on 09.06.2021.
//

import SwiftUI

struct AddBook: View {
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  @State private var title = ""
  @State private var author = ""
  @State private var rating = 3
  @State private var genre = ""
  @State private var review = ""
  
  @State private var date = Date()
  
  let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
  
    var body: some View {
      NavigationView {
        Form {
          Section {
            TextField("Name of the book", text: $title)
            TextField("Author", text: $author)
            
            
            Picker("Genre", selection: $genre) {
              ForEach(genres, id: \.self) {
                Text($0)
              }
            }
            .pickerStyle(MenuPickerStyle())
          }
          
          Section {
            RatingView(rating: $rating)
            TextField("Write a review", text: $review)
          }
          
          Section {
            Button("Save") {
              let newBook = Book(context: self.moc)
              
              newBook.title = self.title
              newBook.author = self.author
              newBook.rating = Int16(self.rating)
              newBook.genre = self.genre
              newBook.review = self.review
              newBook.date = self.date
              
              try? self.moc.save()
              
              presentationMode.wrappedValue.dismiss()
            }
            .frame(maxWidth: .infinity, minHeight: 10, maxHeight: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [.red, .blue, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .clipShape(Capsule())
            .padding()
            
          }
        }
        .navigationTitle("Add Book")
      }
    }
}

struct AddBook_Previews: PreviewProvider {
    static var previews: some View {
        AddBook()
    }
}
