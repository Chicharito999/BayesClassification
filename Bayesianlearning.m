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
