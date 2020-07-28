# 简单命令式语言

## 抽象语法

简单命令式语言的抽象语法定义如下：

<img src="2-The%20Simple%20Imperative%20Language.assets/image-20200721022248262.png" alt="image-20200721022248262" style="zoom: 67%;" />

其中，运算符的优先级顺序为：

![image-20200721022333427](2-The%20Simple%20Imperative%20Language.assets/image-20200721022333427.png)

假设";"是左结合的（实际上，";"的结合性不影响我们的语义）

## 指称语义

整数表达式和布尔表达式的指称语义和谓词逻辑相同（只是没有量词）。
$$
[\![\cdot]\!]_{\rm intexp} \in \textrm{<intexp>} \rightarrow \Sigma \rightarrow \mathbb{Z} \\ 
[\![\cdot]\!]_{\rm assert} \in \textrm{<assert>} \rightarrow \Sigma \rightarrow \mathbb{B}
$$
命令的指称语义为
$$
[\![\cdot]\!]_{\rm comm} \in \textrm{<comm>} \rightarrow \Sigma \rightarrow \Sigma_\bot
$$
其中，$\Sigma_\bot = \Sigma \cup \{\bot\}$, $\bot$表示命令不终止。

### 赋值语句

$$
[\![v := e]\!]_{\rm comm} \sigma = [\sigma | v:[\![e]\!]_{\rm intexp} \sigma]
$$

### Skip语句

$$
[\![v := e]\!]_{\rm comm} \sigma = \sigma
$$

### 顺序组合

$$
[\![c_0; c_1]\!]_{\rm comm} \sigma = ([\![c_1]\!]_{\rm comm})_\bot ([\![c_1]\!]_{\rm comm} \sigma)
$$

其中
$$
f_\bot \sigma = \begin{cases}
\bot, & \sigma = \bot \\
f \sigma, &{\rm otherwise} 
\end{cases}
$$

### 条件分支

$$
[\![\textbf{if } b \textbf{ then } c_0 \textbf{ else } c_1]\!]_{\rm comm} \sigma = 
\textbf{if } [\![b]\!]_{\rm boolexp} \sigma \textbf{ then } [\![c_0]\!]_{\rm comm} \textbf{ else } [\![c_1]\!]_{\rm comm}
$$

### While语句

如果我们将While展开，则

![image-20200727011044799](2-The%20Simple%20Imperative%20Language.assets/image-20200727011044799.png)

但是这个并不是While的语义，因为它不是语法制导的。

## 域和连续函数

### 域

**域**是一类特殊的偏序集，其上的偏序关系$\sqsubseteq$定义了一种“近似”关系：若$x \sqsubseteq y$，则称$x$逼近$y$，或$y$扩展$x$，其含义是，$y$至少提供了$x$所能提供的信息。

**链**是无限可数的单增序列：$x_0 \sqsubseteq x_1 \sqsubseteq x_2 \sqsubseteq \cdots$。一个链的上确界是它的**极限**。

一个偏序集$P$是**前域**，当且仅当它的每个链的极限都在$P$中。含有最小元$\bot$的前域是**域**。

### 连续函数

从前域$P$到另一个前域$P'$的函数$f$是**连续**的，当且仅当它是单调的，且能保持链的极限。即，对与任意$x,x' \in P$且$x \sqsubseteq x'$，都有$f(x) \sqsubseteq x'$，并且对于任意链$x_0 \sqsubseteq x_1 \sqsubseteq \cdots$，都有
$$
f(\sqcup_{i=0}^{\infty}x_i) = {\sqcup'}_{i=0}^{\infty}f(x_i)
$$

## 最小不动点定理

如果$D$是一个域，$f \in D \rightarrow D$是连续函数，则
$$
x = \bigsqcup_{n=0}^{\infty} f^n \bot
$$
是$f$的最小不动点；即，$fx = x$，且对于任意满足$fy=y$的$y$，都有$x \sqsubseteq y$。

令$\mathbf{Y}_D$为满足：对于任意$f \in D\rightarrow D$，$\mathbf{Y}_D f = \bigsqcup_{n=0}^{\infty} f^n \bot$的函数，即将$D$上的函数映射到其最小不动点。

### While的语义

![image-20200727014100641](2-The%20Simple%20Imperative%20Language.assets/image-20200727014100641.png)

## 变量定义和替换

### 变量定义的语义

![image-20200727014455426](2-The%20Simple%20Imperative%20Language.assets/image-20200727014455426.png)

即在执行$c$时，$v$的值为$e$，计算结束后，将$v$的值变回原来的值。

含有变量替换的命令的自由变量定义如下：

![image-20200727015101235](2-The%20Simple%20Imperative%20Language.assets/image-20200727015101235.png)

出现在左侧的自由变量（自由赋值）定义如下：

<img src="2-The%20Simple%20Imperative%20Language.assets/image-20200727015124603.png" alt="image-20200727015124603" style="zoom:67%;" />

