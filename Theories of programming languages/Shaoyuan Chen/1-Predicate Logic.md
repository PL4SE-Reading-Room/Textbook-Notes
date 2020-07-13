# 谓词逻辑

## 抽象语法

抽象语法vs.具体语法：

1. 抽象语法并不关心表达式的具体字符串表示，但具体语法关心。
2. 抽象语法的每个产生式默认自动加括号，因此通常不存在歧义。

> 例：`<intexp> ::= <intexp> ÷ <intexp>`和`<intexp> ::= div <intexp> <intexp>` 在抽象意义上是等价的，因为它们都表示二元除法运算，虽然它们的具体表示形式不同。

### 抽象语法抽象在哪里?

- 对于每个非终结符，其对应表达式的的集合称为该非终结符的*carrier*；可以用该非终结符的名称表示它的carrier；
- 每个形如$L ::= s_0 R_0 \cdots R_n s_n$（大写字母表示非终结符，小写字母是终结符号串）的产生式对应一个从$R_0 \times \cdots \times R_n$到$L$的映射，称为该产生式的*constructor*。

Carrier和constructor必须满足如下性质：

1. Constructor必须是单射；

2. 左侧相同的产生式对应的constructor必须有着不相交的值域；

3. 非预定义终结符的carrier中的每个元素都可以从预定义的nonterminal出发，通过有限次地运用这些constructor获得。

   这一点可以用如下方式形式化定义：对于非终结符$L$，令$L^{(n)}$表示经过$n$步应用得到的非终结符$L$的phrase，则$L$的carrier为$\bigcup_{i=0}^{\infty} L^{(i)}$。

> 例：对于下图所示的谓词逻辑抽象语法
>
> ![image-20200713222032665](1-Predicate%20Logic.assets/image-20200713222032665.png)
>
> 其constructor为 
>
> ![image-20200713222053916](1-Predicate%20Logic.assets/image-20200713222053916.png)

> 注：对于集合$A, B$，$A \rightarrow B$为所有从$A$映射到$B$的函数集合；运算符$\rightarrow$是右结合的。

## 谓词逻辑的指称语义

状态：是指变量`<var>`到$\mathbb{Z}$的映射；我们用$\Sigma = \text{<var>} \rightarrow \mathbb{Z}$表示所有状态的集合，而$\sigma \in \Sigma$表示一个状态。

表达式的指称语义：`<intexp>`和`<assert>`表达式的值取决于其中变量的值，因此其可以视为状态的函数。例如，`<intexp>`语义具有$\Sigma \rightarrow \mathbb{Z}$的类型。

语义函数：语义函数将表达式映射到其语义。通常用$[\![\cdot]\!]$表示语义函数。
$$
[\![\cdot]\!]_{\rm intexp} \in \textrm{<intexp>} \rightarrow \Sigma \rightarrow \mathbb{Z} \\ 
[\![\cdot]\!]_{\rm assert} \in \textrm{<assert>} \rightarrow \Sigma \rightarrow \mathbb{B}
$$
分别为`<intexp>`和`<assert>`的指称语义。

> 例：表达式的可以由一系列语义等式定义。对于
> $$
> [\![\forall v. p]\!]_{\rm assert}  \sigma = \forall n \in \mathbb{Z}. [\![p]\!]_{\rm assert} [\sigma|v:n] \\ 
> [\![\exists v. p]\!]_{\rm assert}  \sigma = \exists n \in \mathbb{Z}. [\![p]\!]_{\rm assert} [\sigma|v:n]
> $$

> 注：$[\sigma|v:n]$记号用于修改函数$\sigma$在某个点处的值，
> $$
> [\sigma|v:n]x=\begin{cases}
> n, & x = v \\
> \sigma x, & x \neq v
> \end{cases} .
> $$

我们要求指称语义定义满足以下条件：

1. 抽象语法中的每个产生式都要有一个对应的语义等式；
2. 语义等式只能是直接子表达式语义的函数。

满足以上定义的等式集称为**语法制导的**或者**同态的**。

当每个表达式的语义只取决于子表达式的语义称为**复合语义**。复合语义具有以下性质：将一个表达式中的某个子表达式替换成语义等价的其他子表达式，得到的表达式语义与原表达式的语义等价。

## 永真性与推理

- 当$\forall \sigma \in \Sigma, [\![p]\!]_{\text{assert}} \sigma = \textbf{true}$时，我们称$p$永真（或成立）；
- 当$\forall \sigma \in \Sigma, [\![p]\!]_{\text{assert}} \sigma = \textbf{false}$时，我们称$p$不可满足。

一个**推理规则**由零或多个**前件**和一个**结论**构成；通常，前件会写在一条水平线上方，结论写在下方。前件和结论是断言的模式，即含有元变量的断言表达式，其中的元变量代表一个表达式集合（称为该元变量的值域）中的某个表达式。

不含前件的推理规则称为**公理模式**；不含元变量的公理模式称为**公理**。对于公理，我们通常省略水平线。

推理规则的一个**实例**是通过将推理规则中的元变量替换为相应值域内的表达式得到。

> 例：下图分别表示一个公理、公理模式、含有2个前件的推理规则和含有1个前件的推理规则
>
> ![image-20200714020514111](1-Predicate%20Logic.assets/image-20200714020514111.png)
>
> 以及它们的一个实例
>
> ![image-20200714020532681](1-Predicate%20Logic.assets/image-20200714020532681.png)

一个**证明**是指断言的序列，其中每个断言是某个推理规则实例的结论，并且该推理规则的所有前件均在证明中的结论断言前出现。我们称这个证明是其断言序列中最后一个断言的证明。

> 例：利用上面的推理规则，我们可以得到以下证明：
>
> ![image-20200714020637854](1-Predicate%20Logic.assets/image-20200714020637854.png)
>
> 有时，证明也用证明树表示：
>
> ![image-20200714020655000](1-Predicate%20Logic.assets/image-20200714020655000.png)

## 绑定和替换

对于量词$\forall v. p, \exists v.p$，称$p$中的$v$被该量词**绑定**。若一个变量出现在多个量词的辖域内，则该变量被最内侧的量词绑定。未被绑定的变量称为**自由变量**；不含自由变量的表达式称为**闭式**。

$\mathrm{FV}_{\text{intexp}}$和$\mathrm{FV}_{\text{assert}}$是将表达式映射到其含有的自由变量集合的函数。

一致性定理：若$p$是$\theta$类型的表达式，$\sigma$和$\sigma'$是满足$\forall w \in \mathrm{FV}_{\theta}(p). \sigma w = \sigma'w$的两个状态，则$ [\![p]\!]_{\theta} \sigma = [\![p]\!]_{\theta} \sigma '$。

替换：令$\Delta = \text{<var>} \rightarrow \text{<intexp>}$为所有替换映射的集合。令$p$为整数表达式，$\delta \in \Delta$为替换映射，则$p/\delta$为将$p$中的每个变量$v$替换为$\delta v$的结果。

1. 若$p$为常量，则$p/\delta=p$；
2. 若$p$为变量，则$p/\delta = \delta p$；
3. 若$p$为运算符构造的表达式（以二元运算符为例，设$p=e_0+e_1$），则$(e_0+e_1)/\delta = (e_0 / \delta) + (e_1/\delta)$；
4. 若$p$为量词（例如$p = \forall v. p_0$），则$\forall v. p_0 /\delta = \forall v_{\text{new}} .(p_0 / [\delta | v : v_{\text{new}}])$，其中，当$v \notin \bigcup_{w \in \text{FV}_{\text{assert}}(p) - \{v\}} \text{FV}_{\text{intexp}}(\delta w)$时，$v_{\text{new}}=v$，否则$v_{\text{new}}$为一新变量。

替换定理：若$p$是$\theta$类型的表达式，且$\forall w \in \text{FV}_{\theta}(p).\sigma w = [\![\delta w]\!]_{\text{intexp}}\sigma'$，则$[\![p/\delta]\!]\delta'=[\![p]\!]_{\theta}\delta$。

有限替换定理：若$p$是$\theta$类型的表达式，则
$$
[\![p/v_0 \rightarrow e_0, \cdots, v_{n-1} \rightarrow e_{n-1}]\!]_{\theta} \sigma' 
= [\![p]\!]_{\theta} [\sigma'|v_0:[\![e_0]\!]_{\text{intexp}} \sigma' | \cdots | v_{n-1} : [\![e_{n-1}]\!]_{\text{intexp}} \sigma']
$$
其中$p/v\rightarrow e$是指将$p$中的元变量$v$换成表达式$e$的结果。

换名定理：若$v_{\text{new}} \notin \text{FV}_{\text{assert}}(q) - \{v\}$，则
$$
[\![\forall v_{\text{new}}. (q / v \rightarrow v_{\text{new}})]\!]_{\text{assert}} = [\![\forall v. q]\!]_{\text{assert}} .
$$
