
## Features

- [x] NSDate comparison operator
- [x] ActiveRecord kind of dates
- [x] Various helpers

## Requirements

- iOS 7.0+ / Mac OS X 10.9+
- Xcode 6.1

## Installation

> For application targets that do not support embedded frameworks, such as iOS 7, SwiftHelpers can be integrated by including the `DateHelper.swift` and `SwiftHelper.swift` source file directly, wrapping the top-level types in `struct SwiftHelpers` to simulate a namespace. Yes, this sucks.

_Due to the current lack of [proper infrastructure](http://cocoapods.org) for Swift dependency management, using SwiftHelpers in your project requires the following steps:_

1. Add SwiftHelpers as a [submodule](http://git-scm.com/docs/git-submodule) by opening the Terminal, `cd`-ing into your top-level project directory, and entering the command `git submodule add https://github.com/dmiotti/SwiftHelpers`
2. Open the `SwiftHelpers` folder, and drag `SwiftHelpers.xcodeproj` into the file navigator of your app project.
3. In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
4. Ensure that the deployment target of SwiftHelpers.framework matches that of the application target.
5. In the tab bar at the top of that window, open the "Build Phases" panel.
6. Expand the "Target Dependencies" group, and add `SwiftHelpers.framework`.
7. Click on the `+` button at the top left of the panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `SwiftHelpers.framework`.

---
