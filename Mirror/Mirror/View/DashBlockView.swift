//
//  DashBlockView.swift
//  mirror-ui
//
//  Created by Ziqian Wang on 2/19/23.
//

import SwiftUI


// TODO: pass actual selectedCompany to ConfigFlowView

struct DashBlockView: View {
    
    @Binding var selectedCompany: Company


    var body: some View {
        VStack{
            
            Capsule()
                .foregroundColor(Color(.systemGroupedBackground))
                .frame(width:48, height:6)
                .padding(.top,8)
            
            //General practice
            HStack(spacing:12){
                VStack(alignment: .leading){
                    Text("GENERAL PRACTICE")
                        .foregroundColor(Color(.white))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                    
                    Text("10")
                        .foregroundColor(Color(.white))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.leading, 30)
                    
                    Text("Questions left today")
                        .foregroundColor(Color(.systemGray3))
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.leading, 30)
                    
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.white))
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height:111)
            .background(Color("Purple3"))
            .cornerRadius(30)
            .padding([.horizontal,.top])
            
            //practice by company
            Text("Practice by Company")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(Color("Purple3"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal){
                
                HStack(spacing:12){
                    ForEach(0 ..< 10, id: \.self){ _ in
                        
                        NavigationLink(destination: ConfigFlowView(selectedCompany: $selectedCompany, pages: pages)){
                            
                            VStack (alignment: .center){
                                
                                VStack (alignment: .center){
                                    Image("google_logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:120)
                                        .padding()
                                }
                                .background(Color(.white))
                                .frame(width:61, height:61)
                                .cornerRadius(20)
                                .padding(.bottom, 3)
                                
                                Text("Google")
                                    .foregroundColor(Color(.darkGray))
                                    .font(.footnote)
                            }
                            .frame(width:80, height:110)
                            .background(Color(.systemGroupedBackground))
                            .cornerRadius(25)
                        }

                        
                    }
                }
            }
            .padding(.horizontal)
            
            //practice by topic
            Text("Practice by Topic")
                .font(.headline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(Color("Purple3"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal){
                
                HStack(spacing:12){
                    ForEach(0 ..< 10, id: \.self){ _ in
                        VStack (alignment: .center){
                            
                            VStack (alignment: .center){
                                Image("react_logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:120)
                                    .padding()
                            }
                            .background(Color(.white))
                            .frame(width:61, height:61)
                            .cornerRadius(20)
                            .padding(.bottom, 3)
                            
                            Text("Google")
                                .foregroundColor(Color(.darkGray))
                                .font(.footnote)
                        }
                        .frame(width:80, height:110)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(25)
                        
                    }
                }
            }
            .padding(.bottom,40)
            .padding(.horizontal)
            
        }
        .background(Color(.white))
        .frame(maxWidth: UIScreen.main.bounds.size.width)
        .cornerRadius(50)
    }
}


struct DashBlockView_Previews: PreviewProvider {
    static var previews: some View {
        DashBlockView(selectedCompany: Binding.constant(Companies.Google))
    }
}
