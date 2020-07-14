# Logic in Computer Science Modelling and Reasoning about Systems

*逻辑建模和系统推理

[TOC]

---

## Chapter 1. Propositional logic 命题逻辑

*page：17

【词汇】

reason：推理

arguments：论点

defended rigorously：严格的进行辩护

subject：主题



[Example 1.1&1.2]

<span name="chap1_1"></span>

> If p and not q,then r.Not r. p. Therefore, q.

<img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200703193736645.png" alt="image-20200703193736645" style="zoom:67%;" />

<a href="#chap1.2_1">sequent</a>



### 1.1 Declarative sentences 陈述句

【词汇】

propositions：命题

declarative sentence：陈述句

// they are in principle capable of being declared ‘true’, or ‘false’.

// they are atomic(原子的) or indecomposable(不可分解的).

predicate logic：谓词逻辑 （Chap 2）

proliferation：激增

binding priorities：结合优先级 $\neg$ > $\vee \backslash\wedge$ > $\rightarrow$ 



---

for atomic sentences `p`, `q` ,`r`:

$\neg$: *negation*,   `\neg`

$\vee$: *disjunction* - at least one of them is true, 析取 `\vee`

$\wedge$: *conjunction*, 合取 `\wedge`

$\rightarrow$: *implication*, 蕴含  $p \rightarrow q$  suggesting that $q$ is a logical consequence of $p$, `\rightarrow`

​		$p$: *assumption* 

​		*q*: *conclusion*



binding priorities：结合优先级 

- $\neg$ > $\vee \backslash\wedge$ > $\rightarrow$ 

- $\rightarrow$ : $p \rightarrow q \rightarrow r$  denote $p \rightarrow (q \rightarrow r)$

---

### 1.2 Natural deduction 自然演绎 

*page：21

【词汇】

infer：推断

premise：前提 $\phi$ `\phi`

conclusion：结论 $\psi$`\psi`



---

**sequent 相继式**

infer a conclusion from a set of premises.

$\phi_1,\phi_2,...,\phi_n \vdash \psi$ ,  

$\vdash$ :  `\vdash`

<span name="chap1.2_1"></span>



a sequent for <a href="#chap1_1">example1.1&1.2</a>:

> If p and not q,then r.Not r. p. Therefore, q.

$p\wedge \neg q \rightarrow r,\neg r,p \vdash q$

$\vdash$ 前为条件/前提 后为结论。

---

#### 1.2.1 Rules for natural deduction

【词汇】

plausible：看似可信的

【Latin】modus ponens ：肯定前件 若p则q，p为真  -> q为真

【Latin】modus tollens ：否定后件 若p则q，q为假  -> p为假

provisional conclusions：临时结论 

​		(证明中的一行 is a premises/assumption/provisional conclusions)

---



**for conjunction：and-introduction**
$$
\frac{\phi\qquad\psi}{\phi\wedge\psi}{\rm \wedge i.}
$$
above line - premises - $\phi$ & $\psi$

below line - conclusion - $\phi \wedge \psi$

right of line - name of the rule - ${\rm \wedge i.}$ "and-introduction"

---

##### 【example】

**problem** : $p \wedge q,r \vdash q \wedge r$

**answer**:

<img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710162310845.png" alt="image-20200710162310845" style="zoom:70%;" />

列出所有前提 - 空几行 - 列出结论 （前提必须在前几行？

- 行号 - 公式编号

- 后缀 - 证明规则 proof rules 
     - premise  
     - ${\rm \wedge e_i \space j}$  : 在第j行上使用消去规则${\rm \wedge e_i}$, 留下了第i个元素



**answer (in tree format)**:

<img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710162405507.png" alt="image-20200710162405507" style="zoom:70%;" />



---

##### **use assumption box** : // type checking

an argumentation for $p\rightarrow q \vdash \neg q \rightarrow \neg p$

<img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200712170535546.png" alt="image-20200712170535546" style="zoom:70%;" />

box - demarcate the scope of the temporary assumption

【type checking】

if $p \rightarrow q$  is a type of a procedure : input a int and return a bool

validity / assume-guarantee : if input is int, then output is bool.



【${\rm \rightarrow i}$】
$$
\frac{\boxed{\phi \\ \space \vdots \\ \psi}}{\phi \rightarrow \psi}{\rm \rightarrow i.}
$$
in order to prove $\phi \rightarrow \psi$, make a temporary assumption of $\psi$ and then prove $\phi$.

---

##### TOTAL 

*at page:43  - (x) in each line: at page x

//${\rm \wedge e_k}$ & ${\rm \vee i_k}$ : k - 横线上下都有的elem

|                      |                        *introduction*                        |                        *elimination*                         |
| :------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|     $\wedge$(22)     | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155012984.png" alt="image-20200710155012984" style="zoom:50%;" /><br />*and-introduction* | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155025501.png" alt="image-20200710155025501" style="zoom:50%;" /><br />*and-elimination* |
|      $\vee$(22)      | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155045502.png" alt="image-20200710155045502" style="zoom:50%;" /> | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155114732.png" alt="image-20200710155114732" style="zoom:50%;" /> |
| $\rightarrow$(27,25) | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155127387.png" alt="image-20200710155127387" style="zoom:50%;" /><br />*implies-introduction* | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155133498.png" alt="image-20200710155133498" style="zoom:50%;" /><br />*implies-elimination / arrow-elimination*<br />Latin: 肯定前件 [modus ponens]([https://baike.baidu.com/item/%E5%91%BD%E9%A2%98%E6%BC%94%E7%AE%97%E5%88%86%E7%A6%BB%E8%A7%84%E5%88%99/19062284?fr=aladdin](https://baike.baidu.com/item/命题演算分离规则/19062284?fr=aladdin)) |
|                      |                                                              | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710164458739.png" alt="image-20200710164458739" style="zoom:80%;" /><br />Latin: 否定后件 modus tollens |
|      $\neg$(22)      | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155230701.png" alt="image-20200710155230701" style="zoom:50%;" /> | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155242428.png" alt="image-20200710155242428" style="zoom:50%;" /> |
|     $\perp$(22)      |                             none                             | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155257920.png" alt="image-20200710155257920" style="zoom:50%;" /> |
|    $\neg\neg$(24)    |                             none                             | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155320936.png" alt="image-20200710155320936" style="zoom:50%;" /><br />*double negation* |















