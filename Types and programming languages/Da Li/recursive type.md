# Recursive Type

## Chapter 20

### What is recursive type?

For example, a list of numbers is defined by recursive type.
$$
NatList = \mu X.<nil:Unit,\ cons:\{Nat,X\}>
$$

### Interesting examples

后半部分的例子没有看懂...

### What is the relation between the type *µX.T* and its one-step unfolding?

E.g., what is the relation between *NatList* and *\<nil:Unit, cons:{Nat, NatList}\>*?

### Equi-recursive & iso-recursive (等价 or 同构)

$$
unfold[\mu X.T] : \mu X.T \to [X \mapsto \mu X.T] T \\
fold[\mu X.T] : [X \mapsto \mu X.T] T \to \mu X.T
$$

真实场景下, 大多采用同构策略, 比如ML语言中的 pattern matching, 其中就隐含了 unfold 操作; DataType 的构建过程就隐含了 fold 操作; **Java 的类定义隐含了 fold, 在对象上调用方法隐含了 unfold.**

### Recursive type mixed up with subtyping

待续...