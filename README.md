# GameStore


## Installation

After cloning the repo open your terminal and use this command to install the app pods.

```
pod install
```


## High-Level Architecture

![High Level Architecture](https://github.com/ahmedelgendy/GamesStore/blob/master/images/block.jpg?raw=true)

## Class Diagram

![Class Diagram](https://github.com/ahmedelgendy/GamesStore/blob/master/images/class-diagram.jpg?raw=true)


## File Structure 

![File Structure](https://github.com/ahmedelgendy/GamesStore/blob/master/images/app-structure.jpg?raw=true)



## Notes

* MVVM is used as UI Design Pattern, It’s more testable in comparison to the MVC design pattern.
* I added a new layer for repositories which is responsible for fetching data from different sources (Services, Cache, Storage), that lets the rest of the app retrieve the data easily.
* XIB files are preferred over Storyboards because it makes it easy to inject whatever we want into the view controller constructor during initialization.
* Since hardcoding resources names (Fonts, images, colors) are not a good practice, I used R.swift which generates strong-typed assets.
* To increase app performance I used KingFisher library which caches images.
* UserDefaults is used to cache requests responses using requests URL(as a key), however, the solution needs enhancements for cleaning the cache periodically.



