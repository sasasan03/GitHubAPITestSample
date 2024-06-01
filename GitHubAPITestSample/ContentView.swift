//
//  ContentView.swift
//  GitHubAPITestSample
//
//  Created by sako0602 on 2024/06/01.
//

import SwiftUI

struct ContentView: View {
    
    @State private var repositories: [GitHubRepository] = []
    
    var body: some View {
        NavigationStack{
            Group{
                if !repositories.isEmpty {
                    List(repositories, id: \.id){ repository in
                        VStack{
                            HStack{
                                Text("name:\(repository.name)")
                                Spacer()
                            }
                            HStack{
                                Text("⭐️✖️\(repository.stargazersCount)")
                                Spacer()
                            }
                        }
                    }
                } else {
                    Text("⚠️date nowloading")
                }
            }
            .navigationTitle("GitHub Repository")//NavigationStackにはつけれない。
        }
        .task {
            do {
                let repoManager = GitHubRepositoryManager()
                let _ = try await repoManager.load(user: "apple")
                repositories = repoManager.majorRepository
            } catch {
                print("unknown........")
            }
        }
    }
}


#Preview {
    ContentView()
}

