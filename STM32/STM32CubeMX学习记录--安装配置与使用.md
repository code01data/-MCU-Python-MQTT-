--- 
categories:  #分类
    - STM32 ARM单片机
    - 嵌入式
    - STM32CubeMX

tags:   #标签
    - STM32 ARM单片机
    - 嵌入式
    - STM32CubeMX
    - ESP8266
---
# STM32CubeMX使用
<!-- more -->
<article class="baidu_pl">
                 <div id="article_content" class="article_content clearfix">
            <link rel="stylesheet" href="https://csdnimg.cn/release/phoenix/template/css/ck_htmledit_views-211130ba7a.css">
                            <div id="content_views" class="markdown_views prism-atom-one-light">
                    <!-- flowchart 箭头图标 勿删 -->
                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                                            <article class="baidu_pl">
                 <div id="article_content" class="article_content clearfix">
</div></div></article><p>&nbsp;1、STM32CubeMX 是 ST 意法半导体近几年来大力推荐的STM32 芯片图形化配置工具，目的就是为了方便开发者， 允许用户使用图形化向导生成C 初始化代码，可以大大减轻开发工作，时间和费用，提高开发效率。STM32CubeMX几乎覆盖了STM32 全系列芯片。&nbsp;</p>
<p>&nbsp;</p>
<p>在CubeMX上，通过傻瓜化的操作便能实现相关配置，最终能够生成C语言代码，支持多种工具链，比如MDK、IAR For ARM、TrueStudio等&nbsp; 省去了我们配置各种外设的时间，大大的节省了时间</p>
<p>&nbsp;</p>
<p><img alt="" class="has" height="299" src="https://img-blog.csdn.net/20161031103050516" width="471"></p>
<p>安装CubeMx一共需要三个</p>
<ul><li>&nbsp;<strong>JRE </strong>（Java Runtime Environment）&nbsp;&nbsp;Java运行环境&nbsp;运行<em>JAVA</em>程序所必须的环境的集合</li>
	<li>&nbsp;<strong>STM32CubeMX</strong></li>
	<li><strong>HAL库&nbsp; &nbsp;</strong>STM32 HAL固件库&nbsp; &nbsp;ST官方推出的另一套库</li>
</ul><h3><a name="t1"></a><a name="t1"></a><a></a><a></a><span><strong>1安装JRE</strong></span></h3>
<p>由于 STM32CubeMX 软件是基于 JAVA 环境运行的，所以需要安装 JRE （Java Runtime Environment）才能使用，&nbsp;</p>
<p>官网：&nbsp;&nbsp;<a href="https://www.java.com/en/download/manual.jsp" rel="nofollow">https://www.java.com/en/download/manual.jsp</a></p>
<p>百度云：<a href="https://pan.baidu.com/s/1WD5E4enEZ_mw0-NGBl_bUw" rel="nofollow">https://pan.baidu.com/s/1WD5E4enEZ_mw0-NGBl_bUw</a> 提取码: e8gs&nbsp; &nbsp; (定时更新最新版本)</p>
<p>&nbsp;</p>
<p>1点击安装</p>
<p><img alt="" class="has" height="297" src="https://img-blog.csdnimg.cn/20190808215245694.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="546"></p>
<p>2 修改路径 点下一步</p>
<p><img alt="" class="has" height="297" src="https://img-blog.csdnimg.cn/2019080821543193.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="547"></p>
<p>3 等待安装完成，关闭界面</p>
<p><img alt="" class="has" height="296" src="https://img-blog.csdnimg.cn/20190808215501606.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="546"></p>
<p>&nbsp;</p>
<h3><a name="t2"></a><a name="t2"></a><a></a><a></a><span>2安装<strong>STM32CubeMX</strong></span></h3>
<p>&nbsp;官网：<a href="http://www.st.com/stm32cubemx" rel="nofollow">www.st.com/stm32cubemx</a></p>
<p>百度云：<a href="https://pan.baidu.com/s/1dm83PbIsq7Vk9bAyFNinag" rel="nofollow">https://pan.baidu.com/s/1dm83PbIsq7Vk9bAyFNinag</a> 提取码: wjmd&nbsp;</p>
<p>&nbsp;</p>
<p>官网下载：</p>
<p><img alt="" class="has" height="302" src="https://img-blog.csdnimg.cn/20190808221316432.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="537"></p>
<p>在官网下载需要注册下ST官网账号,目前最新为5.3.0版本，不想在官网下可以在百度云盘下载，</p>
<p>&nbsp;</p>
<p>1打开安装包&nbsp;</p>
<p><img alt="" class="has" height="400" src="https://img-blog.csdnimg.cn/20190808215815695.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="532"></p>
<p>2同意协议，下一步</p>
<p><img alt="" class="has" height="399" src="https://img-blog.csdnimg.cn/20190808220044650.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="531"></p>
<p>3 勾选第一个即可，第二个选项是是否同意ST公司收集你的个人使用信息等。</p>
<p><img alt="" class="has" height="399" src="https://img-blog.csdnimg.cn/20190808220146434.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="531"></p>
<p>4 点YES&nbsp; 这句话是安装本软件可能会与文件夹之前文件冲突，导致文件夹之前文件丢失 是否继续&nbsp;</p>
<p>点继续即可</p>
<p><img alt="" class="has" height="331" src="https://img-blog.csdnimg.cn/20190808220302910.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="558"></p>
<p>5 直接点NEXT，其他不用设置 之后开始安装</p>
<p><img alt="" class="has" height="426" src="https://img-blog.csdnimg.cn/20190808220742381.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="567"></p>
<p>6 安装完成，点Done退出</p>
<p><img alt="" class="has" height="425" src="https://img-blog.csdnimg.cn/20190808220846664.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="566"></p>
<p>&nbsp;</p>
<h3><a name="t3"></a><a name="t3"></a><a></a><a></a><span><strong>3安装HAL库</strong></span></h3>
<p>什么是HAL固件库？</p>
<p>STM32 HAL固件库是Hardware Abstraction Layer的缩写，中文名称是：硬件抽象层。HAL库是ST公司为STM32的MCU最新推出的抽象层嵌入式软件，为更方便的实现跨STM32产品的最大可移植性。HAL库的推出，可以说ST也慢慢的抛弃了原来的标准固件库，这也使得很多老用户不满。但是HAL库推出的同时，也加入了很多第三方的中间件，有RTOS，USB，TCP / IP和图形等等。</p>
<p>&nbsp;</p>
<p>和标准库对比起来，STM32的HAL库更加的抽象，ST最终的目的是要实现在STM32系列MCU之间无缝移植，甚至在其他MCU也能实现快速移植。</p>
<p>并且从16年开始，ST公司就逐渐停止了对标准固件库的更新，转而倾向于HAL固件库和 Low-layer底层库的更新，停止标准库更新，也就表示了以后使用STM32CubeMX配置HAL/LL库是主流配置环境；</p>
<p>&nbsp;</p>
<p>HAL库，有<strong>在线安装、离线安装</strong>两种方式。</p>
<p>&nbsp;</p>
<h3 id="3-3-1-在线安装"><a name="t4"></a><a name="t4"></a><a></a><a></a>在线安装</h3>
<p>打开安装好的 STM32CubeMX 软件&nbsp; 点上面的Help -&gt; Manage embedded software packages&nbsp;</p>
<p><img alt="" class="has" height="402" src="https://img-blog.csdnimg.cn/20190808222604905.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="714"></p>
<p>会跳出来一个选择型号界面&nbsp;&nbsp; 勾选上你要安装的HAL库， 点击“Install Now” 直到安装成功。 如下图：</p>
<p><img alt="" class="has" height="402" src="https://img-blog.csdnimg.cn/20190808223241593.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="714"></p>
<h3><a name="t5"></a><a name="t5"></a><a></a><a></a>离线安装</h3>
<p>离线安装需要下载安装包，这里提供百度云和ST官方下载方式&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <strong>&nbsp;PS：建议在线安装&nbsp; 速度快，又稳定</strong></p>
<p>官网：<a href="http://www.st.com/stm32cubemx" rel="nofollow">www.st.com/stm32cubemx</a></p>
<p>软件下载旁边一栏就是HAL库下载&nbsp; 下载对应芯片的安装包</p>
<p><img alt="" class="has" height="258" src="https://img-blog.csdnimg.cn/20190808221822509.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="524"></p>
<p>&nbsp;</p>
<p><img alt="" class="has" height="424" src="https://img-blog.csdnimg.cn/20190808221843712.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="542"></p>
<p>&nbsp;</p>
<p>百度云：<a href="https://pan.baidu.com/s/1dm83PbIsq7Vk9bAyFNinag" rel="nofollow">https://pan.baidu.com/s/1dm83PbIsq7Vk9bAyFNinag</a> 提取码: wjmd&nbsp; &nbsp;&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>1直接导入安装包&nbsp; &nbsp;Help -&gt; Manage embedded software packages -&gt;From Local&nbsp; 选择离线包即可</p>
<p><img alt="" class="has" height="372" src="https://img-blog.csdnimg.cn/20190809085042881.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="510"></p>
<p>2直接解压</p>
<p><strong>Help-&gt;Updater Settings...&nbsp; &nbsp; &nbsp;可以选择HAL库安装包路径 </strong>，默认在C盘 可以自行修改</p>
<p><img alt="" class="has" height="402" src="https://img-blog.csdnimg.cn/20190809084531361.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="714"></p>
<p>解压到相对应路径即可</p>
<p><img alt="" class="has" height="361" src="https://img-blog.csdnimg.cn/2019080908584173.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FzNDgwMTMzOTM3,size_16,color_FFFFFF,t_70" width="768"></p>
<p>&nbsp;</p>
<h3><a name="t6"></a><a name="t6"></a><a id="_155"></a>参考资料</h3>
<ol>
<li>转载Z小旋博客<a href="https://blog.csdn.net/as480133937/article/details/98885316">https://blog.csdn.net/as480133937/article/details/98885316</a></li>
<li>STM32CubeMX官网<a href="https://www.st.com/zh/development-tools/stm32cubemx.html" rel="nofollow">https://www.st.com/zh/development-tools/stm32cubemx.html</a></li>
<li>STM32Cube中文社区<a href="http://www.stm32cube.com/" rel="nofollow">http://www.stm32cube.com/</a></li>
<li>微学课堂<a href="http://www.waveshare.net/study/portal.php" rel="nofollow">http://www.waveshare.net/study/portal.php</a></li>
<li>Z小旋博客STM32<a href="https://blog.csdn.net/as480133937/category_9188655.html">https://blog.csdn.net/as480133937/category_9188655.html</a></li>
<li>大佬Mculover666的STM32CubeMX系列教程 <a href="http://www.mculover666.cn/posts/578764034/" rel="nofollow">http://www.mculover666.cn/posts/578764034/</a></li>
<li>个人博客<a href="https://www.delehub.top/" rel="nofollow">https://www.delehub.top/</a></li>
</ol>

