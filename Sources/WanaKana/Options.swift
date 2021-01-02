//
//  Options.swift
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

public struct Options: CustomStringConvertible {
    public enum Romanization: String {
    case hepburn
    }

    public enum IMEMode: String {
    case on = "true"
    case off = "false"
    case toHiragana
    case toKatakana
    }
    
    let useObsoleteKana: Bool
    let passRomaji: Bool
    let upcaseKatakana: Bool
    let imeMode: IMEMode
    let romanization: Romanization
    
    public init(useObsoleteKana: Bool = false,
                passRomaji: Bool = false,
                upcaseKatakana: Bool = false,
                imeMode: IMEMode = .off,
                romanization: Romanization = .hepburn
                ) {
        self.useObsoleteKana = useObsoleteKana
        self.passRomaji = passRomaji
        self.upcaseKatakana = upcaseKatakana
        self.imeMode = imeMode
        self.romanization = romanization
    }

    public var description: String {
        var result = "{"

        result += "useObsoleteKana: \(useObsoleteKana)"
        result += ", passRomaji: \(passRomaji)"
        result += ", upcaseKatakana: \(upcaseKatakana)"
        result += ", IMEMode: \(imeMode.rawValue) }"
        // Since romanization only supports one value, we won't bother including it.
        
        return result
    }
}

public enum TokenType: String {
case englishNumeral
case en
case space
case englishPunctuation
case kanji
case hiragana
case katakana
case japaneseNumeral
case japanesePunctuation
case ja
case other
}

public struct TokenDetail: Equatable {
    let type: TokenType
    let value: String
}
