//
//  ContentView.swift
//  StackingEssentials
//
//  Created by ivica petrsoric on 07/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct Person: Identifiable {
    let id = UUID()
    let firstName: String
    let lastName: String
    let image: UIImage
    let jobTitle: String
}


struct PeopleList: View {
    
    @State var people: [Person] = [
        .init(firstName: "Steve",
              lastName: "Jobs", image: #imageLiteral(resourceName: "jobs"), jobTitle: "Founder of Apple"),
        .init(firstName: "Tim", lastName: "Cook", image: #imageLiteral(resourceName: "cook"), jobTitle: "Apple CEO"),
        .init(firstName: "Jony", lastName: "Ive", image: #imageLiteral(resourceName: "ive"), jobTitle: "Head of Design")
    ]
    
    @State var isPresentingAddModal = false
        
    var body: some View {
        NavigationView {
            List(people) { person in
                PersonRow(person: person, didDelete: { p in
                    self.people.removeAll(where: {$0.id == person.id})
                })
            }.navigationBarTitle("People")
                .navigationBarItems(trailing: Button(action: {
                    print("Trying to add new person")
                    self.isPresentingAddModal.toggle()
                }, label: {
                    Text("Add")
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .padding(.all, 16)
                        .background(Color.green)
                }))
                .sheet(isPresented: $isPresentingAddModal, content: {
                    AddModel(isPresented: self.$isPresentingAddModal, didAddPerson: { (person) in
                        self.people.append(person)
                    })
                })
        }
    }
}

struct AddModel: View {
    
    @Binding var isPresented: Bool
    
    @State var firstName = ""
    @State var lastName = ""
    
    var didAddPerson: (Person) -> ()
    
    @State var isShowingImagePickere = false
    @State var imageInBlackBox = UIImage()
    
    var body: some View {
        VStack {
            Image(uiImage: imageInBlackBox)
            .resizable()
            .scaledToFill()
                .frame(width: 200, height: 200)
                .border(Color.black, width: 1)
                .clipped()
            
            Button(action: {
                print("Show image picker")
                self.isShowingImagePickere.toggle()
            }, label: {
                Text("Select Image")
                    .font(.system(size: 32))
                }).sheet(isPresented: $isShowingImagePickere, content: {
                    ImagePickerView(isPresented: self.$isShowingImagePickere, selectedImage: self.$imageInBlackBox)
                })
            
            HStack (spacing: 16) {
                Text("First Name")
                TextField("Enter first name", text: $firstName)
            }
            
            HStack (spacing: 16) {
                Text("Last Name")
                TextField("Enter last name", text: $lastName)
            }
            
            Button(action: {
                self.isPresented = false
                self.didAddPerson(.init(firstName: self.firstName, lastName: self.lastName, image: UIImage(), jobTitle: "Good teacher"))
            }, label: {
                Text("Add")
                    .foregroundColor(.white)
                    .padding(.all, 16)
                    .background(Color.green)
            })
            
            Button(action: {
                self.isPresented = false
            }, label: {
                Text("Cancel")
            })
            Spacer()
        }.padding(.all, 16)
    }
}

struct PersonRow: View {
    
    var person: Person
    var didDelete: (Person) -> ()
    
    var body: some View {
        HStack {
            Image(uiImage: person.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 60)
                        .strokeBorder(style: StrokeStyle(lineWidth: 2))
                        .foregroundColor(Color.black))
                .cornerRadius(60)
            
            VStack (alignment: .leading) {
                Text("\(person.firstName) \(person.lastName)")
                    .fontWeight(.bold)
                Text(person.jobTitle)
                    .fontWeight(.light)
            }.layoutPriority(1)
            
            Spacer()
            
            Button(action: {
                self.didDelete(self.person)
            }, label: {
                Text("Delete")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.all, 12)
                    .background(Color.red)
                    .cornerRadius(3)
            })
            
        }.padding(.vertical, 8)
    }
}

// picker

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self)
    }
    
    // tricky part
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
//                print(selectedImage)
                self.parent.selectedImage = selectedImage
            }
            
            self.parent.isPresented = false
        }
        
    }
    
    func updateUIViewController(_ uiViewController: ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        
    }
}

struct DummyView: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<DummyView>) -> UIButton {
        let button = UIButton()
        button.setTitle("Dummy", for: .normal)
        button.backgroundColor = .red
        return button
    }
    
    func updateUIView(_ uiView: DummyView.UIViewType, context: UIViewRepresentableContext<DummyView>) {
        
    }
    
}
