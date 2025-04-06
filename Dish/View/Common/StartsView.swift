//import SwiftUI
//
//struct StarsView: View {
//    struct ClipShape: Shape {
//        let width: Double
//        
//        func path(in rect: CGRect) -> Path {
//            Path(CGRect(x: rect.minX, y: rect.minY, width: width, height: rect.height))
//        }
//    }
//    
//    @Binding var rating: Double
//    let maxRating: Int
//    
//    init(rating: Binding<Double>, maxRating: Int) {
//        self.maxRating = maxRating
//        self._rating = rating
//    }
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0..<maxRating, id: \.self) { _ in
//                Text(Image(systemName: "star"))
//                    .foregroundColor(.yellow)
//                    .aspectRatio(contentMode: .fill)
//            }
//        }.overlay(
//            GeometryReader { reader in
//                HStack(spacing: 0) {
//                    ForEach(0..<maxRating, id: \.self) { _ in
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
//                            .aspectRatio(contentMode: .fit)
//                    }
//                }
//                .clipShape(
//                    ClipShape(width: (reader.size.width / CGFloat(maxRating)) * CGFloat(rating))
//                )
//            }
//        )
//    }
//}

import SwiftUI

struct StarsView: View {
    @Binding var rating: Double
    let isInteractive: Bool
    
    init(rating: Binding<Double>, isInteractive: Bool = true) {
        self._rating = rating
        self.isInteractive = isInteractive
    }
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= Int(rating) ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        if isInteractive { // Перевірка, чи можна натискати
                            rating = (rating == Double(index)) ? 0 : Double(index)
                        }
                    }
            }
        }
    }
}
