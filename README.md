# SeaLens

A guide to opening and understanding Sealens.


---



# Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Build](#build)


---

## Overview

SeaLens is a fish-identifying app that utilises Artificial Intelligence in order to categorize and cluster fish. The app breaks down underwater footage into images and organises them based on fish families. Our app streamlines the manual process, saving researchers and scientists thousands of hours.

---


## Architecture 

##### Structure (Modular MVVM + Clean)

```

SeaLens/
├── App/
│   ├── SeaLensApp.swift
│   ├── Router/                      → Handles navigation (e.g. Router.swift or NavigationPathManager)
│
├── Features/
│   ├── Home/
│   │   ├── HomePresentation.swift    → SwiftUI views (HomeView)
│   │   ├── HomeViewModel.swift       → HomeViewModel
│   │   ├── HomeDomain.swift          → Upload logic, file handling
│   │   ├── Data.swfit                → UploadService.swift
│   │
│   ├── FishCollection/
│   │   ├── FishCollectionPresentation.swift     → Gallery and species detail screens
│   │   ├── FishCollectionViewModel.swift        → FishCollectionViewModel
│   │   ├── FishCollectionDomain.swift           → Sorting, filtering, search by family
│   │   ├── FishCollectionData.swift             → SwiftData persistence logic
│
├── Shared/
│   ├── Models/
│   │   ├── Fish.swift
│   │   ├── Family.swift
│   │   ├── Project.swift
│   │   ├── Site.swift
│   │
│   ├── Services/
│   │   ├── NetworkService.swift     → For uploads/downloads to server 
│   │   ├── FileService.swift        → Handles file I/O
│   │   ├── AIService.swift          → Gemini AI endpoint calls
│   │
│   ├── Persistence/
│   │   ├── PersistenceController.swift  → SwiftData setup
│   │
│   ├── Components/                  → Reusable UI parts (buttons, cards, etc.)
│   ├── Utils/                       → Extensions, helpers, constants
│
└── Resources/
    ├── Assets.xcassets
    
```




---

## Build
open this link : https://brew.sh/
you would get this command below :
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Paste this to terminal and run it
Copy whatever on your terminal run it on terminal
then install tuist using this command below :
```
$ brew install tuist
```
eventually you would be brought to a screen to create tuist account just create it and everything
then git clone this repository
```
$ git clone https://github.com/AppleDeveloperAcademyBali/SeaLens
```
open it using this command
```
$ cd SeaLens
```
then generate .xcodeproj file using this command
```
$ tuist install && tuist generate
```
if the code doesn't work, try this one below :
```
$ tuist install && tuist generate --no-cache
```
this should open the xcode automaticallythen you can open the .xcodeproj using
```
$ open -a Xcode./SeaLens.xcodeproj

```
