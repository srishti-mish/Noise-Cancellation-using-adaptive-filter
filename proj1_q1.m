filter_order =2;
step_sizeA=zeros(1,10);
step_sizeB=[0.0003,0.001,0.02,0.1];
[dimx dimy] = size(primary);
%step_sizeB=[0.001,0.02,0.1];
%filter_orderB=3;
theta = zeros(filter_order,1);
theta_tracks=[dimy-filter_order,filter_order];
c=1;
for i=0.0003:(0.06-0.0003)/9:0.06
    step_sizeA(c)=i;
    c=c+1;
end
error_square = zeros(1,10);
for k=1:10
    step_size = step_sizeA(k);
    [trainX,trainY]= data_gen(primary,reference, filter_order);
    vecX = zeros(filter_order,1);
    for i = 1:dimy-filter_order
        vecX(:,1) = trainX(i,:);
        vecX=fliplr(vecX);
        vecY = trainY(i);
        theta = theta+step_size*(vecY-vecX'*theta(:,1))*vecX;
        theta_tracks(i,:)=theta;
        %error_square(k,i)=transpose(trainY-trainX*theta)*(trainY-trainX*theta)/dimy;
    end
    transpose(trainY-trainX*transpose(theta_tracks(69998,:)))*(trainY-trainX*transpose(theta_tracks(69998,:)))/dimy;
    plot(theta_tracks(:,1),theta_tracks(:,2));
xlabel('w0');
ylabel('w1');
hold;
w_1=0;
w_2=0;
c=1;
for i=min(theta_tracks(:,1)):(max(theta_tracks(:,1))-min(theta_tracks(:,1)))/99:max(theta_tracks(:,1))
    w_1(c)=i;
    k=1;
    for j=min(theta_tracks(:,2)):(max(theta_tracks(:,2))-min(theta_tracks(:,2)))/100:max(theta_tracks(:,2))
        w_2(k)=j;
        err(c,k)=transpose(trainY-trainX*transpose([i j]))*(trainY-trainX*transpose([i j]))/dimy;
        k=k+1;
    end
    c=c+1;
end
contour(w_1,w_2,transpose(err),'ShowText','on');
hold;
yprocessed=trainX*transpose(theta_tracks(69998,:));
    %trained_data=trainY-trainX*theta;
end