//
//  DetailView.swift
//  Bookworm
//
//  Created by Дмитрий Геращенко on 10.06.2021.
//

import SwiftUI
import CoreData


struct DetailView: View {
  
  @Environment(\.managedObjectContext) var moc
  @Environment(\.presentationMode) var presentationMode
  
  @State private var showingDeleteAlert = false
  
  let book: Book
  
    var body: some View {
      GeometryReader { geometry in
        VStack {
          ZStack(alignment: .bottomTrailing) {
            
            Image(book.genre == "" ? "Unknown" : book.genre ?? "Unknown")
              .frame(maxWidth: geometry.size.width)
            
            Text(self.book.genre?.uppercased() ?? "Unknown")
              .font(.caption)
              .fontWeight(.black)
              .padding(8)
              .foregroundColor(.white)
              .background(Color.black.opacity(0.75))
              .clipShape(Capsule())
              .offset(x: -10, y: -5)
          }
          
          Text(book.author ?? "Unknown author")
            .font(.title)
            .foregroundColor(.secondary)
          
          Text(book.review ?? "No Review")
            .padding()
          
          RatingView(rating: .constant(Int(book.rating)))
            .font(.largeTitle)
          
          Spacer()
          
          Text(book.date != nil ? "Adding date is \(book.date ?? Date(), formatter: bookDateFormatter)" : "")
            .font(.title)
            .padding(20)
          
          Spacer()
        }
      }
      .alert(isPresented: $showingDeleteAlert) {
        Alert(title: Text("Delete book"), message: Text("Are you sure?"),
              primaryButton: .destructive(Text("Delete")) { self.deleteBook()
                
              }, secondaryButton: .cancel()
        )
      }
      .navigationTitle(self.book.title ?? "Unknown Title")
      .navigationBarItems(trailing: Button(action: {
                                            self.showingDeleteAlert.toggle()
      }) {
        Image(systemName: "trash")
      })
    }
  
  func deleteBook() {
    self.moc.delete(book)
    
    presentationMode.wrappedValue.dismiss()
  }
  
  
}

private let bookDateFormatter: DateFormatter = {
  let formatter = DateFormatter()
  
  formatter.dateStyle = .medium
  formatter.timeStyle = .short
  
  return formatter
}()

struct DetailView_Previews: PreviewProvider {
  
  static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
  
    static var previews: some View {
      
      let book = Book(context: moc)
      
      book.title = "Book Title"
      book.author = "Book Author"
      book.genre = "Default"
      book.rating = 3
      book.review = "This is review."
      book.date = Date()
      
      return NavigationView {
        DetailView(book: book)
      }
    }
}
