//
//  RatingView.swift
//  Bookworm
//
//  Created by Дмитрий Геращенко on 10.06.2021.
//

import SwiftUI

struct RatingView: View {
  @Binding var rating: Int
  
  var label = ""
  
  var maximumRating = 5
  
  var offImage: Image?
  var onImage = Image(systemName: "star.fill")
  
  var onColor = Color.yellow
  var offColor = Color.gray
  
  
  var body: some View {
    HStack {
      if label.isEmpty == false {
        Text(label)
      }
      
      ForEach(1..<maximumRating + 1) { number in
        self.image(for: number)
          .foregroundColor(number > self.rating ? self.offColor : self.onColor)
          .onTapGesture {
            self.rating = number
          }
      }
    }
  }
  
  func image(for number: Int) -> Image {
    if number > rating {
      return offImage ?? onImage
    } else {
      return onImage
    }
  }
}
  
struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
      RatingView(rating: .constant(3))
    }
}
