---
categories:  #分类
    - AD
    - PCB
    - 嵌入式
tags:   #标签
    - AD
    - PCB
    - 嵌入式
---
# Altium Designer 规则检查(DRC)英汉对照表
<!-- more -->
## Error Reporting 错误报告
### A：Violations Associated with Buses 有关总线电气错误的各类型（共12项）
    1、 bus indices out of range 总线分支索引超出范围 
    2、 Bus range syntax errors 总线范围的语法错误 
    3、 Illegal bus range values 非法的总线范围值 
    4、 Illegal bus definitions 定义的总线非法 
    5、 Mismatched bus label ordering 总线分支网络标号错误排序 
    6、 Mismatched bus/wire object on wire/bus 总线/导线错误的连接导线/总线 
    7、 Mismatched bus widths 总线宽度错误 
    8、 Mismatched bus section index ordering 总线范围值表达错误 
    9、 Mismatched electrical types on bus 总线上错误的电气类型 
    10、 Mismatched generics on bus (first index) 总线范围值的首位错误 
    11、 Mismatched generics on bus (second index) 总线范围值末位错误 
    12、 Mixed generics and numeric bus labeling 总线命名规则错误 
### B：Violations Associated Components 有关元件符号电气错误（共20项）
    1、Component Implementations with missing pins in sequence 元件管脚的序号出现序号丢失 
    2、 Component contaning duplicate sub-parts 元件中出现了重复的子部分 
    3、 Component with duplicate Implementations 元件被重复使用 
    4、 Component with duplicate pins 元件中有重复的管脚 
    5、 Duplicate component models 一个元件被定义多种重复模型 
    6、 Duplicate part designators 元件中出现标示号重复的部分 
    7、 Errors in component model parameters 元件模型中出现错误的的参数 
    8、 Extra pin found in component display mode 多余的管脚在元件上显示 
    9、 Mismatched hidden pin component 元件隐藏管脚的连接不匹配 
    10、 Mismatched pin visibility 管脚的可视性不匹配 
    11、 Missing component model parameters 元件模型参数丢失 
    12、 Missing component models 元件模型丢失 
    13、 Missing component models in model files 元件模型不能在模型文件中找到 
    14、 Missing pin found in component display mode 不见的管脚在元件上显示 
    15、 Models found in different model locations 元件模型在未知的路径中找到 
    16、 Sheet symbol with duplicate entries 方框电路图中出现重复的端口 
    17、 Un-designated parts requiring annotation 未标记的部分需要自动标号 
    18、 Unused sub-part in component 元件中某个部分未使用 
    19、 Component Implementations with duplicate pins usage 元件管脚在原理图中重复被使用 
    20、 Component Implementations with invalid pin mappings 元件管脚在应用中和PCB封装中的焊盘不符

### C：violations associated with document 相关的文档电气错误（共10项）
    1、 conflicting constraints 约束不一致的 
    2、 duplicate sheet symbol name 层次原理图中使用了重复的方框电路图 
    3、 duplicate sheet numbers 重复的原理图图纸序号 
    4、 missing child sheet for sheet symbol 方框图没有对应的子电路图 
    5、 missing configuration target 缺少配置对象 
    6、 missing sub-project sheet for component 元件丢失子项目 
    7、 multiple configuration targets 无效的配置对象 
    8、 multiple top-level document 无效的顶层文件 
    9、 port not linked to parent sheet symbol 子原理图中的端口没有对应到总原理图上的端口 
    10、sheet enter not linked to child sheet 方框电路图上的端口在对应子原理图中没有对应端口 

--------------------------------------------------------------------------------
### D：violations associated with nets 有关网络电气错误（共19项）
    1、 adding hidden net to sheet 原理图中出现隐藏网络 
    2、 adding items from hidden net to net 在隐藏网络中添加对象到已有网络中 
    3、 auto-assigned ports to device pins 自动分配端口到设备引脚 
    4、 duplicate nets 原理图中出现重名的网络 
    5、 floating net labels 原理图中有悬空的网络标签 
    6、 global power-objects scope changes 全局的电源符号错误 
    7、 net parameters with no name 网络属性中缺少名称 
    8、 net parameters with no value 网络属性中缺少赋值 
    9、 nets containing floating input pins 网络包括悬空的输入引脚 
    10、nets with multiple names 同一个网络被附加多个网络名 
    11、nets with no driving source 网络中没有驱动 
    12、nets with only one pin 网络只连接一个引脚 
    13、nets with possible connection problems 网络可能有连接上的错误 
    14、signals with multiple drivers 重复的驱动信号 
    15、sheets containing duplicate ports 原理图中包含重复的端口 
    16、signals with load 信号无负载 
    17、signals with drivers 信号无驱动 
    18、unconnected objects in net 网络中的元件出现未连接对象 
    19、unconnected wires 原理图中有没连接的导线 

--------------------------------------------------------------------------------
### E：Violations associated with others有关原理图的各种类型的错误(3项)
    1、 No Error 无错误 
    2、 Object not completely within sheet boundaries 原理图中的对象超出了图纸边框 
    3、 Off-grid object原理图中的对象不在格点位置 

--------------------------------------------------------------------------------
### F：Violations associated with parameters 有关参数错误的各种类型
    1、 same parameter containing different types 相同的参数出现在不同的模型中 
    2、 same parameter containing different values 相同的参数出现了不同的取
