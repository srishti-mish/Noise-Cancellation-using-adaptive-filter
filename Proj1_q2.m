filter_order =2;
step_sizeA=zeros(1,25);
step_sizeB=[0.001,0.02,0.1];
[dimx dimy] = size(reference);
%step_sizeB=[0.001,0.02,0.1];
filter_orderB=3;
theta = zeros(filter_order,1);
theta_tracks=zeros(dimy-filter_order,filter_order);
c=1;
for i=0.002:(0.04-0.002)/9:0.04
    step_sizeA(c)=i;
    c=c+1;
end
error_square = zeros(10,dimy-filter_order);
for k=1:10
    step_size = step_sizeA(k);
    [trainX,trainY]= data_gen(primary,reference, filter_order);
    vecX = zeros(filter_order,1);
    for i = 1:dimy-filter_order
        vecX(:,1) = trainX(i,:);
        vecX=fliplr(vecX);
        vecY = trainY(i);
        theta = theta+step_size*(vecY-transpose(vecX)*theta(:,1))*vecX/(vecX'*vecX);
        %theta_tracks(i,:)=theta;
        %error_square(k,i)=transpose(trainY-trainX*theta)*(trainY-trainX*theta)/dimy;
    end
end