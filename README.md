
# Japanese Studier

An extremely simple script to help study any language (I personally use it for Japanese, hence the name)

## How to use
The script takes a single command line argument, a text file, e.g.

     ./study.rb vocab.txt


 The text file must follow this format:

     <definition you want to be asked>--<word in whatever language you're studying>
     ...

For example:

     new--あたらしい
     ...

## "Features"

* Randomly picks next word rather than using a repetitious sequential order
* Uses an MRU queue to increase the variety with which words appear
* Words stop appearing once you've gotten them right 5 times (by default)

## What's next

I'd like to add command line parameters to set how many times you want to have to get a word right before it stops appearing as well as set which side of the text file you're studying.
