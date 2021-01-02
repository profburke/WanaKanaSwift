## WanaKana

WanaKana.js is a mobile-friendly and lightweight Japanese input method editor (IME). Currently (early 2021), there are ports to Java and Rust.

I've had this hanging around since late 2019. Going to clean this up and distribute it.

The code in the main branch just wraps the existing JavaScript library. I have in process an actual port to Swift--hence the inclusion of most of the tests from the original JavaScript version--and at some point soon, I'll include it as a branch in this repo.

### Installation

### Usage

### How to Contribute

#### TODO

- The `Options` struct is missing the following fields from the JavaScript version:
	- custom kana mapping
	- custom romaji mapping
- improved error reporting for initing JSC
- improved error reporting from isSpecifiedScript()
- improved error reporting from toSpecifiedScript()
- improved error reporting from stripOkurigana()
- improved error reporting from tokenize()
	- evaluate script failure
	- casting failure
- similarly from tokenizeDetailed()
	- evaluate script failure
	- casting, etc failure in loop
- Replace stringly-typing of allowed parameter in isJapanese() and isRomaji() with something type safe
- The following tests from the JavaScript version are missing:
 - testToKana(): Will convert punctuation but pass through spaces
 - testToKana(): splitIntoConvertedKana tests
 - testToRomaji(): Will convert punctuation and full-width spaces
- Research means for combining tokenize() and tokenizeDetailed().


##### Notes: 

For all error reporting consider making use of Result type.

For combining `tokenize()` and `tokenizeDetailed()`:  Perhaps create a type that behaves like an array of strings but can be queried for additional details.


### LICENSE

The JavaScript file is licensed under the MIT license and was written by Mims H. Wright and Duncan Bay.

All Swift code written by Matthew M. Burke and licensed according to the terms in the LICENSE file (also included in each Swift file).

