<a href="https://t.me/pokedexer"> <img src="resources/images/github-related/telegram.svg" height=18 title="Follow us on Telegram"></a>
<a href="https://github.com/lateus/pokedexer"> <img src="resources/images/icons/app/appIcon.png" height=96 align="right"></a>

# Pokedexer

**The most feature-complete pokémon database for all generations that can run on any major mobile or desktop platform.**

[![License: GPL v3](resources/images/github-related/license-gplv3.svg)](LICENSE.GPLv3 "GPL v3")
[![Built with Qt](resources/images/github-related/built-with-qt.svg)](https://qt.io "The Qt Company")
[![Open-source](resources/images/github-related/open-source.svg)](https://github.com "Open-source")
[![WIP](resources/images/github-related/wip.svg)](https://github.com/lateus/pokedexer/issues "WIP: Check issues")
[![Contributions welcome](resources/images/github-related/contributions-welcome.svg)](CONTRIBUTING.md "Contributions are welcome")

:star: Star us on GitHub — it really helps!


## Table of content

- [Pokedexer](#pokedexer)
  - [Table of content](#table-of-content)
  - [Features](#features)
  - [Releases](#releases)
    - [Release status by platform](#release-status-by-platform)
  - [Build](#build)
    - [Build System](#build-system)
    - [Requirements](#requirements)
  - [Statistics](#statistics)
    - [Build and release](#build-and-release)
    - [Activity](#activity)
    - [Downloads](#downloads)
    - [Analysis](#analysis)
    - [Issue tracking](#issue-tracking)
    - [Code coverage](#code-coverage)
    - [Size](#size)
  - [License](#license)


## Features

***Pokedexer*** is more than a Pokédex:

* Pokédex (forms, stats, learnset, and more)
* Movedex
* Abilitydex
* Itemdex
* Berrydex
* Typedex
* Naturedex
* Locationdex
* Team builder
* Export/import a pokémon data as a QR code
* Integrations with save editor tools


## Releases

[![Releases](resources/images/github-related/releases.svg)](https://GitHub.com/lateus/pokedexer/releases/ "Releases")

As of today, no releases has been published yet. However, a compilable tag was published. Releases are planned for the following platforms: *Windows*, *macOS*, *Linux*, *Android*, *iOS* and *Raspberry Pi*. In the long term, we also want to release for *watchOS*, *AsteroidOS* and more embedded devices.

### Release status by platform

**Desktop platforms:**

Release type | ![win](resources/images/github-related/windows.svg "Windows") | ![mac](resources/images/github-related/macos.svg "macOS") | ![linux](resources/images/github-related/linux.svg "Linux")
-------------------------------------------|--------------------|--------------------|--------------------
Source code *(compilable)*                 | No                 | No                 | No 
Installer *(recommended)*                  | No                 | No                 | No
Portable<br> *(compressed folder)*         | No                 | No                 | No
Portable<br> *(static, single executable)* | No                 | No                 | No

**Mobile platforms:**

Release type | ![droid](resources/images/github-related/android.svg "Android") | ![ios](resources/images/github-related/ios.svg "iOS")
-------------------------------------------|--------------------|--------------------
Source code *(compilable)*                 | No                 | No
Default *(Store)*                          | No                 | No
Alternative                                | No                 | No

**Embedded platforms:**

Release type | ![raspi](resources/images/github-related/raspberry-pi.svg "Raspberry Pi")
-------------------------------------------|--------------------
Source code *(compilable)*                 | No
Installer *(recommended)*                  | No
Portable<br> *(compressed folder)*         | No
Portable<br> *(static, single executable)* | No

## Build


### Build System

[![CMake](resources/images/github-related/cmake.svg)](https://cmake.org/ "CMake")

The minimum required version is [CMake 3.16](https://cmake.org/files/v3.16/ "Download CMake 3.16"), but we always recommend the [latest version](https://cmake.org/download/ "Download CMake") available.


### Requirements

<table>
     <tr><td style="width:90px"><a href="https://qt.io/"><img src="resources/images/icons/qt/qt_logo_green.svg" title="The Qt Company"></a></td><td>This project uses the <a href="https://www.qt.io/" title="The Qt Company">Qt framework</a> for the frontend. The minimum required version is <a href="https://download.qt.io/archive/qt/6.0/6.0.0/" title="Download Qt 6.0.0">Qt 6.0.0</a>, but we always recommend using the <a href="https://download.qt.io/archive/qt/" title="Download latest version">latest version</a> available.</td></tr>
     <tr><td style="width:90px"><a href="https://golang.org/"><img src="resources/images/github-related/go.svg" title="The Go Programming Language"></a></td></tr>
     <tr><td style="width:90px"><a href="https://imagemagick.org/"><img src="resources/images/github-related/image-magick.svg" title="Image Magick"></a></td><td>Windows requires the command line tool <tt>convert</tt> (or <tt>magick convert</tt>, depending of the version used), that comes with the open-source <a href="https://imagemagick.org" title="Image Magick">ImageMagick</a> project in order to build the icon. A default icon is always provided, so this is not neccesary unless it's going to be replaced.</td></tr>
</table>


## Statistics

<!-- TODO: Add localization status -->
<!-- TODO: Add social network status -->
<!-- TODO: Add funding status -->

### Build and release
[![Build Status](https://img.shields.io/travis/lateus/pokedexer/develop)](https://travis-ci.org/lateus/pokedexer "Build status")
[![GitHub release](https://img.shields.io/github/release/lateus/pokedexer.svg)](https://GitHub.com/lateus/pokedexer/releases/ "Releases")
[![GitHub tag](https://img.shields.io/github/tag/lateus/pokedexer.svg)](https://GitHub.com/lateus/pokedexer/tags/ "Tags")

### Activity
[![GitHub contributors](https://img.shields.io/github/contributors/lateus/pokedexer.svg)](https://GitHub.com/lateus/pokedexer/commit/ "Contributors")
[![GitHub release date](https://img.shields.io/github/release-date/lateus/pokedexer.svg)](https://GitHub.com/lateus/pokedexer/releases/ "Release date")
[![Milestone](https://img.shields.io/github/milestones/progress/lateus/pokedexer/1.svg)](https://github.com/lateus/pokedexer/milestones/1 "Progress of next release")
[![GitHub commits since last release](https://img.shields.io/github/commits-since/lateus/pokedexer/latest/develop.svg)](https://GitHub.com/lateus/pokedexer/commit/ "Commits since last release")
[![GitHub last commit](https://img.shields.io/github/last-commit/lateus/pokedexer.svg)](https://GitHub.com/lateus/pokedexer/commit/ "Last commit")

### Downloads
[![Github all downloads](https://img.shields.io/github/downloads/lateus/pokedexer/total.svg)](https://GitHub.com/lateus/pokedexer/releases/ "All downloads")
[![Github latest version downloads](https://img.shields.io/github/downloads/lateus/pokedexer/latest/total.svg)](https://GitHub.com/lateus/pokedexer/releases/ "Latest version downloads")

### Analysis
![Github languages](https://img.shields.io/github/languages/count/lateus/pokedexer.svg "Languages count")
![Github top language](https://img.shields.io/github/languages/top/lateus/pokedexer.svg "Top language")
![Github languages](https://img.shields.io/scrutinizer/quality/g/lateus/pokedexer/develop.svg "Top language")

### Issue tracking
[![Github issues](https://img.shields.io/github/issues-raw/lateus/pokedexer.svg)](https://githib.com/lateus/pokedexer/issues "Open issues")
[![Pull requests](https://img.shields.io/github/issues-pr-raw/lateus/pokedexer.svg)](https://githib.com/lateus/pokedexer/pr "Open pull requests")

### Code coverage
[![Coverage Status](https://img.shields.io/coveralls/github/lateus/pokedexer/develop)](https://coveralls.io/github/lateus/pokedexer?branch=develop "Coverage status")

### Size
![Github code size](https://img.shields.io/github/languages/code-size/lateus/pokedexer.svg "Code size")
![Github repository size](https://img.shields.io/github/repo-size/lateus/pokedexer.svg "Repository size")
![Github file count](https://img.shields.io/github/directory-file-count/lateus/pokedexer.svg "File count")
![Github .cpp file count](https://img.shields.io/github/directory-file-count/lateus/pokedexer/*.svg?color=blue&extension=cpp&label=.cpp%20files.svg ".cpp file count")
![Github .qml file count](https://img.shields.io/github/directory-file-count/lateus/pokedexer/*.svg?color=blue&extension=qml&label=.qml%20files ".qml file count")


## License
[![License: GPL v3](resources/images/github-related/license-gplv3.svg)](LICENSE.GPLv3 "GPL v3")

<h2>
WIP
</h2>

[![WIP](resources/images/github-related/wip.svg)](https://github.com/lateus/pokedexer/issues "WIP: Check issues")
