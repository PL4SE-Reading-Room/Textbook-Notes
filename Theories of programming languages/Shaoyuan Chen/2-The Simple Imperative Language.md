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

