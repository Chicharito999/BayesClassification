# BayesClassification
:point_down::fu:正态概率密度的贝叶斯分类<br>
__________________________________________________________________________________________
Author:赵明福                                        Student ID：201400301087                            E-mail:1109646702@qq.com<br>
## 题目介绍
将上面数据sample中的10个样本点进行分类的问题，假设分布是正态的。
* 假设前面两个类别的先验概率相等(P(ω1)=P(ω2)=1/2，且P(ω3)=0)，仅利用x1特征值为这两类判别设计一个分类器
* 确定样本的经验训练误差，即误分点的百分比
* 现在利用两个特征值x1和x2，重复以上各步
* 利用所有3个特征值重复以上各步
* 讨论所得的结论。特别是，对于一有限的数据集，是否有可能在更高的数据维数下经验误差会增加？
## 题目分析
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片6.png)<br>
## 编程实现及注释
```matlab
u1=mean(w1,1);%计算类别1的样本点均值（3维）
u2=mean(w2,1);%计算类别2的样本点均值（3维）
 
result=zeros(10,2);%存储每个点的分类情况 正确为1否则为0
error_rate=zeros(3, 1);%存储k=1，2，3时判断错误的点的个数
 
for k=1:3%迭代维度1-3
    v1=cov(w1(:,1:k));%k个特征时的类别1的样本的协方差矩阵k×k
    v2=cov(w2(:,1:k));%k个特征时的类别2的样本的协方差矩阵k×k
    for i=1:10
        g1=(-1/2)*((w1(i,1:k)-u1(1,1:k))*(inv(v1))*((w1(i,1:k)-u1(1,1:k)).')+log(det(v1)));%计算w1中各点属于类别1的后验概率
        g2=(-1/2)*((w1(i,1:k)-u2(1,1:k))*(inv(v2))*((w1(i,1:k)-u2(1,1:k)).')+log(det(v2)));%计算w1中各点属于类别2的后验概率
        
        h1=(-1/2)*((w2(i,1:k)-u1(1,1:k))*(inv(v1))*((w2(i,1:k)-u1(1,1:k)).')+log(det(v1)));%计算w2中各点属于类别1的后验概率
        h2=(-1/2)*((w2(i,1:k)-u2(1,1:k))*(inv(v2))*((w2(i,1:k)-u2(1,1:k)).')+log(det(v2)));%计算w2中各点属于类别2的后验概率
        if g1>=g2%比较w1关于每个类别后验概率的大小，与实际分类相同result（i，1）置1否则置零且error_rate(k,1)加一
            result(i,1)=1;
        else
            result(i,1)=0;
            error_rate(k,1)=error_rate(k,1)+1;            
        end
        if h1>=h2%比较w2关于每个类别后验概率的大小，与实际分类相同result（i，2）置1否则置零且error_rate(k,1)加一
            result(i,2)=0;
            error_rate(k,1)=error_rate(k,1)+1;
        else
            result(i,2)=1;
        end
        
    end
    
end
 
plot(1:3, error_rate/20, '-bo');%画出不同k值的错误率曲线
axis([1 3 0 1]);
xlabel('dim');
ylabel('error');
```
其中均值和协方差矩阵分别通过函数mean（）和函数cov（）获得，矩阵result（10，2）第一列代表w1中数据的分类情况与原始分类结果相同置1否则置0，第二列代表w2中数据的分类情况与原始分类结果相同置1否则置0。矩阵error_rate（3，1）中第k行的值代表维度取k时错误分类的点数。
## 结果分析
![](https://github.com/Chicharito999/ImageCache/raw/master/image/图片7.png)<br>
可以看出数据维度为1时，误差率为0.3；数据维度为2时，误差率为0.45；数据维度为3时，误差率为0.15。
对于有限的数据集，更高的数据维度可能会导致计算得到的均值和协方差矩阵存在更大的误差，从而导致更大的分类误差。
 
