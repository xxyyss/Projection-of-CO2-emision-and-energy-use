clear

%A = xlsread('CO2_emission.xlsx','B164:BD164');
%to get data of CO2 emission
% = xlsread('CO2_emission.xlsx','B2:BD2');
B = xlsread('CO2_emission.xlsx','B3:BD3');
C = xlsread('CO2_emission.xlsx','B4:BD4');


%B = xlsread('CO2_total_filted_excel.xlsx','B186:BD186');
%prediction(A)
global X1;
global X2;
global X3;
global X4;
prediction(B)
predict(C)
n=length(B)
t1=1961:1960+n;
t2=1961:1960+n+36;
plot(t1,X1,'ro-');%Original value for OECD
hold on;
plot(t2,X3,'r--');%predicted value for OECD
hold on;
plot(t1,X2,'bo-');%Original value for non-OECD
hold on;
plot(t2,X4,'b--');%predicted value for non-OECD

title('CO2 emission prediction');
legend('OECD-Original Value','OECD-Predicted value','non-OECD-Original Value','non-OECD-Predicted value');

function t1 = prediction(A)
    syms a u;
    c=[a,u]';% establish a matrix
    
    Ago=cumsum(A);
    n=length(A);% the number of original data
    for k=1:(n-1)
        Z(k)=(Ago(k)+Ago(k+1))/2; %Z(i)is the xi(1)µÄ
    end
    Yn =A;%The vector of constant
    Yn(1)=[]; %start from second number£¬which isx(2),x(3)...
    Yn=Yn';
    E=[-Z;ones(1,n-1)]';
    c=(E'*E)\(E'*Yn);%
    c= c';
    a=c(1);%get a
    u=c(2);%get u
    F=[];
    F(1)=A(1);
    for k=2:(n+36)
        F(k)=(A(1)-u/a)/exp(a*(k-1))+u/a;%get the equation of GM(1,1)model
    end
    G=[];
    G(1)=A(1);
    for k=2:(n+36)
        G(k)=F(k)-F(k-1);% get the prediction value
    end
    t1=1971:1970+n;
    t2=1971:1970+n+36;
    global X1;
    X1 = A;
    
    global X3;
    X3 = G;
    
    
    
    
    
    
end

% do it again
function t1 = predict(A)
    syms a u;
    c=[a,u]';
    Ago=cumsum(A);
    n=length(A);
    for k=1:(n-1)
        Z(k)=(Ago(k)+Ago(k+1))/2; 
    end
    Yn =A;
    Yn(1)=[]; 
    Yn=Yn';
    E=[-Z;ones(1,n-1)]';
    c=(E'*E)\(E'*Yn);
    c= c';
    a=c(1);
    u=c(2);
    F=[];
    F(1)=A(1);
    for k=2:(n+36)
        F(k)=(A(1)-u/a)/exp(a*(k-1))+u/a;
    end
    G=[];
    G(1)=A(1);
    for k=2:(n+36)
        G(k)=F(k)-F(k-1);
    end

    global X2;
    X2 = A;
    global X4;
    X4 = G;
    
    
    
    
    
    
end
