Translate list of constants of type Coq's [Int31](https://coq.inria.fr/library/Coq.Numbers.Cyclic.Int31.Int31.html) to a list integers with decimal base.

For example,
```
Int31.I31 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0
          Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0
          Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D0
          Int31.D0 Int31.D0 Int31.D0 Int31.D0 Int31.D1 Int31.D0 Int31.D0 
:: nil
```
is the binary value `0000000000000000000000000000100 :: nil` which is the decimal value `[4;]`.

Run `make` in the top level to compile. To run, enter the list of input Int31 values in a text file `test`, say,
and call `./main.native test`. 
