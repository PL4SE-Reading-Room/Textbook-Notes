# Full Untyped Implementation  (OCaml)

### 第四章 untyped arith expression

如何正确编译（我使用 ocaml 4.10.0）：

1. **删去 --unsafe-... 编译选项，貌似新版ocamlc不支持该编译参数；**
2. **在 lexer.mll 中涉及到 API 类型签名的变化，都是说API想要string，但是给的参数是bytes，很简单，在对应参数前加 Bytes.to_string 即可；**
3. **如果想单步调试 ocamldebug，需要在makefile中每个ocamlc加上 -g 选项。**
4. **对ocamlyacc & ocamllex 的使用需要参考手册。**

这部分代码主要是用来上手，本身执行逻辑较为直白。

其中 eval1 函数会 raise NoRuleApplies 实际上并不是一个 Exception，恰恰是递归的退出边界，这样还避免了尾递归。

设计printing_format部分我没有仔细看。

### 第七章 untyped lambda-calculus

在深入实现之前，先明白为什么可以使用 nameless representation of terms，目的是通过数字而不是符号，直接表达lambda表达式，这样更容易检验实现是否正确。而纯符号化很难(??)检验。

为了实现 nameless Rep，就需要设计策略，如何对 lambda 表达式中涉及的变量进行编号呢？专有名词：Brujin indexed term (from the inside out)，首先对任意给定的term，拥有一套将bound variable和free variable转换成固定数字的套路。之后要考虑在substitution的情况下，如何更新term中的各种变量的变化。对一个term进行更新，有个上下界(c, d)，对于小于c的都是inner bound variables，不需要更新；反之都是当前term的free variables，需要+d。

讲道理，这个Brujin indexed编码方式对一般人还是很不友好的...编码后的lambda表达式看起来比较别扭，不直观，同样的数字0，在不同的lambda嵌套层次，表示的就不是同一个变量。6.3.2 问题讨论了另一种 from the outside in 的编码策略，看上去更舒服。

这个calculus是含context的，context的定义就是 list of (string * binding)，而binding又有两种，一种是无信息的 namebind，一种是 TmAbbBind，具体含义是啥？

讲道理，这个代码虽短，但是还没有消化透彻。

