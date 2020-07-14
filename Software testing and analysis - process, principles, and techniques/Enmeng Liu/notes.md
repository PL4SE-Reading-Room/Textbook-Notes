# Software Testing and Analysis

## Chapter 1  Software Test and Analysis in a Nutshell

### 1.1 Engineering Processes and Veriﬁcation

+ 流水线化生产的产品（如汽车、显示屏）有统一的质检方式，单独生产的产品（如房屋）每一件都需要专门设计质检方法，软件属于后者。
+ 随着产品复杂度和多样性的提升，verification也会变得困难。软件是最多变、最复杂的一类产品：不同环境下的软件会有很大的区别，开发进程中软件的结构会变化，软件系统是非线性的（能载重2t电梯肯定满足载重1t，但能正确排序256个数的程序未必能正确排序255个数字）
+ 软件测试没有fixed recipe，需要根据实际的问题、需求和开发环境设计对应的具体方法。

### 1.2 Basic Questions

+ When do veriﬁcation and validation start? When are they complete? 
+ What particular techniques should be applied during development of the product to obtain acceptable quality at an acceptable cost? 
+ How can we assess the readiness of a product for release? 
+ How can we control the quality of successive releases? 
+ How can the development process itself be improved over the course of the current and future projects to improve products and make veriﬁcation more cost-effective?



### 1.3 When Do Veriﬁcation and Validation Start and End?

+ 工程开始前的可行性分析就需要综合考虑多方面，包括测试方案
+ 分解任务

### 1.4 What Techniques Should Be Applied?

+ V&V
  + Verification：检查中间产物或最终产品的quality
  + Validation：检查产品是否符合用户预期
+ 需求说明书
+ 单元测试
+ 需要控制流的覆盖程度
+ 系统测试：将程序建模为有限状态自动机
+ 质量测试还包括对performance,  usability和security的测试

### 1.5 How Can We Assess the Readiness of a Product?

+ 测试是有极限的。<s>所以我不测试啦，manager！</s>目标是确保测试的花销与取得的软件质量足够cost-effective。——需要有衡量软件可靠性的标准。
+ 有多种不同的衡量标准：
  + availability：宕机时间不能太久
  + MTBF(mean time between failures): 平均avaliable时长
  + reliabilty: 所有操作（运行、交互、会话）成功的比例
+ 可靠性测试：
  + 如果能有history usage data来生成测试集是对实际使用环境的正确建模，测试效果会很好，但这是几乎不可能的
  + alpha testing:  开发团队监控用户在受控环境下的使用，来测试软件可靠性
  + beta testing：实际用户在他们自己的环境中不受打扰或监控地使用软件

### 1.6 How Can We Ensure the Quality of Successive Releases?

+ 软件发布之后环境一直在变化，包括设备驱动、操作系统、底层数据库、用户需求等
+ 主要的release称为“point release”，小的release称为"patch level" release。
  + 在每次point release之前一般都会进行测试全家桶，point release之间相当于beta testing
  + patch release通常是为了解决一下紧急的问题，测试一般都会比较精简，自动化程度非常重要



### 1.7 How Can the Development Process Be Improved?

+ quality improvement program：追踪分类错误，找出导致它们的human errors和使它们不易发现的测试中的漏洞
+ 错误分析与过程优化一般分为4个阶段
  + 定义需要收集的数据并实现收集的方法
  + 分析收集到的数据并识别出重要的错误类型
  + 分析所选的错误类型来寻找开发与测试过程中的不足
  + 改进开发和测试过程
+ 虽然quality process improve和改进单独的产品是不同的工作，但是将数据收集的功能集成进bug track system保证了这两项工作可以同时进行



### 小结

+ quality process的三大目标
  + 改进一个特定的软件产品（通过避免、发现和去除faults）
  + 评估软件产品的质量（与明确的质量目标有关）
  + 改进quality process本身
+ 这三大目标都要求质量保证行为交织到开发的全过程中



## Chapter 2 A Framework for Test and Analysis

