Translate list of constants of type Coq's [Int31](https://coq.inria.fr/library/Coq.Numbers.Cyclic.Int31.Int31.html) to a list integers with decimal base or vice versa.

Use the keyword `DEC` for decimal to Int31 conversion and the keyword `INT31` for Int31 to decimal conversion at the beginning of the file, followed by a list of values of the appropriate type separated by `::` and terminated by `nil`.

For example,
```
INT31 Int31.I31 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0
          Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0
          Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0
          Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D1 Int31.D0 Int31.D0 
:: nil
```
gives output `[4;]` and 
```
DEC 65535 :: 0 :: nil
```
gives output 
```
Int31.I31 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 
          Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D1 Int31.D1 Int31.D1 Int31.D1 
          Int31.D1 Int31.D1 Int31.D1 Int31.D1 Int31.D1 Int31.D1 Int31.D1 Int31.D1 Int31.D1 
          Int31.D1 Int31.D1 Int31.D1  
:: Int31.I31 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 
             Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 
             Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 
             Int31.D0 Int31.D0 Int31.D0
:: nil
```

The input file can have as many of these `INT31` and `DEC` values separated by white space.

Run `make` in the top level to compile. To run, enter the list of input Int31 values in a text file `test`, say,
and call `./main.native test`. 