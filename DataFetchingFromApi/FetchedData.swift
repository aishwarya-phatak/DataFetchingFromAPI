//
//  FetchedData.swift
//  DataFetchingFromApi
//
//  Created by Aishwarya Phatak on 11/07/22.
//  Copyright © 2022 Aishwarya Phatak. All rights reserved.
//

import Foundation
class FetchedData{
    var postId : Int
    var postTitle : String
    var postBody : String
    
    init(postId:Int, postTitle:String,postBody:String) {
        self.postId = postId
        self.postTitle = postTitle
        self.postBody = postBody
    }
}
