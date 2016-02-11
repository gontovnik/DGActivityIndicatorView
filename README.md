# DGActivityIndicatorView
DGActivityIndicatorView is a great way to make loading spinners in your application look nicer. It contains 32 different indicator view styles. Inspired by: http://connoratherton.com/loaders

![alt tag](https://raw.githubusercontent.com/gontovnik/DGActivityIndicatorView/master/DGActivityIndicatorView.gif)

## Requirements
* Xcode 6 or higher
* Apple LLVM compiler
* iOS 8.0 or higher (May work on previous versions, just did not testit. Feel free to edit it).
* ARC

## Demo

Open and run the DGActivityIndicatorExample project in Xcode to see DGActivityIndicatorView in action.

## Installation

### CocoaPods

Install CocoaPods if it is not installed yet:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Add DGActivityIndicatorView to Podfile:

``` bash
pod 'DGActivityIndicatorView'
```

Call 'pod install':

``` bash
pod install
```

### Manual install

All you need to do is drop DGActivityIndicatorView folder into your project and include headers.

## Example usage

``` objective-c
DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor whiteColor] size:20.0f];
activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
[self.view addSubview:activityIndicatorView];
[activityIndicatorView startAnimating];
```

## TODO

* Add more different animations

## Contact

Danil Gontovnik

- https://github.com/gontovnik
- https://twitter.com/gontovnik
- http://gontovnik.com/
- gontovnik.danil@gmail.com

## License

The MIT License (MIT)

Copyright (c) 2015 Danil Gontovnik

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
