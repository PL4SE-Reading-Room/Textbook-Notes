# Full Untyped Implementation  (OCaml)

### 第四章 untyped arith expression

对ocamlyacc & ocamllex 的使用需要参考手册。

需要处理编译错误才能正常执行。

为了调试要在 ocamlc 后面统一加上 -g option。

这部分代码主要是用来上手，本身执行逻辑较为直白。

其中 eval1 函数会 raise NoRuleApplies 实际上并不是一个 Exception，恰恰是递归的退出边界，这样还避免了尾递归？

### 第七章 untyped lambda-calculus

这个calculus是含context的，context的定义就是 list of (string * binding)，而binding又有两种，一种是无信息的 namebind，一种是 TmAbbBind，具体含义是啥？