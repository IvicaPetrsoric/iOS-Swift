//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe
    let action: () -> Void
    
    var body: some View {
        HStack {
            ZStack {
                Image(recipe.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(9)
                    .opacity(recipe.isLocked ? 0.8 : 1)
                    .blur(radius: recipe.isLocked ? 3.0 : 0)
                    .padding()
                
                Image(systemName: "lock.fill")
                    .font(.largeTitle)
                    .opacity(recipe.isLocked ? 1 : 0)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.title)
                Text(recipe.description)
                    .font(.caption)
            }
            Spacer()
            
            if let price = recipe.price, recipe.isLocked {
                Button("\(price)") {
                    action()
                }
                .foregroundColor(.white)
                .padding([.trailing, .leading])
                .padding([.top, .bottom], 5 )
                .background(Color.black)
                .cornerRadius(25)
            }
        }
    }
}

struct StartView: View {
    
    @EnvironmentObject private var store: Store
    
    var body: some View {
        NavigationView {
            List(store.allRecipies, id: \.self) { recipe in
                Group {
                    if !recipe.isLocked {
                        NavigationLink(destination: Text("Secret REcipe")) {
                            RecipeRow(recipe: recipe) {}
                        }
                    } else {
                        RecipeRow(recipe: recipe) {
                            if let product = store.product(for: recipe.id) {
                                store.purchaseProduct(product)
                            }
                        }
                    }
                }            .navigationBarItems(trailing: Button("Restore") {
                    store.restorePurchases()
                })
            }
            .navigationBarTitle(Text("Recipe Store"))

        }
    }
    
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
        }
    }
}
