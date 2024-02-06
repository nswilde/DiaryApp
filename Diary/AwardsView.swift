//
//  AwardsView.swift
//  Diary
//
//  Created by Nikki Wilde on 7/02/24.
//

import SwiftUI

struct AwardsView: View {
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            //button
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.secondary.opacity(0.5))
                        }
                    }
                }
                .navigationTitle("Awards")
            }
        }
    }
}
