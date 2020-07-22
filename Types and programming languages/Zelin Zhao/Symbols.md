###Useful links
[List of mathematical symbols, definition, latex code](https://en.wikipedia.org/wiki/List_of_mathematical_symbols)
[List of uncode for different symbols](https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references)

***
**:** type membership, p92
The typing relation for arithmetic expressions, written1 `t : T`, is defined by a set of inference rules assigning types to terms, summarized in Figures 8- 1 and 8-2.
`t:T` essentially is a set of mapping rules, map a term `t` to `T`. 
`T` is treated a set of terms.
![](./img/8-1.8-2.png)

***
**<:** subtyping, is a subtype of, 181
Read `S <: T` as “every value described by `S` is also
described by `T`,” that is, “the elements of `S` are a subset of the elements of `T`.”
`S` is subtype of `T`.

**<.**, cover, is covered by
> `x <. y` means that `x` is covered by `y`

***
**&#915;**, context, p77
For example, suppose that we choose to work under the following naming context:
> **&#915;** =x &#8614; 4
>> y &#8614; 3
>> z &#8614; 2
>> a &#8614; 1
>> b &#8614; 0

Then x (y z) would be represented as `4 (3 2)`.

***
**&#8866;**, inference, infers, is derived from
>x **&#8866;** y means y is derivable from x.

**&#8871;**, entailment, entails
>A **&#8871;** B means the sentence A entails the sentence B, that is in every model in which A is true, B is also true.

***
**&#8594;**, function arrow, from...to
>`f: X`**&#8594;**`Y` means the function `f` maps the set `X` into the set `Y`

**&#8614;**, function arrow, maps to
>`f: a` **&#8614;** `b` means the function `f` maps the element `a` to the element `b`.

***
###The following symbols are from 
> Formal Semantics of Programming Languages*
***
**m/X**, replace **X** with **m**
We write **&#963;[m/X]** for the state obtained from **&#963;** by replacing its contents in **X** by **m**.
***
**Lambda notation**, Section 1.3.1
It is sometimes useful to use the lambda notation (or **&#955;-notation**) to describe functions. It provides a way of refering to functions without having to name them. Suppose `f : X --> Y`is a function which for any element `x` in `X` gives a value `f(x)` which is exactly described by expression `e`, probably involving `x`. Then we sometime write
**&#955;x&#8712;X.e** for the function `f`. Thus **&#955;x&#8712;X.e = {(x,e)| x&#8712;X}**,
so **&#955;x&#8712;X.e** is just an abbreviation for the set of input-output values determined by the expression `e`.


