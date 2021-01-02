//
//  cliutils.swift
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
import WanaKana
import func Darwin.fputs
import var Darwin.stderr
import var Darwin.stdout

public typealias Converter = (String, Options?) -> String?

public func convert(_ converter: Converter) {
    let text = CommandLine.arguments.dropFirst().joined(separator: " ")

    if !text.isEmpty {
        guard let response = converter(text, nil) else {
            fputs("some sort of error message\n", stderr)
            exit(1)
        }
        
        fputs(response + "\n", stdout)
    } else {
        guard let text = readLine() else {
            fputs("some sort of error message\n", stderr)
            exit(1)
        }        
        
        guard let response = converter(text, nil) else {
            fputs("some sort of error message\n", stderr)
            exit(1)
        }
        
        fputs(response + "\n", stdout)
    }
}
