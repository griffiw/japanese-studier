japanese-studier
================

A simple script to help study any language (I personally use it for Japanese, hence the name)

## How to use
The script takes a single command line argument, a text file, e.g.

     ./study.rb vocab.txt


 The text file must follow this format:

     "<definition you want to be asked>" = "<word in whatever language you're studying>"
     ...

## "Features"
* Randomly picks next word rather than using a repetitious sequential order
* Uses a queue to further increase variety with which words appear
* Words stop appearing once you've gotten them right 5 times

## What's next

The current required format for the text file is obviously a little goofy. I'll probably alter it to be a CSV format instead. I'll also add a command line parameter to set how many times you want to have to get a word right before it stops appearing.
