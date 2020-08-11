# Logic in Computer Science Modelling and Reasoning about Systems

*逻辑建模和系统推理

[TOC]

---

URL of book : www.cs.bham.ac.uk/research/lics/

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

框内第一行假设 最后一行结论 框下第一条推导

$p \wedge q \rightarrow r \dashv \vdash p \rightarrow (q\rightarrow r)$

$\dashv \vdash$ : `\dashv \vdash` can relate two formulas to each other

---

##### TOTAL 

*at page: 42 - 43  - (x) in each line: at page x

//${\rm \wedge e_k}$ & ${\rm \vee i_k}$ : k - 横线上下都有的elem

|                      |                        *introduction*                        |                        *elimination*                         |
| :------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|     $\wedge$(22)     | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155012984.png" alt="image-20200710155012984" style="zoom:50%;" /><br />*and-introduction* | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155025501.png" alt="image-20200710155025501" style="zoom:50%;" /><br />*and-elimination* |
|      $\vee$(32)      | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155045502.png" alt="image-20200710155045502" style="zoom:50%;" /><br />*or-introduction* | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155114732.png" alt="image-20200710155114732" style="zoom:50%;" /><br />*or-elimination* |
| $\rightarrow$(27,25) | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155127387.png" alt="image-20200710155127387" style="zoom:50%;" /><br />*implies-introduction* | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155133498.png" alt="image-20200710155133498" style="zoom:50%;" /><br />*implies-elimination / arrow-elimination*<br />Latin: 肯定前件 [modus ponens]([https://baike.baidu.com/item/%E5%91%BD%E9%A2%98%E6%BC%94%E7%AE%97%E5%88%86%E7%A6%BB%E8%A7%84%E5%88%99/19062284?fr=aladdin](https://baike.baidu.com/item/命题演算分离规则/19062284?fr=aladdin)) |
|                      |                                                              | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710164458739.png" alt="image-20200710164458739" style="zoom:80%;" /><br />Latin: 否定后件 modus tollens |
|      $\neg$(38)      | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155230701.png" alt="image-20200710155230701" style="zoom:50%;" /><br />*neg-introduction* | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155242428.png" alt="image-20200710155242428" style="zoom:50%;" /><br /> |
|                      | <img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200716153127525.png" alt="image-20200716153127525" style="zoom:50%;" /><br />Latin：reductio ad absurdum 归谬证法RAA<br />*proof by contradiction*-PBC(40) | <img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200716160054407.png" alt="image-20200716160054407" style="zoom:50%;" /><br />Latin：tertium non datur 排中律<br />the law of the excluded middle，LEM(41) |
|     $\perp$(37)      |                             none                             | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155257920.png" alt="image-20200710155257920" style="zoom:50%;" /><br />*bottom-elimination* |
|    $\neg\neg$(24)    |                             none                             | <img src=".\Logic in Computer Science Modelling and Reasoning about Systems\image-20200710155320936.png" alt="image-20200710155320936" style="zoom:50%;" /><br />*double negation* |

Definition 1.10 [theorems] Logical formulas $\phi$ with valid sequent $\vdash \phi$

---

##### Definition 1.19 [contradictions,矛盾]

 expression of the form $\phi \wedge \neg \phi$ or $\neg \phi \wedge \phi$

矛盾可以作为前提 推导出任何结论

$\bot$ : `\bot`  symbol name : up tack/falsum [wiki]([https://en.jinzhao.wiki/wiki/Up_tack#:~:text=The%20up%20tack%20or%20falsum,%22falsum%22%20or%20%22absurdum%22](https://en.jinzhao.wiki/wiki/Up_tack#:~:text=The up tack or falsum,"falsum" or "absurdum"))

- A logical constant denoting a false proposition in logic, often called "falsum, Latin 伪造" or "absurdum ，Latin悖理，荒谬"

- The [bottom element](https://en.jinzhao.wiki/wiki/Bottom_element) in [lattice theory](https://en.jinzhao.wiki/wiki/Lattice_theory), which also represents absurdum when used for logical semantics 

  ​	lattice逻辑中的最小元

- The [bottom type](https://en.jinzhao.wiki/wiki/Bottom_type) in [type theory](https://en.jinzhao.wiki/wiki/Type_theory), which also represents absurdum under the [Curry–Howard correspondence](https://en.jinzhao.wiki/wiki/Curry–Howard_correspondence)

  ​	类型理论的底部元素

a similar symbol $\perp$ : perpendicular, `\perp` 垂线or垂直

---

#### 1.2.4 Rules for natural deduction

*page：45 可证明的等价性

<span name="iff"></span>

iff - *provably equivalent*  $\dashv \vdash$,`\dashv \vdash`

​	iff $\phi \vdash \psi$ and $\psi \vdash \phi$ , $\phi \dashv \vdash \psi$

<img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200716154744877.png" alt="image-20200716154744877" style="zoom:80%;" />

**Example1.13** *page:31

first prove $p \wedge q \rightarrow r \vdash p \rightarrow (q \rightarrow r)$

then prove $p \wedge q \rightarrow r \dashv p \rightarrow (q \rightarrow r)$

$p \wedge q \rightarrow r \dashv \vdash p \rightarrow (q \rightarrow r)$

---

#### Online Exercise of Chap 1:

Q1)5	

Q2)2	

Q3)2

- Recall that $p \leftrightarrow q $ is an abbreviation for $(p \rightarrow q)\wedge(q \rightarrow p)$

Q4)5 赋值枚举

- tautology 重言式 tautology is a formula that evaluates to T for all possible assignments of truth values. 永真式

Q5)2 否定后件MT

- entailments：衍推

Q6)3   $\neg p \vee q \vee \neg r$ T F T = F

Q7)4

Q8)2 注意运算符binding顺序

Q9)2

Q10)4

Q11)1

Q12)3

Q13)3

Q14)2

<img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200716163957999.png" alt="image-20200716163957999" style="zoom:80%;" />

<img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200716164011282.png" alt="image-20200716164011282" style="zoom:80%;" />

Q15)5

Q16)2

---

#### 1.2.5 An aside: proof by contradiction

- 从$\neg \phi$推导到 $\bot$，以说明$\phi$成立。

   classical logicians: 古典学家 认为成立

  intuitionistic logicians：直观逻辑学家/直觉论者 认为不成立  

- 他们都反对

  <img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200719132316709.png" alt="image-20200719132316709" style="zoom: 80%;" />

**Theorem 1.26** There exist irrational numbers a and b such that $a^b$ is rational.

a&b:无理数

$a^b$：有理数

令b=$\sqrt{2}$  if $b^b$ is

- rational, a=$\sqrt{2}$ ,成立
- irrational, a=$b^b$, 则 $a^b=(\sqrt{2}^{\sqrt{2}})^\sqrt{2} = \sqrt{2}^{(\sqrt{2} \cdot \sqrt{2})}=2$,成立

因此命题成立。



LEM：我们不知道哪种情况成立，但 $\phi\vee\neg\phi$是成立的

Our proof tells us nothing about which of them is the right choice; it just says that at least one of them works.

---

### 1.3 Propositional logic as a formal language

#### Definition 1.27 well-formed formulas

we obtain by using the **construction rules** below, and only those, **finitely many times**. 使用构造规则在有限次数内生成的。

<img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200719134306888.png" alt="image-20200719134306888" style="zoom:80%;" />

**Backus Naur form (BNF)**

above：$\phi ::= p|(\neg\phi)|(\phi\wedge\phi)|(\phi\vee\phi)|(\phi\rightarrow\phi) $

$(((\neg p )\wedge q)\rightarrow(p\wedge(q\vee(\neg r)))$

<span name="BNF"></span>

---

### 1.4 Semantics of propositional logic

*page: 52

#### 1.4.1 The meaning of logical connectives

$\models$: `\models` [double turnstile](https://en.wikipedia.org/wiki/Double_turnstile)  "is a  semantics consequence of"

<span name="chap1_4_1"></span>

如果对$\forall \phi_i$赋值为T,$\psi$也为T,则

$\phi_1,\phi_2,...,\phi_n \models \psi$

其中$\models$ 是 semantic entailment relation 语义蕴含关系



$\vdash$:`\vdash` [turnstile](https://en.jinzhao.wiki/wiki/Turnstile_(symbol))  syntactic consequence 

<img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200721125900136.png" alt="image-20200721125900136" style="zoom:80%;" />

---

#### 1.4.2 Mathematical induction 数学归纳法

**Definition 1.30** 归纳法的基础是，对于$\forall$的n，都有性质property M(n)。这里M(n)被称为归纳假设induction hypothesis。



**course-of-values induction**：值途归纳法？

- 一般证明  一个base case + M(n) $\rightarrow$ M(n+1)

- course-of-values induction: M(1)$\wedge$M(2)$\wedge \cdots \wedge$M(n) $\rightarrow$ M(n+1)

  ​	不需要explicit base case 



**structural induction**: [wiki_link](https://en.jinzhao.wiki/wiki/Structural_induction)

Using the notion of the height of a parse tree, we realise that structural induction is just a special case of course-of-values induction.

？- 面向一个有偏序的结构？

[wiki] A well-founded partial order is defined on the structures ("subformula" for formulas, "sublist" for lists, and "subtree" for trees)



---

#### 1.4.3 Soundness of propositional logic 可靠性/健全性

[wiki_soundness](https://en.jinzhao.wiki/wiki/Soundness)

*page:61

page:<a href="#chap1_4_1">62</a> semantic entailment relation 语义蕴含关系 $\models$, `\models`



**Theorem 1.35 (Soundness)**

如果$\phi_1,\phi_2,...,\phi_n \vdash \psi$, 则$\phi_1,\phi_2,...,\phi_n \models \psi$



#### 1.4.4 Completeness of propositional logic 完整性

Soundness: if ($\vdash$) is valid, then ($\models$) holds

Completeness: if  ($\models$) holds, then ($\vdash$) is valid

**Corollary 1.39 (Soundness and Completeness) **P69

​		($\vdash$) is valid **iff** ($\models$) holds / ($\models$) holds  **iff** ($\vdash$) is valid

- 关于$\vdash and \vDash$ from wiki
  - $\vdash$ - From P, I know that Q
  - $\vDash$ - if P is True，then Q is True

- iff(If and only if): <a href="#iff">book_link</a>, [wiki_link](https://en.jinzhao.wiki/wiki/If_and_only_if) 

- proof:(Page 65 : **TODO**)

  <img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200721133412592.png" alt="image-20200721133412592"  />

**Step 1**: p66

**Definition 1.36** 重言式 tautology

A formula of propositional logic $\phi$ is called a tautology iff it evaluates to **T** under all its valuations, i.e. iff $\vDash \phi$



**Step 2**:

**Theorem 1.37** 重言式 tautology 是 定理 theorem

if $\vDash \eta$ holds, then $\vdash \eta$ is valid.

- if $\eta$ is a tautology, then $\eta$ is a theorem

$\eta$ - `\eta`

[TODO for Step 2]

---

### 1.5 Normal forms 范式

*page：70

#### 1.5.1 Semantic equivalence, satisfiability and validity

**Definition 1.40** semantically equivalent 语义等价

iff $\phi \models \psi$ and $\psi \models \phi$ ,  $\phi \equiv \psi$  

<a href="#chap1_4_1">symbol link of turnstile & models</a> 

$\vdash$ - `\vdash` , [turnstile(wiki)](https://en.jinzhao.wiki/wiki/Turnstile_(symbol))  syntactic consequence of provability 可证明性的句法推论

![image-20200810232525414](D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200810232525414.png)



$\models$ - `\models or \vDash`, semantic entailment relation 语义蕴含关系 semantic consequence 语义推论？[double turnstile(wiki)](https://en.jinzhao.wiki/wiki/Double_turnstile)

![image-20200810232933120](D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200810232933120.png)



$\equiv$ - `\equiv ` , semantically equivalent 语义等价

<img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200810235110510.png" alt="image-20200810235110510" style="zoom:80%;" />



**Definition 1.42** conjunctive normal form 合取范式CNF 

<img src="D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200810235445907.png" alt="image-20200810235445907" style="zoom: 67%;" />

L - literal, atom p or neg of p

D - clause, a **disjunction** of literals L

C - formula, a **conjuntion** of clauses D

Note: $(\neg(q\vee p)\vee r)\wedge p$ 不是CNF，这里$q\vee p$ 不是一个L



- **Backus Naur form (BNF)** <a href="#BNF">book link</a>

  ​	$\phi ::= p|(\neg\phi)|(\phi\wedge\phi)|(\phi\vee\phi)|(\phi\rightarrow\phi) $



**Lemma 1.43** 在disjunction(\wedge)阶段, 如果同时存在$L_i$和$\neg L_i$,则CNF成立valid。

**proof**：如果不存在，则一定有一种赋值使得CNF为false

- 是atom则赋值为F，是neg atom则赋值为T

---

#### 1.5.2 Conjunctive normal forms and validity

page：74

![image-20200811133127235](D:\GitHub\Textbook-Notes\Logic in Computer Science - Modelling and reasoning about systems\Xinyi Mao\Logic in Computer Science Modelling and Reasoning about Systems\image-20200811133127235.png)

为input formulas计算一个等价的CNF形式的formulas。