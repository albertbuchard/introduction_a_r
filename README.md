# R Introduction
Introductory course to R and Data analysis

Main file is scripts/markdown/introduction.pdf

# How to keep your code clean
## Coding convention
* Pick a naming convention and stick to it
  + camelCase = "this is a nice style"
  + snake_case = "this is ok too"
* Comment your code
* Look at the google style book to make sure your code is easilly readable by anyone
  + https://google.github.io/styleguide/Rguide.xml
  + they advice to use only "<-" and not "=" but i personally think it is pointless

## Storage
Keep a README.md file at the root of your folder explaining where everything is,
helping someone that knows nothing about your data to navigate your work.
Keeping your work in the cloud, through services like dropbox, icloud, or google drive.
The best would be github but it is not easy in the begining.

## Folders
Keep your folder clean, with clear names in minuscules separated by "_" :

* data
    + raw
    + preprocessed
    + analysis
        + analysis_one ...

* scripts
    + preprocessing: scripts that transforms the raw data in processed data
    + analysis: scripts that use preprocessed data and performs analysis on it
    + markdown: your markdown files
    + r_files: other R files, like utility functions

* media: here should go any ressources, presentations, images you produced or needed etc...
    + presentations
    + graphics
    + text
    + notes

* backups: you might need a backup folder when in doubt
    + data
    + script
    + media


---

Bavelier Lab 2016

(MIT License)
