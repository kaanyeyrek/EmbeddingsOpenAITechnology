//
//  EmbeddingResponse.swift
//  EmbedingAIProject
//
//  Created by orfeteknoloji on 28.05.2023.
//

import Foundation
// response model
struct EmbeddingResult: Codable {
    let data: [Embedding]
    let model: String
    let usage: Usage
    
struct Embedding: Codable {
        let object: String
        let embedding: [String]
        let index: Int
    }
    
struct Usage: Codable {
        let prompt_tokens: Int
        let total_tokens: Int
    }
}
