//
//  WanaKana.swift
//  WanaKanaSwift
//
// Copyright (c) 2019-2021 BlueDino Software (http://bluedino.net)
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
// 1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation and/or
//    other materials provided with the distribution.
// 3. Neither the name of the copyright holder nor the names of its contributors may be
//    used to endorse or promote products derived from this software without specific prior
//    written permission.
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
// THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
// OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
// TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import Foundation
import JavaScriptCore

public struct WanaKana {
    enum Script: String {
        case hiragana = "Hiragana"
        case japanese = "Japanese"
        case kana = "Kana"
        case kanji = "Kanji"
        case katakana = "Katakana"
        case mixed = "Mixed"
        case romaji = "Romaji"
    }

    static let jsc: JSContext! = {
        let jsc = JSContext()
        
        guard let scriptURL = Bundle.module.url(forResource: "wanakana", withExtension: "js") else {
            print("Error getting URL of script")
            return nil
        }
        
        guard let script = try? String(contentsOf: scriptURL, encoding: .utf8) else {
            print("Error loading wanakana.js")
            return nil
        }
        
        guard let result = jsc?.evaluateScript(script), result.toBool() == true else {
            print("Evaluating wanakana.js did not return true.")
            return nil
        }

        return jsc
    }()

    // MARK: - Miscellaneous Methods

    public static func stripOkurigana(_ input: String, leading: Bool = false, match: String? = nil) -> String {
        let matchOption: String
        if let match = match {
            matchOption = "'\(match)'"
        } else {
            matchOption = "''"
        }
        
        let js = "wanakana.stripOkurigana('\(input)', { leading : \(leading), matchKanji: \(matchOption) })"
        guard let result = jsc.evaluateScript(js), !result.isUndefined else {
            return ""
        }

        return result.toString()
    }

    public static func tokenize(_ input: String, compact: Bool = false) -> [String] {
        let js = "wanakana.tokenize('\(input)', {compact: \(compact)})"
        guard let result = jsc.evaluateScript(js), !result.isUndefined else {
            return []
        }

        var a: [String] = []
        for e in result.toArray() {
            if let s = e as? String {
                a.append(s)
            }
        }
        
        return a
    }

    public static func tokenizeDetailed(_ input: String, compact: Bool = false) -> [TokenDetail] {
        let js = "wanakana.tokenize('\(input)', {compact: \(compact), detailed: true})"
        guard let result = jsc.evaluateScript(js), !result.isUndefined else {
            return []
        }

        var a: [TokenDetail] = []
        for e in result.toArray() {
            if let e = e as? Dictionary<String, String>,
            let rawType = e["type"],
            let type = TokenType(rawValue: rawType),
            let value = e["value"] {
                let s = TokenDetail(type: type, value: value)
                a.append(s)
            }
        }
        
        return a
    }
}
