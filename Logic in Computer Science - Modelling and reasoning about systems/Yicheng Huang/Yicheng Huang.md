## Chapter 3: Verification by model checking

### 3.1 Motivation for verification

程序验证的几个维度选择：

- Proof-based vs. model-based：前者是证明$\Gamma\vdash \phi$，一般需要用户指导和其他知识；后者验证模型$\mathcal{M}\models\phi$，对于有限模型通常可自动化.
- Degree of automation：完全自动化；完全人工；半自动化.
- Full- vs. property-verification：前者描述系统的所有行为（开销巨大）；后者描述系统的单个属性.
- Intended domain of application：硬件/软件；串行/并发；reactive系统（如OS或嵌入式系统）/terminating系统（如普通C程序）.
- Pre- vs. post-development：在系统开发早期/晚期.

Model checking：automatic、model-based、property-verification

### 3.2 Linear-time temporal logic

#### LTL的语法

$$\phi ::= \top\mid \bot\mid p\mid (\neg\phi)\mid(\phi\wedge\phi)\mid(\phi\vee\phi)\mid(\phi\to\phi)\\\mid (\mathrm{X}\phi)\mid(\mathrm{F}\phi)\mid(\mathrm{G}\phi)\mid(\phi\mathrm{U}\phi)\mid(\phi\mathrm{W}\phi)\mid(\phi\mathrm{R}\phi)$$

#### LTL的语义

$\mathrm{X}$: 下一状态开始路径；$\mathrm{F}$: 未来某状态开始路径；$\mathrm{G}$: 所有未来状态开始路径；$\mathrm{U}$: until；$\mathrm{W}$: weak-until（可以不到达满足后者参数的状态）；$\mathrm{R}$: Release（将$\mathrm{W}$的两个参数颠倒一下，也是$\mathrm{U}$的对偶）.

#### LTL公式等价性

$$\neg\mathrm{G}\phi\equiv\mathrm{F}\neg\phi\qquad \neg\mathrm{F}\phi\equiv\mathrm{G}\neg\phi\qquad \neg\mathrm{X}\phi\equiv \mathrm{X}\neg\phi$$

$$\neg(\phi\mathrm{U}\psi)\equiv\neg\phi\mathrm{R}\neg\psi\qquad \neg(\phi\mathrm{R}\psi)\equiv\neg\phi\mathrm{U}\neg\psi$$

分配律：$\mathrm{F}(\phi\vee\psi)\equiv \mathrm{F}\phi\vee \mathrm{F}\psi$, $\mathrm{G}(\phi\vee\psi)\equiv\mathrm{G}\phi\wedge\mathrm{G}\psi$

$$\mathrm{F}\phi\equiv\top\mathrm{U}\phi\qquad \mathrm{G}\phi\equiv\bot\mathrm{R}\phi$$

强弱until的关系：$\phi\mathrm{U}\psi\equiv\phi\mathrm{W}\psi\wedge \mathrm{F}\psi$, $\phi\mathrm{W}\psi\equiv\phi\mathrm{U}\psi\vee G\psi$

#### LTL的全功能连接词集合（Adequate sets of connectives）

$\{\mathrm{U},\mathrm{X}\}, \{\mathrm{R},\mathrm{X}\}, \{\mathrm{W},\mathrm{X}\}$

**Theorem 3.10**：对任意LTL公式$\phi$和$\psi$，都有等价性$\phi\mathrm{U}\psi\equiv\neg(\neg\psi\mathrm{U}(\neg\phi\wedge\neg\psi))\wedge\mathrm{F}\psi$

### 3.3 Model checking

#### 互斥

- Safety：任意时间只能有一个进程在CS（$\mathrm{G}\neg(c_1\wedge c_2)$）
- Liveness：无论何时一个进程请求进入CS，它最终都会进入CS（$\mathrm{G}(t_1\to\mathrm{F}c_1)$）
- Non-blocking：一个进程总是能够请求进入CS（用LTL无法表达“对任意满足$n_1$的状态，它都有一个满足$t_1$的后继”）
- No strict sequencing：进程不需要按严格顺序进入CS（用LTL无法直接表达“存在一条路径，其中两个满足$c_1$不同状态的中间没有状态满足$c_1$”，可以用complement来表述：$G(c_1\to c_1\mathrm{W}(\neg c_1\wedge\neg c_1\mathrm{W}c_2))$）

#### NuSMV

- 接受输入：描述一个模型的程序、一些spec（时序逻辑公式）；输出：若这些spec成立，则输出`'true'`，否则输出一条导致spec为`false`的trace.
- 用关键字`LTLSPC`表示spec
- 默认情况下，各个模块同步执行；使用`process`关键字，可以异步执行.
- 关键字`FARENESS`：FARENESS $\phi$表示SMV在检查spec $\phi$时，会忽略所有$\phi$没有被无限次满足的路径.

### 3.4 Branching-time logic

- 一个状态满足一个LTL公式，若从该状态出发的**所有**路径都满足这个公式.
- 混合关于路径的全称与存在量词的属性不能用取补来检查，只能借助CTL.

#### CTL的语法

$$\phi ::= \top\mid \bot\mid p\mid (\neg\phi)\mid(\phi\wedge\phi)\mid(\phi\vee\phi)\mid(\phi\to\phi)\\\mid (\mathrm{AX}\phi)\mid(\mathrm{EX}\phi)\mid(\mathrm{AF}\phi)\mid(\mathrm{EF}\phi)\mid(\mathrm{AG}\phi)\mid(\mathrm{EG}\phi)\\\mid\mathrm{A}(\phi\mathrm{U}\phi)\mid\mathrm{E}(\phi\mathrm{U}\phi)$$

- 规定：`X, F, G, U`之前必须有`A`或`E`，`A`或`E`之后必须有`X, F, G, U`

#### CTL的语义

只需知道$\mathrm{A}\phi$表示从当前状态开始的所有路径都满足$\phi$；$\mathrm{E}\phi$表示存在某条从当前状态开始的路径满足$\phi$.

#### CTL公式等价性

$\neg\mathrm{AF}\phi\equiv\mathrm{EG}\neg\phi\qquad \neg\mathrm{EF}\phi\equiv\mathrm{AG}\neg\phi\qquad \neg\mathrm{AX}\phi\equiv\mathrm{EX}\neg\phi$

$\mathrm{AF}\phi\equiv\mathrm{A}[\top\mathrm{U}\phi]\qquad\mathrm{EF}\phi\equiv\mathrm{E}[\top\mathrm{U}\phi]$

#### CTL的全功能连接词集合（Adequate sets of connectives）

$\{\mathrm{AX},\mathrm{EX}\}$中的至少一个，以及$\{\mathrm{EG},\mathrm{AF},\mathrm{AU},\mathrm{EU}\}$中的至少一个

### 3.5 CTL* and the expressive powers of LTL and CTL

Insight: 存在LTL能表达而CTL无法表达的公式，如LTL中的$\mathrm{F} p\to \mathrm{F}q$

- CTL*：去掉了每个`X, U, F, G`前必须有`A, E`的约束，语法包含两类公式：
  - 状态公式（state formulas）：$\phi::=\top\mid p\mid (\neg\phi)\mid(\phi\wedge\phi)\mid\mathrm{A}[\alpha]\mid\mathrm{E}[\alpha]$
  - 路径公式（path formulas）：$\alpha::=\phi\mid(\neg\alpha)\mid(\alpha\wedge\alpha)\mid(\alpha\mathrm{U}\alpha)\mid(\mathrm{G}\alpha)\mid(\mathrm{F}\alpha)\mid(\mathrm{X}\alpha)$

- LTL公式$\alpha$等价于CTL\*公式$\mathrm{A}[\alpha]$；CTL也是CTL\*的子集，将$\alpha$限制为$\alpha::=(\phi\mathrm{U}\phi)\mid(\mathrm{G}\phi)\mid(\mathrm{F}\phi)\mid(\mathrm{X}\phi)$
- 尽管CTL不支持路径公式之间的布尔组合，但可以将其等价转换为CTL能表达的公式，如$\mathrm{E}[\mathrm{F}p\wedge\mathrm{F}q]\equiv \mathrm{EF}[p\wedge\mathrm{EF}q]\vee\mathrm{EF}[q\wedge\mathrm{EF}p]$
- 尽管LTL不支持“过去操作符“（如since, once等），但可以将过去操作符等价转换为LTL能表达的公式；但是，“过去操作符”可以增加CTL的表达能力，因为它们可以用来检查那种forward-unreachable的状态.

### 3.6 Model-checking algorithms

- 问题定义
  - Option1: 输入模型$\mathcal{M}$、公式$\phi$和状态$s_0$，验证是否$\mathcal{M},s_0\models \phi$，输出`'yes'`或`'no'`.
  - Option2: 输入模型$\mathcal{M}$和公式$\phi$，输出使得模型$\mathcal{M}$满足$\phi$的所有状态$s$.

#### CTL Model-checking标记算法

1. 将$\phi$转化为Adequate set里面的连接符形式
2. 用$\phi$的各个子公式标记$\mathcal{M}$的状态，从最小的子公式开始，逐步逼近$\phi$

#### 更高效的算法变体

用`EX, EU, EG`作为Adequate set，对于`EX, EU`，用前面的算法；对于$\mathrm{EG}\phi$，仅保留满足$\phi$的状态，找到这些状态的强连通分量，再使用反向BFS找到所有可以到达强连通分量的状态.

#### 公平性

- 用`!st=c`这个FARENESS约束来保证：无论进程在什么状态，未来总有一个不在CS里面的状态.
- 一条计算路径是公平的，当且仅当它所有的后缀也是公平的.

#### LTL Model-checking算法

- 比CTL复杂的地方在于：公式的子公式需要在路径上进行检验，而不是在状态上.
- 基本策略
  1. 为公式$\neg\phi$构造自动机$A_{\neg\phi}$，它编码了所有满足$\neg\phi$的trace（即不满足$\phi$的trace），其中一个trace是一个包含谓词原子值的串.
  2. 将自动机$A_{\neg\phi}$与模型$\mathcal{M}$结合起来，得到一个传递系统，所含路径是自动机和模型系统的路径的交集.
  3. 在传递系统中寻找是否存在由$s$生成的某个状态开始的路径，若存在，则可以解释为一条从$\mathcal{M}$中的$s$开始的不满足$\phi$的路径.
- $$\mathrm{pre}_{\exists}(Y)=\{s\in S\mid \mathrm{exists}\ s',(s\to s'\ \mathrm{and}\ s'\in Y)\}$$
- $\mathrm{pre}_{\forall}(Y)=\{s\in S\mid\mathrm{for}\ \mathrm{all}\ s',(s\to s'\ \mathrm{implies}\ s'\in Y)\}$

### 3.7 The fixed-point characterisation of CTL

本节目的：证明$SAT_{AF}$和$SAT_{EU}$的termination和correctness.

#### 单调函数（Monotone functions）

- 定义：设$S$是一个状态集合，$F:\mathcal{P}(S)\to\mathcal{P}(S)$是作用在$S$的幂集上的一个函数，则$F$是单调的当且仅当对任意的$X,Y\subseteq S$，都有$X\subseteq Y$可推导出$F(X)\subseteq F(Y)$. $S$的一个子集$X$被称为$F$的不动点当且仅当$F(X)=X$.

- **Theorem 3.24**：设$S$是集合$\{s_0,s_1,\dots,s_n\}$，若$F:\mathcal{P}(S)\to\mathcal{P}(S)$是一个单调函数，那么$F^{n+1}(\emptyset)$是$F$的最小不动点，且$F^{n+1}(S)$是$F$的最大不动点.

#### $SAT_{EG}$的正确性

- $[[\mathrm{EG}\phi]]=[[\phi]]\cap\mathrm{pre}_{\exists}([[\mathrm{EG}\phi]])$
- 设$S$有$n+1$个元素，函数$F(X)=[[\phi]]\cap\mathrm{pre}_{\exists}(X)$是单调函数，$[[\mathrm{EG}\phi]]$是$F$的最大不动点，且$[[\mathrm{EG}\phi]]=F^{n+1}(S)$.

#### $SAT_{EU}$的正确性

- $[[E[\phi\mathrm{U}\psi]]]=[[\psi]]\cup([[\phi]]\cap\mathrm{pre}_{\exists}[[\mathrm{E}[\phi\mathrm{U}\psi]]])$
- 设$S$有$n+1$个元素，函数$G(X)=[[\psi]]\cup([[\psi]]\cap\mathrm{pre}_{\exists}(X))$是单调函数，$[[\mathrm{E}(\phi\mathrm{U}\psi)]]$是$G$的最小不动点，且$[[\mathrm{E}(\phi\mathrm{U}\psi)]]=G^{n+1}(\empty)$

## Chapter 4: Program verification

- 前一章的model checking方法适合验证那种进程通讯的系统（control是main issue但没有复杂的data，有限状态），但对于单处理器的串行程序（non-trivial data，无限状态）就不适用.
- 本章的方法：proof-based、semi-automatic、property-oriented，domain是sequential transformational programs（预期会终止，不同于reactive system），被用于程序的片段.

### 4.1 Why should we specify and verify code?

- Documentation（文档）：描述程序的spec，可用合适的逻辑来形式化表述spec
- Time-to-market：debug大型系统费时费力而易错，通过形式化验证，可在规划阶段排除大多数错误
- Refactoring（重构）：属性特定的、已验证的软件更易用
- Certification audits：安全攸关系统

### 4.2 A framework for software verification

- 框架
  1. 将非形式化的需求描述$R$转化为用某种符号逻辑表达的“等价”公式$\phi_R$.
  2. 写一个程序$P$，它用来实现$\phi_R$.
  3. 证明程序$P$满足公式$\phi_R$.

- 兼顾非形式化规范和形式化规范的重要性：不可能保证$\phi_R$等价于$R$.

#### 我们关注的核心的编程语言

三部分：整数表达式、布尔表达式、命令.

- `E ::= n | x | (-E) | (E+E) | (E-E) | (E*E)`
- `B ::= true | false | (!B) | (B&B) | (B||B) | (E<E)`
- `C ::= x=E | C;C | if B {C} else {C} | while B {C}`

#### Hoare三元组

- 定义：形式$(\phi)P(\psi)$称为Hoare三元组，$\phi$是precondition，$\psi$是postcondition. 一个store或state是指每个变量$x$的赋值函数$l(x)$. 要求$\phi$和$\psi$中的量词仅仅约束不在$P$中的变量.

#### 部分正确性（Partial correctness）

- 定义：三元组$(\phi)P(\psi)$满足部分正确性，若对于任意的满足$\phi$的状态，在$P$能终止的前提下，都能在执行完$P$后满足$\psi$. 记为$\models_{\mathrm{par}}(\phi)P(\psi)$.

#### 完全正确性（Total correctness）

- 定义：三元组$(\phi)P(\psi)$满足完全正确性，若对于任意的满足$\phi$的状态，$P$都能终止并且最终状态满足$\psi$. 记为$\models_{\mathrm{tot}}(\phi)P(\psi)$.
- 证明完全正确性一般分为证明部分正确性和证明终止性.
- soundness: 若$\vdash_{\mathrm{par}}(\phi)P(\psi)$合法，则$\models_{\mathrm{par}}(\phi)P(\psi)$成立；completeness: 若$\models_{\mathrm{par}}(\phi)P(\psi)$成立，则$\vdash_{\mathrm{par}}(\phi)P(\psi)$合法. （$tot$同理）
- 用逻辑变量（logical variable）$x_0$等来表示程序变量（program variable）的固定值/初始值.

### 4.3 Proof calculus for partial correctness

#### 证明规则

Composition, Assignment, If-statement, Partial-while, Implied

- 赋值（Assignment）：无前提，要求$(\psi[E/x]x=E(\psi))$. 若要在`x=E`后满足$\psi$，则要在将$x$替换为$E$后满足$\psi[E/x]$. 这个rule从后往前证明要比从前往后证明更容易.

- 循环（Partial-while）：前提为$(\psi\wedge B)C(\psi)$，结论为$(\psi)\mathrm{while}B\{C\}(\psi\wedge\neg B)$. 不变量$\psi$至关重要.
- 蕴含（Implied）：增强前置条件/减弱后置条件.

### 4.4 Proof calculus for total correctness

- Total-while在Partial-while的基础上，多了一个严格decrease的变量，前提为$(\eta\wedge B\wedge 0\le E=E_0)C(\eta\wedge 0\le E<E_0)$，结论为$(\eta\wedge 0\le E)\mathrm{while}B\{C\}(\eta\wedge\neg B)$.

### 4.5 Programming by contract

为一段程序写contract（合同），`assumes`规定了前置条件，`guarantees`规定了后置条件，`modified only`规定了程序执行过程中哪个程序变量的值可能发生变化. 注意要避免循环论证，可以通过判断调用图有无环来判断.

## Chapter 5: Modal logics and agents

### 5.1 Modes of truth

模态逻辑添加了表示不同truth模式的连接词，描述与知识、必要性或时间有关的truth.

### 5.2 Basic modal logic

#### 语法

$\phi::=\bot\mid\top\mid p\mid(\neg\phi)\mid(\phi\wedge\phi)\mid(\phi\vee\phi)\mid(\phi\to\phi)\mid(\phi\leftrightarrow\phi)\mid(\Box\phi)\mid(\Diamond\phi)$

#### 语义

- 基本模态逻辑的一个模型$\mathcal{M}$（Kripke model）由三部分组成：
  - 一个集合$W$，其中的元素被称为世界（world）；
  - $W$上的一个关系$R$（$R\subseteq W\times W$），称为可达关系（accessibility relation），用$R(x,y)$来表示$(x,y)\in R$；
  - 一个函数$L:W\to\mathcal{P}(\mathrm{Atoms})$，称为标记函数（labelling function）.

- 需要注意的是：(1) $x\Vdash\Box\psi$当且仅当对于任意$R(x,y)$中的$y\in W$，有$y\Vdash\psi$. (2) $x\Vdash\Diamond\psi$当且仅当存在$y\in W$使得$R(x,y)$且$y\Vdash\psi$. （相当于CTL里面的AX和EX）其余的规则都很符合直觉.
- 反直觉的一个case：$x\Vdash\Box\bot$成立当且仅当$x$没有可达世界.

#### Formula和formula schemes

- 有相同“形状”的一簇公式，称为formula schemes，比如$\phi\to\Box\Diamond\phi$是一个formula scheme. 有该formula scheme的形状的公式称为scheme的实例（instance），如$p\to\Box\Diamond p$.

#### 模态公式之间的等价性

- 我们称模态逻辑公式的集合$\Gamma$语义推导出公式$\psi$，若模型$\mathcal{M}=(W,R,L)$中的任意世界$x$，若对任意$\phi\in\Gamma$且$x\Vdash\phi$都有$x\Vdash\psi$. 此时，我们称$\Gamma\models\psi$成立. 若$\phi\models\psi$且$\psi\models\phi$，则$\phi$和$\psi$语义等价，记为$\phi\equiv\psi$.

- $\neg\Box\phi\equiv \Diamond\neg\phi\qquad \neg\Diamond\phi\equiv\Box\neg\phi$
- $\Box(\phi\wedge\psi)\equiv\Box\phi\wedge\Box\psi\qquad \Diamond(\phi\vee\psi)\equiv\Diamond\phi\vee\Diamond\psi$

- $\Box\top\equiv\top$但不等价于$\Diamond\top$；$\Diamond\bot\equiv\bot$但不等价于$\Box\bot$.（存在性）

#### 合法公式（Valid formulas）

- 定义：基本模态逻辑中的一个公式$\phi$是合法（valid）的，若在所有模型中的所有世界都为真，也即$\models\phi$成立.

### 5.3 逻辑工程（Logic engineering）

![image-20200712111118231](5.3-0.png)

![image-20200712110735648](5.3-1.png)

- 必要性（Necessity）：物理必要性（宇宙的规律自身必要性）；逻辑必要性（无法不给这些论断yes的回答）

#### 可达性关系的重要性质

- $R(x,y)$可以解释为：根据$Q$对$x$的认知，$y$可能是真实世界，也即如果真实世界是$x$，那么$Q$不能排除真实世界是$y$的可能性.
- ![image-20200712111828976](5.3-2.png)
- 可以考察$R$是否具有自反、对称、传递等性质

#### 对应理论（Correspondence theory）

- 定义
  - 一个框架（frame）$\mathcal{F}=(W,R)$是一个世界集合$W$和一个$W$上的二元关系$R$.（相当于没有标记函数的Kripke模型）
  - 一个框架$\mathcal{F}=(W,R)$满足一个基本模态逻辑公式$\phi$，若对于每个标记函数$L:W\to\mathcal{P}(\mathrm{Atoms})$和每个$w\in W$，都有$\mathcal{M},w\Vdash\phi$成立，其中$\mathcal{M}=(W,R,L)$. 我们记为$\mathcal{F}\models\phi$.
- 定理
  - 以下语句是等价的：(1) $R$具有自反性；(2) $\mathcal{F}$满足$\Box\phi\to\phi$；(3) $\mathcal{F}$满足$\Box p\to p$.
  - 以下语句是等价的：(1) $R$具有传递性；(2) $\mathcal{F}$满足$\Box\phi\to\Box\Box\phi$；(3) $\mathcal{F}$满足$\Box p\to\Box\Box p$.
- serial: $\forall x\exists y, R(x,y)$; Euclidean: $\forall x,y,z,R(x,y)\wedge R(x,z)\to R(y,z)$; functional: 对每个$x$，有唯一的$y$使得$R(x,y)$; linear: $\forall x,y,z\in W, R(x,y)\wedge R(x,z)\to R(y,z)\vee y=z\vee R(z,y)$.![image-20200712121600202](5.3-3.png)

#### 一些模态逻辑

- 定义：设$\mathbb{L}$是模态逻辑formula schemes的集合，$\Gamma\cup\{\psi\}$是基本模态逻辑公式的集合.

  - 集合$\Gamma$在实例替换下闭合，当且仅当若$\phi\in\Gamma$，则$\phi$的任意实例替换仍然在$\Gamma$中.
  - 设$\mathbb{L}_c$是包含$\mathbb{L}$中的所有实例的最小集合.
  - $\Gamma$语义推导出$\mathbb{L}$中的$\psi$，当且仅当$\Gamma\cup\mathbb{L}_c$语义推导出基本模态逻辑中的$\psi$. 此时$\Gamma\models_{\mathbb{L}}\psi$成立.

- 模态逻辑：K

  - 最弱的模态逻辑，无formula schemes，$\mathbb{L}=\emptyset$. 

- 模态逻辑：KT45

  - 也称为S5. $\mathbb{L}=\{T,4,5\}$. 用来描述knowledge：

    - T: agent $Q$只知道真的东西；
    - 4: 若agent $Q$知道某个东西，那么它知道它知道这个东西；
    - 5: 若agent $Q$不知道某个东西，那么它知道它不知道这个东西；

    - K: logical omniscience（逻辑全知），agent的知识在逻辑结论下闭合.

  - KT45中的任意模态操作符和否定符所组成的串等价于下面之一：$-$, $\Box$, $\Diamond$, $\neg$, $\neg\Box$, $\neg\Diamond$，其中$-$是指没有任何否定或模态操作符.

- 模态逻辑：KT4

  - 也称为S4.
  - KT4中的任意模态操作符和否定符所组成的串等价于下面之一：$-$, $\Box$, $\Diamond$, $\Box\Diamond$, $\Diamond\Box$, $\Box\Diamond\Box$, $\Diamond\Box\Diamond$, $\neg$, $\neg\Box$, $\neg\Diamond$, $\neg\Box\Diamond$, $\neg\Diamond\Box$, $\neg\Box\Diamond\Box$, $\neg\Diamond\Box\Diamond$.

- **Intuitionistic propositional logic**

  - 一个Intuitionistic propositional logic模型是一个KT4模型$\mathcal{M}=(W,R,L)$，其中$R(x,y)$总是蕴含着$L(x)\subseteq L(y)$. 给定一个命题逻辑公式，除了$\to$和$\neg$之外都直接用来定义$x\Vdash\phi$. 对于$\phi_1\to\phi_2$，我们定义$x\Vdash\phi_1\to\phi_2$当且仅当对任意$y$且$R(x,y)$，若$y\Vdash\phi_1$则有$y\Vdash\phi_2$. 对于$\neg\phi$，我们定义$x\Vdash\neg\phi$当且仅当对任意$y$且$R(x,y)$，我们有$y\not\Vdash\phi$.
  - 排中律不成立.

### 5.4 Natual deduction

模态逻辑的额外规则：$\Box$ introduction和$\Box$ elimination，即(1) 若$\phi$出现在虚线框的末尾，那么$\Box\phi$可能会放入虚线框之后；(2) 若$\Box$出现在一个证明中，那么$\phi$可能会放入后续的虚线框中.

#### KT45的额外规则

- $\frac{\Box\phi}{\phi}T\qquad \frac{\Box]\phi}{\Box\Box\phi}4\qquad \frac{\neg\Box\phi}{\Box\neg\Box\phi}5$

### 5.5 Reasoning about knowledge in a multi-agent system

- 多Agent系统：不同的agent对世界有不同的认知.
- Reasoning about knowledge是指一个团体中的agents不仅考虑世界的事实，还考虑团体中其他agents的知识. 例子：博弈论、经济学、密码学、协议等.

#### 有趣的例子

1. The wise-men puzzle：三个人被戴帽子，一共有3顶红帽子和2顶白帽子，三个人轮流说自己是否知道自己头上是什么颜色的帽子. 若前两个人都说不知道，那么第三个人就能确定自己头上是红帽子.
2. The muddy-children puzzle：前者的并行版. 有很多孩子在花园里玩耍，有$k$（$k\ge1$）个孩子前额沾了泥土，每个孩子可以看见其他孩子前额的泥土，但看不到自己的. 
   - 场景一：父亲反复询问是否有人知道自己前额有泥土. 第一次所有人都异口同声地回答了no，因为无法从别人的no中学到什么东西，所以一直回答no.
   - 场景二：父亲首先宣布至少有一个人前额有泥土，然后他反复询问是否有人知道自己前额有泥土. 第一次所有人都回答了no. 在前$k-1$次所有人都回答no，直到第$k$次前额有泥土的人会回答yes.
   - 两个场景的重要区别：尽管每个人都知道父亲宣布的内容，但父亲的宣布使得这句话成为了他们之中的共识，他们才知道所有其他人都知道这件事. 例如$k=2$，Ramon和Candy前额有泥土，他们两个都知道除他自己之外有人前额有泥土，但是如果父亲不宣布，Ramon就不知道Candy知道有人前额有泥土，对他来说，Candy可能是唯一一个前额有泥土的人.

#### 模态逻辑KT45$^n$

- 公式$K_ip$表示“agent $i$知道$p$”. 公式$E_Gp$表示“每个group $G$中的人都知道$p$”. 公式$C_G\phi$表示$G$的共识，即$E_G\phi\wedge E_GE_G\phi\wedge E_GE_GE_G\phi\wedge\dots$ $D_G\phi$表示$\phi$的知识分布在$G$中：尽管$G$中可能没有人知道它，但它们可以把各自的知识聚集在一起推出它.
- 语法：$\phi::=\bot\mid\top\mid p\mid(\neg\phi)\mid(\phi\wedge\phi)\mid(\phi\vee\phi)\mid(\phi\to\phi)\mid(\phi\leftrightarrow\phi)\\\mid(K_i\phi)\mid(E_G\phi)\mid(C_G\phi)\mid(D_G\phi)$

- 模型：$\mathcal{M}=(W,(R_i)_{i\in\mathcal{A}}, L)$，其中$\mathcal{A}$是$n$个agents组成的集合. $W$是可能世界的集合. 对任意$i\in\mathcal{A}$，$W$上的等价关系$R_i$别称为可达性关系（accessibility relation）. 标记函数$L:W\to\mathcal{P}(\mathrm{Atoms})$.
- 语义：除去trivial的，(1) $x\Vdash K_i\psi$当且仅当对任意$y\in W$，$R_i(x,y)$蕴含$y\Vdash\psi$. (2) $x\Vdash E_G\psi$当且仅当对任意$i\in G$都有$x\Vdash K_i\psi$. (3) $x\Vdash C_G\psi$当且仅当对任意$k\ge1$都有$x\Vdash E_G^k\psi$，其中$E_G^k$指$E_GE_G\dots E_G$k次. (4) $x\Vdash D_G\psi$当且仅当对任意$y\in W$，若对任意$i\in G$有$R_i(x,y)$，则有$y\Vdash\psi$.
- 可达性：定义G-reachable——$y$从$x$开始在$k$步G-reachable，若存在$w_1,w_2,\dots,w_{k-1}\in W$和$i_1,i_2,\dots,i_k\in G$使得$xR_{i_1}w_1R_{i_2}w_2\dots R_{i_{k-1}}w_{k-1}R_{i_k}y$，也即$R_{i_1}(x, w_1),R_{i_2}(w_1,w_2),\dots,R_{i_k}(w_k,y)$.
  - $x\Vdash E_G^k\phi$当且仅当对任意从$x$开始在$k$步G-reachable的$y$，有$y\Vdash\phi$.
  - $x\Vdash C_G\phi$当且仅当对任意从$x$开始G-reachable的$y$，有$y\Vdash\phi$.

- 一些合法公式（valid formulas）

  - $[]\phi\wedge [](\phi\to\psi)\to []\psi$，其中$[]$可为$K_i,E_G,C_G,D_G$.
  - $[]\phi\to[][]\phi\quad\neg K_i\phi\to K_i\neg K_i\phi\quad K_i\phi\to\phi$，其中$[]$可为$K_i,D_G$.

- 自然推理规则

  ![image-20200712152740078](5.5.png)

## Chapter 6: Binary decision diagrams

### 6.1 Respresenting boolean functions

- 布尔函数$f:\{0,1\}^n\to\{0,1\}$

- 命题公式（Propositional formula）：用$\wedge$表示$\cdot$，用$\vee$表示$+$，用$\neg$表示$\overline{sth}$，用$\top$和$\bot$分别表示1和0.
- 真值表：用表格方式列举$f(x,y)$里面$x,y,f(x,y)$的1/0情况.（浪费空间，但直观）
- ![6.1](6.1.png)

#### 二叉决策树（Binary decision tree）

- 定义：非终结结点标记为布尔变量$x,y,z,\dots$，终结结点标记为0或1，每个非终结结点有两条边，一条是实线，一条是虚线. 设$T$是一棵有限二叉决策树，那么$T$决定了一个特殊的非终结结点变量的布尔函数：给定一个对各个布尔变量的0/1赋值，从$T$的根结点开始，若当前结点的赋值为0，则走虚线，否则走实线. 函数的值就是到达的终结结点的值.

#### 二叉决策图（Binary decision diagram）

- 比二叉决策树更加general
- subBDD：BDD在某给定结点以下的部分.
- 将一个BDD归约成更精简的形式的方法：（这些方法维护了DAG的属性）
  - C1. Removal of duplicate terminals.
  - C2. Removal of redundant tests.
  - C3. Removal of duplicate non-terminals.
- BDD的定义：一个BDD是一个有限的DAG，它拥有一个唯一的初始结点，所有的终结结点都标记为0或1，所有的非终结结点都标记为布尔变量，每个非终结结点都有两条指向其他结点的边，一条标记为0，一条标记为1. 若没有任意C1-C3的优化可以再应用，那么我们称BDD是reduced（已归约的）.
- 一个BDD表示一个**可满足**函数，若一个1-终结结点从根结点沿着一条一致路径（consistent path）可到达，其中一致路径是指路径上每个变量只有虚线或只有实线离开该变量所在的结点. **合法**函数：没有0-终结结点可到达.
- 对于$f\cdot g$，将$B_f$中所有的1-终结结点替换为$B_g$；对于$f+g$，将$B_f$中所有的0-终结结点替换为$B_g$；对于$\overline{f}$，将$B_f$中的0和1-终结结点互换.

#### 有序二叉决策图（Ordered BDDs）

- 定义：设$[x_1,\dots,x_n]$是一个无重复的有序变量列表，$B$是所有变量都在该列表中的BDD. 我们称BDD有顺序$[x_1,\dots,x_n]$，若$B$的所有变量标记都出现在该列表中，并且对于$B$中任意路径的所有出现在$x_i$后面的$x_j$都有$i<j$. 一个Ordered BDD（OBDD）是一个对某个变量列表有顺序的BDD.
- Reduced OBDD和布尔函数一一对应.
- 一般来说，选择的变量顺序对OBDD的size影响很大.
- Canonical representation的重要性：去除冗余变量；测试语义等价性；测试合法性；测试蕴含性（$f\cdot\overline{g}$）；测试可满足性.

### 6.2 Algorithms for reduced OBDDs

#### reduce算法

- 若$B$的顺序为$[x_1,x_2,\dots,x_l]$，那么$B$至多有$l+1$层. reduce算法自底向上一层层遍历$B$，同时将整数$\mathrm{id}(n)$标记到$B$的每个结点$n$，如此，有根结点分别为$n$和$m$的两个subOBDDs表示同一布尔函数当且仅当$\mathrm{id}(n)=\mathrm{id}(m)$.
- 用$\mathrm{lo}(n)$表示从$n$通过虚线指向的结点，$\mathrm{hi}(n)$表示从$n$通过实现指向的结点.
  - 若$\mathrm{id}(\mathrm{lo}(n))=\mathrm{id}(\mathrm{hi}(n))$，则将$\mathrm{id}(n)$设为这个值.（根据C2）
  - 若存在另一个结点$m$使得$m$和$n$具有相同的变量$x_i$，并且$\mathrm{id}(\mathrm{lo}(n))=\mathrm{id}(\mathrm{lo}(m)),\mathrm{id}(\mathrm{hi}(n))=\mathrm{id}(\mathrm{hi}(m))$，将$\mathrm{id}(n)$设为$\mathrm{id}(m)$.（根据C3）
  - 否则，将$\mathrm{id}(n)$设为下一个未用的整数标记.

#### apply算法

- 基于香农展开（Shannon expansion），apply函数：$f\ \mathrm{op}\ g=\overline{x_i}\cdot(f[0/x_i]\mathrm{op}\ g[0/x_i])+x_i\cdot(f[1/x_i]\mathrm{op}\ g[1/x_i])$. 从$B_f$和$B_g$的根结点开始，往下构建OBDD的结点$B_{f\ \mathrm{op}\ g}$，设$r_f$是$B_f$的根结点、$r_g$是$B_g$的根结点.
  - 若$r_f$和$r_g$分别是终结结点$l_f$和$l_g$，则计算$l_f\mathrm{op}l_g$的值，若为0则结果OBDD为$B_0$，否则为$B_1$.
  - 否则，若两者的根结点都是$x_i$-结点，则创建一个$x_i$-结点$n$，虚线指向$\texttt{apply}(\mathrm{op},\mathrm{lo}(r_f),\mathrm{lo}(r_g))$，实线指向$\texttt{apply}(\mathrm{op},\mathrm{hi}(r_f),\mathrm{hi}(r_g))$.
  - 否则，若$r_f$是$x_i$-结点，但$r_g$是一个终结结点或$x_j$-结点（$j>i$），那么$B_g$中没有$x_i$-结点，因为两个OBDDs有兼容的变量顺序，所以$g$独立于$x_i$. 因此创建一个$x_i$结点，虚线指向$\texttt{apply}(\mathrm{op},\mathrm{lo}(r_f),r_g)$，实线指向$\texttt{apply}(\mathrm{op},\mathrm{hi}(r_f),r_g)$.
  - 其他情况类似于case 3.
- 最后可以加一步reduce.

#### restrict算法

- $\texttt{restrict}(0,x,B_f)$使用和$B_f$一样的变量顺序来计算表示$f[0/x]$的reduced OBDD.
- 对任意标记$x$的结点$n$，入边重定向至$\mathrm{lo}(n)$，$n$被删去，然后做apply. $\texttt{restrict}(1,x,B_f)$类似.

#### exists算法

- $\exists x.f$定义为$f[0/x]+f[1/x]$，$\texttt{exists}$函数可以用$\texttt{apply}$和$\texttt{restrict}$算法实现：$\texttt{apply}(+,\texttt{restrict}(0,x,B_f),\texttt{restrict}(1,x,B_f))$.
- 一般地，用$\exists\hat{x}.f$表示$\exists x_1.\exists x_2\dots\exists x_n.f$，其中$\hat{x}$表示$(x_1,x_2,\dots,x_n)$. 这个布尔函数的OBDD通过将每个标记为$x_i$地结点换成$+$的两个分支.
- 全程量词$\forall$就是把$+$换成$\cdot$.

![image-20200712214149210](6.2-0.png)

![image-20200712214206479](6.2-1.png)

#### OBDDs的变体

- Parity OBDDs：一些非终结结点可能被标记为$\oplus$
- 多于两个分支；不标记非终结结点；概率分支（掷骰子）

### 6.3 Symbolic model checking

#### 表示状态集合的子集

- 设$S$是一个有限集合，我们的目标是将$S$的各个子集表示为OBDDs. 我们为每个元素$s\in S$赋予唯一的布尔向量$(v_1,v_2,\dots,v_n)$（$v_i\in\{0,1\}$），因此用布尔函数$f_T$来表示子集$T$，对于一个状态$s\in T$，$f_T$将$(v_1,v_2,\dots,v_n)$映射到1，否则映射到0. 若$x_i\in L(s)$，则$v_i=1$，否则$v_i=0$. 作为一个OBDD，这一状态可以表示为布尔函数$l_1\cdot l_2\cdot\cdots\cdot l_n$，其中若$x_i\in L(s)$则$l_i=x_i$否则$l_i=\overline{x_i}$. 于是状态集合$\{s_1,s_2,\dots,s_m\}$可以表示为布尔函数$(l_{11}\cdot l_{12}\cdot\cdots\cdot l_{1n})+(l_{21}\cdot l_{22}\cdot\cdots\cdot l_{2n})+\cdots+(l_{m1}\cdot l_{m2}\cdot\cdots\cdot l_{mn})$，其中$l_{i1}\cdot l_{i2}\cdot\cdots\cdot l_{in}$表示状态$s_i$.

#### 表示传递关系

- 模型$\mathcal{M}=(S,\to,L)$的传递关系$\to$是$S\times S$的子集，我们需要布尔向量的两份拷贝，可以用如下向量表示$s\to s'$：$((v_1,v_2,\dots,v_n),(v_1',v_2',\dots,v_n'))$，其中若$p_i\in L(s)$则$v_i$为1否则为0，若$p_i\in L(s')$则$v_i'$为1否则为0. 布尔函数即为$(l_1\cdot l_2\cdot\cdots\cdot l_n)\cdot(l_1'\cdot l_2'\cdot\cdots\cdot l_n')$.

#### 实现函数$\mathrm{pre}_{\exists}$和$\mathrm{pre}_{\forall}$

- $\mathrm{pre}_{\forall}(X)=S-\mathrm{pre}_{\exists}(S-X)$
- 利用$B_X$和$B_\to$计算$\mathrm{pre}_{\exists}(X)$的OBDD：先将$B_X$中的变量命名为prime版本，称为$B_{X'}$，然后计算$\texttt{exists}(\hat{x}',\texttt{apply}(\cdot,B_\to,B_{X'}))$的OBDD.

#### 合成OBDDs

- key idea：用SMV来描述，然后直接合成OBDD，避开二叉决策树或真值表等size爆炸的中间表示.
- SMV可以计算各变量下一状态的值，这个转换关系可以用布尔函数表达：$\prod\limits_{1\le i\le n}x_i'\leftrightarrow f_i$，其中$\prod$的范围是所有的非输入变量.
- 对串行同步电路建模（例子）
  - 图示：![image-20200713114453575](6.3.png)
  - 表示电路的下一可能状态的函数$f^\to$是：$(x_1'\leftrightarrow\overline{x_1})\cdot(x_2'\leftrightarrow x_1\oplus x_2)$
  - 然后转化为OBDD.

- 对串行异步电路建模
  - 在simultaneous模型中，一个全局转换中，任意数目的组件都可能有局部转换，于是$f^\to\stackrel{\mathrm{def}}{=}\sum\limits_{i=1}^n\bigg((x_i'\leftrightarrow f_i)\cdot\prod\limits_{j\neq i}(x_j'\leftrightarrow x_j)\bigg)$
  - 在interleaving模型中，一个全局转换严格对应一个局部转换，于是$f^\to\stackrel{\mathrm{def}}{=}\sum\limits_{i=1}^n\bigg((x_i'\leftrightarrow f_i)\cdot\prod\limits_{j\neq i}(x_j'\leftrightarrow x_j)\bigg)$

### 6.4 A relational mu-calculus

本节介绍了一种用于指代布尔表达式上下文的不动点的语法，这种语言也为描述不动点不变量的交互和依赖提供了形式化.

#### 语法

- $v::=x\mid Z$
- $f::=0\mid 1\mid v\mid\overline{f}\mid f_1+f_2\mid f_1\cdot f_2\mid f_1\oplus f_2\mid\\\exists x.f\mid\forall x.f\mid \mu Z.f\mid \nu Z.f\mid f[\hat{x}:=\hat{x}']$
- $x$和$Z$是布尔变量，$\hat{x}$是变量元组. $\mu$和$\nu$分别称为最小不动点和最大不动点操作符. $\mu Z.f$和$\nu Z.f$可以理解为$\lambda$表达式.

#### 语义

- 设$\rho$是一个valuation，$v$是一个变量，我们用$\rho(v)$表示变量$v$被$\rho$赋值，用$\rho[v\mapsto0]$表示变量$v$被赋值为$v$.
- 如此可以定义可满足性关系$\rho\models f$：
  - $\rho\not\models 0\qquad \rho\models1\qquad \rho\models v\ \textrm{iff}\ \rho(v)\ \mathrm{equals}\ 1$
  - $\rho\models\overline{f}\ \textrm{iff}\ \rho\not\models f\qquad \rho\models f+g\ \textrm{iff}\ \rho\models f\ \textrm{or}\ \rho\models g\qquad \rho\models f\cdot g\ \textrm{iff}\ \rho\models f\ \textrm{and}\ \rho\models g$
  - $\rho\models f\oplus g\ \textrm{iff}\ \rho\models(f\cdot\overline{g}+\overline{f}\cdot g)\qquad \rho\models\exists x.f\ \textrm{iff}\ \rho[x\mapsto 0]\models f\ \textrm{or}\ \rho[x\mapsto1]\models f$
  - $\rho\models\forall x.f\ \textrm{iff}\ \rho[x\mapsto 0]\models f\ \textrm{and}\ \rho[x\mapsto1]\models f\qquad \rho\models f[\hat{x}:=\hat{x}']\ \textrm{iff}\ \rho[\hat{x}:=\hat{x}']\models f$

- 不动点操作符
  - $\mu_0 Z.f\stackrel{\mathrm{def}}{=}0$
  - $\mu_{m+1}Z.f\stackrel{\mathrm{def}}{=}f[\mu_mZ.f/Z]\qquad (m\ge0)$
  - 可定义：$\rho\models\mu Z.f\ \textrm{iff}\ (\rho\models\mu_mZ.f\ \textrm{for some }m\ge0)$ 
  - $\nu_0 Z.f\stackrel{\mathrm{def}}{=}1$
  - $\nu_{m+1}Z.f\stackrel{\mathrm{def}}{=}f[\nu_mZ.f/Z]\qquad (m\ge0)$
  - 可定义：$\rho\models\nu Z.f\ \textrm{iff}\ (\rho\models\nu_mZ.f\ \textrm{for all }m\ge0)$ 

#### 编码CTL模型和规范

前面6.3节讲了如何表示传递关系$\to$为布尔函数.

- $f^x\stackrel{\mathrm{def}}{=}x\qquad \textrm{for varables }x$
- $f^\bot\stackrel{\mathrm{def}}{=}0$
- $f^{\neg\phi}\stackrel{\mathrm{def}}{=}\overline{f^\phi}$
- $f^{\phi\wedge\psi}\stackrel{\mathrm{def}}{=}f^\phi\cdot f\psi$
- $f^{\mathrm{EX}\ \phi}\stackrel{\mathrm{def}}{=}\exists \hat{x}'.(f^\to.f^\phi[\hat{x}:=\hat{x}'])$
- EF计算最小不动点（$\mathrm{EF}\phi\equiv\phi\vee\mathrm{EX}\ \mathrm{EF}\phi$）：$f^{\mathrm{EF}\phi}\stackrel{\mathrm{def}}{=}\mu Z.(f^{\phi}+\exists\hat{x}'.(f^\to\cdot Z[\hat{x}:=\hat{x}']))$
- 其他EU、AF、EG、EG也用类似的思路表示为布尔函数.

#### Fairness

命题连接符不影响公平性，只需考虑$E_CX,E_CU,E_CG$. 可以用$\texttt{fair}$布尔公式表示：$\texttt{fair}\stackrel{\mathrm{def}}{=}f^{E_CG\top}$. $\texttt{fair}$在一个状态$s$计算得1当且仅当从$s$开始存在一条对于$C$公平的路径，称$s$为公平状态（fair state）.