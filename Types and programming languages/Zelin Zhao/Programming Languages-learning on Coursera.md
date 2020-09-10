###`Programming languages` is a free course on `Coursera` website. `ML` language is used in this course.

###Emacs
```
The most important commands in Emacs:
C-x C-c: Quit Emacs
C-g: Cancel the current action
C-x C-f: Open a file (whether or not it already exists)
C-x C-s: Save a file
C-x C-w: Write a file (probably more familiar to you as Save as...)

Cut, copy, paste:
Highlight text with the mouse or by hitting C-Space to set a mark and then moving the cursor to highlight a region.
C-w: Cut a highlighted region
M-w: Copy a highlighted region
C-k: Cut (kill) from the cursor to the end of the line
C-y: Paste (yank)

Some other useful commands:
C-x 2: Split the window into 2 buffers, one above the other (Use the mouse or C-x o to switch between them)
C-x 0: Undo window-splitting so there is only 1 buffer
C-x b: Switch to another buffer by entering its name
C-x C-b: See a list of all current buffers

Getting help within Emacs: In addition to the help button/menu on the right...
C-h: Hitting this will display a short message in the minibuffer: C-h (Type ? for further options).
C-h b: Key bindings. This lists all key bindings that are valid for the current mode. Note that key bindings change from mode to mode.
C-h a: Command apropos. After typing C-h a you can type a symbol and a buffer will appear that lists all symbols and functions that match that phrase.
```


###Strange syntax in ML
- Week 2, Functions Informally
```
fun pow(x : int, y : int)=
    if y = 0
    then 1
    else x * pow(x,y-1)
```
>You can define a function like previous code. If the function only has one parameter, you can call it like `function x`.
>Functions that require 0 or more than 1 arguments should be called with `()`.
>For `pow` function is previous code, you can call it like: 
```
val ans = pow(2,3) //ok

val x = (2,3)
val ans = pow x // also ok

val ans = pow 2,3 // not ok
```
>The ML compiler prints the following type information for the `pow` function: `val pow = fn : int * int -> int`.
>The `*` here is the **separating operator** between parameters' types, not the **times** operator.
> Functions in ML can't tak variable numbers of arguments.