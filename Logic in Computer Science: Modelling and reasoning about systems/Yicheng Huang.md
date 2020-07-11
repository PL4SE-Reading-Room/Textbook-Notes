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