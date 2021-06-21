//
//  ContentView.swift
//  Bookworm
//
//  Created by Дмитрий Геращенко on 09.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: Book.entity(), sortDescriptors: [
                  NSSortDescriptor(keyPath: \Book.title, ascending: true),
                  NSSortDescriptor(keyPath: \Book.author, ascending: true)
  ]) var books: FetchedResults<Book>
  
  @State private var showingAddScreen = false

  var body: some View {
    NavigationView {
      List {
        ForEach(books, id: \.self) { book in
          NavigationLink(destination: DetailView(book: book)) {
            EmojiRatingView(rating: book.rating)
              .font(.largeTitle)
            
          VStack(alignment: .leading) {
            Text(book.title ?? "Unknown title")
              .font(.headline)
              .foregroundColor(book.rating == 1 ? .red : .black)
            Text(book.author ?? "Unknown author")
              .foregroundColor(.secondary)
            }
          }
        }
        .onDelete(perform: deleteBooks)
      }
      .listStyle(PlainListStyle())
      .navigationTitle("Books")
      .navigationBarItems(leading:
                            EditButton(),
                          trailing:
                            Button(action: {
                                    self.showingAddScreen.toggle()
                            }) {
                              Image(systemName: "plus")
                            }
                            .font(.title2)
                                   
      )
      .sheet(isPresented: $showingAddScreen, content: {
        AddBook().environment(\.managedObjectContext, self.moc)
      })
    }
  }

    private func deleteBooks(offsets: IndexSet) {
        withAnimation {
            offsets.map { books[$0] }
              .forEach(moc.delete)

            do {
                try moc.save()
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
