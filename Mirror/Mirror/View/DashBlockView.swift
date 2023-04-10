//
//  DashBlockView.swift
//  mirror-ui
//
//  Created by Ziqian Wang on 2/19/23.
//

import SwiftUI

struct DashBlockView: View {
    
    @Binding var selectedCompany: Company
    @State var displayedName: String = "unknown"
    @State var displayedAvatar: String = "myavatar"

    var body: some View {
        ScrollView(.vertical){
            VStack{
                
                Spacer()
                    .frame(maxHeight: 10)
                
                HStack{
                    
                    // TO-DO: change second-user name in DataSource
                    
                    Text((FirebaseManager.shared.auth.currentUser != nil ? DataSource.secondUser.name : "Guest"))
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(Color("Purple3"))
                   
                    
                    Spacer()

                    Image((FirebaseManager.shared.auth.currentUser != nil ? DataSource.secondUser.avatar : "myavatar"))
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .padding(.top, 16)
                    
                }
                .padding(.horizontal)
                Spacer()
                
                
                
                Capsule()
                    .foregroundColor(Color(.systemGroupedBackground))
                    .frame(width:48, height:6)
                    .padding(.top,8)
                
                //General practice
                
                HStack(spacing:12){
                    
                    NavigationLink(destination: ConfigFlowView(selectedCompany: Companies.Default)){
                        
                        VStack(alignment: .leading){
                            Text("GENERAL PRACTICE")
                                .foregroundColor(Color(.white))
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.leading, 30)
                            
                            Text("\(max(DataSource.secondUser.quesPerDay - countConversationsToday(conversations: questionList), 0))")
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
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing:12){
                        ForEach(companies, id: \.name){ company in
                            
                            NavigationLink(destination: ConfigFlowView(selectedCompany: company)){
                                
                                VStack (alignment: .center){
                                    
                                    VStack (alignment: .center){
                                        Image(company.logo)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:120)
                                            .padding()
                                    }
                                    .background(Color(.white))
                                    .frame(width:80, height:80)
                                    .cornerRadius(25)
                                    .padding(.bottom, 3)
                                    
                                    Text(company.name)
                                        .foregroundColor(Color(.darkGray))
                                        .font(.footnote)
                                    
                                }
                                .frame(width:110, height:140)
                                .background(Color(.systemGroupedBackground))
                                .cornerRadius(30)
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
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing:12){
                        ForEach(topics, id: \.name){ topic in
                            
                            NavigationLink(destination: ConfigFlowView(selectedCompany: topic)){
                                
                                VStack (alignment: .center){
                                    
                                    VStack (alignment: .center){
                                        Image(topic.logo)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:120)
                                            .padding()
                                    }
                                    .background(Color(.white))
                                    .frame(width:61, height:61)
                                    .cornerRadius(20)
                                    .padding(.bottom, 3)
                                    
                                    Text(topic.name)
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
                .padding(.bottom,40)
                .padding(.horizontal)
                
            }
            .background(Color(.white))
            .frame(maxWidth: UIScreen.main.bounds.size.width)
            .cornerRadius(50)
        }
    }
}


struct DashBlockView_Previews: PreviewProvider {
    static var previews: some View {
        DashBlockView(selectedCompany: Binding.constant(Companies.Google))
    }
}
