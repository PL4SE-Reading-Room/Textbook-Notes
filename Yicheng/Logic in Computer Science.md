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

