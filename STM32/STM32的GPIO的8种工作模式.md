---
categories:  #分类
    - STM32单片机
    - C
    - 嵌入式
tags:   #标签
    - STM32单片机
    - C
    - 嵌入式
    - GPIO工作模式
---

## 基础知识
<p>STM32F103ZET6一共有7组IO口，即GPIOA,GPIOB,GPIOC到GPIOG。每组IO口有16个IO，所以一共有112个IO。STM32的大部分引脚除了当GPIO使用外，还可以复用为外设功能引脚（比如串口）。<br> 下图为I/O端口位的基本结构<br> <img src="https://img-blog.csdnimg.cn/20200813162402414.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"></p> 
<hr> 
<p>最近在看数据手册的时候，发现在Cortex-M3里，对于GPIO的配置种类有8种之多：<br> （1）GPIO_Mode_AIN 模拟输入<br> （2）GPIO_Mode_IN_FLOATING 浮空输入<br> （3）GPIO_Mode_IPD 下拉输入<br> （4）GPIO_Mode_IPU 上拉输入<br> （5）GPIO_Mode_Out_OD 开漏输出<br> （6）GPIO_Mode_Out_PP 推挽输出<br> （7）GPIO_Mode_AF_OD 复用开漏输出<br> （8）GPIO_Mode_AF_PP 复用推挽输出</p> 
<p>对于刚入门的新手，我想这几个概念是必须得搞清楚的，平时接触的最多的也就是推挽输出、开漏输出、上拉输入这三种，但一直未曾对这些做过归纳。因此，在这里做一个总结：</p> 
<h1><a name="t1"></a><a name="t1"></a><a id="1__18"></a>1. 推挽输出</h1> 
<p>推挽输出:可以输出强高,低电平,连接数字器件; 推挽结构一般是指两个三极管分别受两互补信号的控制,总是在一个三极管导通的时候另一个截止。高低电平由IC的电源低定。<br> <img src="https://img-blog.csdnimg.cn/20200813162625821.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"></p> 
<p>推挽电路是两个参数相同的三极管或MOSFET,以推挽方式存在于电路中,各负责正负半周的波形放大任务,电路工作时，两只对称的功率开关管每次只有一个导通，所以导通损耗小、效率高。输出既可以向负载灌电流，也可以从负载抽取电流。推拉式输出级既提高电路的负载能力，又提高开关速度。<br> <img src="https://img-blog.csdnimg.cn/20200813154318408.png#pic_center" alt="在这里插入图片描述"><br> 如图所示，推挽放大器的输出级有两个“臂”（两组放大元件），一个“臂”的电流增加时，另一个“臂”的电流则减小，二者的状态轮流转换。对负载而言，好像是一个“臂”在推，一个“臂”在拉，共同完成电流输出任务。当输出高电平时，也就是下级负载门输入高电平时，输出端的电流将是下级门从本级电源经VT3拉出。这样一来，输出高低电平时，VT3 一路和 VT5 一路将交替工作，从而减低了功耗，提高了每个管的承受能力。又由于不论走哪一路，管子导通电阻都很小，使RC常数很小，转变速度很快。因此，推拉式输出级既提高电路的负载能力，又提高开关速度。</p> 
<h1><a name="t2"></a><a name="t2"></a><a id="2__26"></a>2. 开漏输出</h1> 
<p>开漏输出:只可以输出强低电平，高电平得靠外部电阻拉高。输出端相当于三极管的集电极。要得到高电平状态需要上拉电阻才行。适合于做电流型的驱动，其吸收电流的能力相对强(一般20mA以内)。<br> <img src="https://img-blog.csdnimg.cn/20200813162541291.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"></p> 
<p>开漏形式的电路有以下几个特点：</p> 
<ol><li> <p>利用外部电路的驱动能力，减少IC内部的驱动。当IC内部MOSFET导通时，驱动电流是从外部的VCC流经R pull-up ，MOSFET到GND。IC内部仅需很下的栅极驱动电流。</p> </li><li> <p>一般来说，开漏是用来连接不同电平的器件，匹配电平用的，因为开漏引脚不连接外部的上拉电阻时，只能输出低电平，如果需要同时具备输出高电平的功能，则需要接上拉电阻，很好的一个优点是通过改变上拉电源的电压，便可以改变传输电平。比如加上上拉电阻就可以提供TTL/CMOS电平输出等。（上拉电阻的阻值决定了逻辑电平转换的沿的速度 。阻值越大，速度越低功耗越小，所以负载电阻的选择要兼顾功耗和速度。）</p> </li><li> <p>OPEN-DRAIN提供了灵活的输出方式，但是也有其弱点，就是带来上升沿的延时。因为上升沿是通过外接上拉无源电阻对负载充电，所以当电阻选择小时延时就小，但功耗大；反之延时大功耗小。所以如果对延时有要求，则建议用下降沿输出。</p> </li><li> <p>可以将多个开漏输出的Pin，连接到一条线上。通过一只上拉电阻，在不增加任何器件的情况下，形成“与逻辑”关系。这也是I2C，SMBus等总线判断总线占用状态的原理。补充：什么是“线与”？：</p> </li></ol> 
<p>在一个结点(线)上, 连接一个上拉电阻到电源 VCC 或 VDD 和 n 个 NPN 或 NMOS 晶体管的集电极 C 或漏极 D, 这些晶体管的发射极 E 或源极 S 都接到地线上, 只要有一个晶体管饱和, 这个结点(线)就被拉到地线电平上. 因为这些晶体管的基极注入电流(NPN)或栅极加上高电平(NMOS), 晶体管就会饱和, 所以这些基极或栅极对这个结点(线)的关系是或非 NOR 逻辑. 如果这个结点后面加一个反相器, 就是或 OR 逻辑.</p> 
<p>其实可以简单的理解为：在所有引脚连在一起时，外接一上拉电阻，如果有一个引脚输出为逻辑0，相当于接地，与之并联的回路“相当于被一根导线短路”，所以外电路逻辑电平便为0，只有都为高电平时，与的结果才为逻辑1。</p> 
<p>关于推挽输出和开漏输出，最后用一幅最简单的图形来概括：<br> <img src="https://img-blog.csdnimg.cn/20200813154507233.png#pic_center" alt="在这里插入图片描述"><br> 该图中左边的便是推挽输出模式，其中比较器输出高电平时下面的PNP三极管截止，而上面NPN三极管导通，输出电平VS+；当比较器输出低电平时则恰恰相反，PNP三极管导通，输出和地相连，为低电平。右边的则可以理解为开漏输出形式，需要接上拉。</p> 
<h1><a name="t3"></a><a name="t3"></a><a id="3__48"></a>3. 浮空输入</h1> 
<p>浮空输入：浮空（floating）就是逻辑器件的输入引脚即不接高电平，也不接低电平。由于逻辑器件的内部结构，当它输入引脚悬空时，相当于该引脚接了高电平。一般实际运用时，引脚不建议悬空，易受干扰。 通俗讲就是让管脚什么都不接，浮空着。<br> <img src="https://img-blog.csdnimg.cn/2020081316243415.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"></p> 
<p><img src="https://img-blog.csdnimg.cn/20200813154535882.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"><br> 由于浮空输入一般多用于外部按键输入，结合图上的输入部分电路，我理解为浮空输入状态下，IO的电平状态是不确定的，完全由外部输入决定，如果在该引脚悬空的情况下，读取该端口的电平是不确定的。</p> 
<h1><a name="t4"></a><a name="t4"></a><a id="4__55"></a>4. 上拉输入</h1> 
<p>上拉输入：上拉就是把电位拉高，比如拉到Vcc。上拉就是将不确定的信号通过一个电阻嵌位在高电平！电阻同时起限流作用！强弱只是上拉电阻的阻值不同，没有什么严格区分。<br> <img src="https://img-blog.csdnimg.cn/20200813162451641.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"></p> 
<h1><a name="t5"></a><a name="t5"></a><a id="5__59"></a>5. 下拉输入</h1> 
<p>下拉输入：就是把电压拉低，拉到GND。与上拉原理相似。<br> <img src="https://img-blog.csdnimg.cn/20200813162501388.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"></p> 
<h1><a name="t6"></a><a name="t6"></a><a id="6__63"></a>6. 模拟输入</h1> 
<p>模拟输入：模拟输入是指传统方式的输入。数字输入是输入PCM数字信号，即0，1的二进制数字信号，通过数模转换，转换成模拟信号，经前级放大进入功率放大器，功率放大器还是模拟的。<br> <img src="https://img-blog.csdnimg.cn/20200813162510670.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"></p> 
<h1><a name="t7"></a><a name="t7"></a><a id="7__68"></a>7. 复用开漏输出、复用推挽输出</h1> 
<p>复用开漏输出、复用推挽输出：可以理解为GPIO口被用作第二功能时的配置情况（即并非作为通用IO口使用）。端口必须配置成复用功能输出模式(推挽或开漏)。<br> 复用开漏输出如下图所示：<br> <img src="https://img-blog.csdnimg.cn/20200813162609644.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"><br> 复用推挽输出如下图所示：<br> <img src="https://img-blog.csdnimg.cn/20200813162648365.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L21haG9vbjQxMQ==,size_16,color_FFFFFF,t_70#pic_center" alt="在这里插入图片描述"></p> 
<h1><a name="t8"></a><a name="t8"></a><a id="8_1_77"></a>8. 总结1：</h1> 
<p>（1） 浮空输入_IN_FLOATING ——浮空输入，可以做KEY识别，RX1<br> （2）带上拉输入_IPU——IO内部上拉电阻输入<br> （3）带下拉输入_IPD—— IO内部下拉电阻输入<br> （4） 模拟输入_AIN ——应用ADC模拟输入，或者低功耗下省电<br> （5）开漏输出_OUT_OD ——IO输出0接GND，IO输出1，悬空，需要外接上拉电阻，才能实现输出高电平。当输出为1时，IO口的状态由上拉电阻拉高电平，但由于是开漏输出模式，这样IO口也就可以由外部电路改变为低电平或不变。可以读IO输入电平变化，实现C51的IO双向功能<br> （6）推挽输出_OUT_PP ——IO输出0-接GND， IO输出1 -接VCC，读输入值是未知的<br> （7）复用功能的推挽输出_AF_PP ——片内外设功能（I2C的SCL,SDA）<br> （8）复用功能的开漏输出_AF_OD——片内外设功能（TX1,MOSI,MISO.SCK.SS）</p> 
<h1><a name="t9"></a><a name="t9"></a><a id="9_2_87"></a>9. 总结2</h1> 
<p>通常有5种方式使用某个引脚功能，它们的配置方式如下：</p> 
<ol><li>作为普通GPIO输入：根据需要配置该引脚为浮空输入、带弱上拉输入或带弱下拉输入，同时不要使能该引脚对应的所有复用功能模块。</li><li>作为普通GPIO输出：根据需要配置该引脚为推挽输出或开漏输出，同时不要使能该引脚对应的所有复用功能模块。</li><li>作为普通模拟输入：配置该引脚为模拟输入模式，同时不要使能该引脚对应的所有复用功能模块。</li><li>作为内置外设的输入：根据需要配置该引脚为浮空输入、带弱上拉输入或带弱下拉输入，同时使能该引脚对应的某个复用功能模块。</li><li>作为内置外设的输出：根据需要配置该引脚为复用推挽输出或复用开漏输出，同时使能该引脚对应的所有复用功能模块。</li></ol> 
<h1><a name="t10"></a><a name="t10"></a><a id="10__95"></a>10. 注意</h1> 
<ol><li>注意如果有多个复用功能模块对应同一个引脚，只能使能其中之一，其它模块保持非使能状态。</li><li>stm32 复位后,IO 端口处于输入浮空状态.</li><li>JTAG 引脚复位以后,处于上拉或者下拉状态</li><li>所有 IO 端口都具有外部中断能力,端口必须配置成输入模式,才能使用外部中断功能</li><li>对于复用功能输入,端口可以配置成任意输入模式或者复用功能输出模式.</li><li>对于复用功能输出,端口必须配置成复用功能输出</li><li>对于双向复用功能,端口必须配置成复用功能输出</li><li>stm32 的部分 IO 端口的复用功能可以重新映射成另外的复用功能.</li><li>stm32 具有GPIO 锁定机制,即锁定 GPIO 配置,下次复位前不能再修改.</li><li>当 LSE 振荡器关闭时,OSC32_IN 和 OSC32_OUT可以用作通用 IO PC14 和 PC15.</li><li>当进入待机模式或者备份域由 Vbat 供电,PC14,PC15 功能丢失,该两个 IO口线设置为模拟输入功能.</li><li>OSC_IN 和 OSC_OUT 可以重新映射为 GPIO PD0,PD1.</li><li>注意 PD0,PD1用于输出地时候仅能用于 50MHz 输出模式.</li><li>注意:PC13,PC14,PC15 只能用于 2MHz 的输出模式,最多只能带30pf 的负载,并且同时只能使用一个引脚</li></ol> 
<h1><a name="t11"></a><a name="t11"></a><a id="11_STM32_111"></a>11. STM32设置实例</h1> 
<ol><li> <p>模拟I2C使用开漏输出_OUT_OD，接上拉电阻，能够正确输出0和1；读值时先GPIO_SetBits(GPIOB, GPIO_Pin_0)；拉高，然后可以读IO的值；使用GPIO_ReadInputDataBit(GPIOB,GPIO_Pin_0)；</p> </li><li> <p>如果是接上拉电阻，IO默认是高电平；需要读取IO的值，可以使用带上拉输入_IPU和浮空输入_IN_FLOATING和开漏输出_OUT_OD；</p> </li></ol> 
<h1><a name="t12"></a><a name="t12"></a><a id="12_GPIO_116"></a>12. 补充：GPIO相关配置寄存器</h1> 
<p>STM32F103ZET6一共有7组IO口，每组IO口有16个IO，每组IO口包含7个寄存器，一共可以控制一组GPIO的16个IO口。</p> 
<ul><li>GPIOx_CRL :端口配置低寄存器</li><li>GPIOx_CRH:端口配置高寄存器</li><li>GPIOx_IDR:端口输入寄存器</li><li>GPIOx_ODR:端口输出寄存器</li><li>GPIOx_BSRR:端口位设置/清除寄存器</li><li>GPIOx_BRR :端口位清除寄存器</li><li>GPIOx_LCKR:端口配置锁存寄存器</li></ul> 
<p>每个I/O端口位可以自由编程，然而I/O端口寄存器必须按32位字被访问(不允许半字或字节访问)</p> 
<h1><a name="t13"></a><a name="t13"></a><a id="13__128"></a>13. 补充：端口复用功能</h1> 
<p>STM32的大部分端口都具有复用功能。<br> 所谓复用，就是一些端口不仅仅可以做为通用IO口，还可以复用为一<br> 些外设引脚，比如PA9,PA10可以复用为STM32的串口1引脚。<br> 作用：最大限度的利用端口资源</p> 
<h1><a name="t14"></a><a name="t14"></a><a id="14__133"></a>14. 端口重映射功能</h1> 
<p>就是可以把某些功能引脚映射到其他引脚。<br> 比如串口1默认引脚是PA9,PA10可以通过配置重映射映<br> 射到PB6,PB7<br> 作用：方便布线</p>
                </div><div data-report-view="{&quot;mod&quot;:&quot;1585297308_001&quot;,&quot;dest&quot;:&quot;https://blog.csdn.net/mahoon411/article/details/107981244&quot;,&quot;extend1&quot;:&quot;pc&quot;,&quot;ab&quot;:&quot;new&quot;}"><div></div></div>
                <link href="https://csdnimg.cn/release/blogv2/dist/mdeditor/css/editerView/markdown_views-10218d227c.css" rel="stylesheet">
                <link href="https://csdnimg.cn/release/blogv2/dist/mdeditor/css/style-6aa8c38f9a.css" rel="stylesheet">
        </div>
    </article>
