## WanaKana

[WanaKana.js](https://wanakana.com) is a mobile-friendly and lightweight Japanese input method editor (IME). Currently (early 2021), there are ports to [Java](https://github.com/MasterKale/WanaKanaJava) and [Rust](https://github.com/PSeitz/wana_kana_rust).

**WanaKanaSwift** is a port to Swift; I suppose technically it's more a wrapper than a port. I first wrote this code in 2019 for use in a couple of iOS apps. I decided to clean it up an make it available. 

An actual rewrite of the library in Swift is in process&mdash;hence the inclusion of most of the tests from the original JavaScript version. At some point soon, I'll include it as a branch in this repo.

### Installation

WanaKanaSwift is made available as a Swift package so there is no installation, *per se* needed. Rather you need to include the package as a dependency in your own Swift project. If you are using Xcode, then select the menu option `New > Swift Packages > Add Package Dependency...`. If you are not using Xcode, you can specify the dependency in your `Package.swift` with the following:

    .package(url: "https://github.com/profburke/wanakanaswift", from: "1.0.0")
    
NOTE: The current version of WanaKanaSwift is 0.5.0. The project uses version numbers that follow the conventions outlined at [semver.org](https://semver.org). Check the tags in the Github repo to verify the current version and update the above dependency specifier as appropriate.

##### `tokana` and `toromaji` executables

In addition to a library for use in your Swift project, this package also includes two, simple CLI utilities `tokana` and `toromaji`.

The easiest way to build and install these two utilities is from the command line. `cd` to the package's directory and run `swift build`.
The two executables will be in `.build/debug`. Copy these into a directory on your `PATH`, such as `/usr/local/bin` and you're ready to roll.

### Usage

After importing the package, you can use the functinality by calling the appropriate function. All functions are declared as static functions on 
the `WanaKana` struct (*basically the struct
is just there for name-spacing*). Examples follow:

```swift
import WanaKana

print(WanaKana.isJapanese("泣き虫")) # prints true

print(WanaKana.isHiragana("A")) # prints false

let result = WanaKana.toHiragana("スーパー") # result = "すうぱあ"

let result = WanaKana.stripOkurigana("お腹", leading: true), # result = "腹"
```

For more details, see the extended API documentation for the original JavaScript version: [https://wanakana.com/docs/global.html](https://wanakana.com/docs/global.html).

##### `tokana` and `toromaji` executables

Both of these CLI tools support reciving input either through piping

    echo "haiku toukyou oosaka" | tokana
    
or as command line arguments

    toromaji とうきょう　おおさか

### How to Contribute

Thank you for taking the time to contribute!

There are many ways to contribute in addition to submitting code. Bug reports, feature suggestions, a logo for the project, and improvements to documentation are all appreciated.

##### Bug Reports

Please submit bug reports and feature suggestions by creating a [new issue](https://github.com/profburke/wanakanaswift/issues/new). If possible, look for an existing [open issue](https://github.com/profburke/wanakanaswift/issues) that is related and comment on it.

When creating an issue, the more detail, the better. For bug reports in partciular, try to include at least the following information:

- The library version
- The operating system (macOS, Windows, etc) and version
- The expected behavior
- The observed behavior
- Step-by-step instructions for reproducing the bug

##### Pull Requests

Ensure the PR description clearly describes the problem and solution. It should include the relevant issue number, if applicable.

##### Documentation Improvements

Preferably, submit documentation changes by pull request. However, feel free to post your changes to an issue or send them to the project team.

#### TODO

- Documentation is sorely lacking...
- The `Options` struct is missing the following fields from the JavaScript version:
	- custom kana mapping
	- custom romaji mapping
- The following need improved error handling:
	- initing JSC
	- `isSpecifiedScript()`
	- `toSpecifiedScript()`
	- `stripOkurigana()`
	- `tokenize()`
		- evaluate script failure
		- casting failure
	- `tokenizeDetailed()`
		- evaluate script failure
		- casting, etc failure in loop
- Replace stringly-typing of allowed parameter in `isJapanese()` and `isRomaji()` with something type safe
- The following tests from the JavaScript version are missing:
 - `testToKana()`: Will convert punctuation but pass through spaces
 - `testToKana()`: splitIntoConvertedKana tests
 - `testToRomaji()`: Will convert punctuation and full-width spaces
- Research means for combining `tokenize()` and `tokenizeDetailed()`.


##### Notes: 

For all error handling consider making use of the `Result` type.

For combining `tokenize()` and `tokenizeDetailed()`:  Perhaps create a type that behaves like an array of strings but can be queried for additional details.


### LICENSE

The JavaScript file is licensed under the MIT license and was written by Mims H. Wright and Duncan Bay.

All Swift code written by Matthew M. Burke and licensed according to the terms in the [LICENSE](https://github.com/profburke/WanaKanaSwift/blob/main/LICENSE) file (also included in each Swift file).

