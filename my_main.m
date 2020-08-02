clear all; close all; clc;    
%% ԭʼ�ź�������ͻ�������
Fs = 1000;                % ����Ƶ��1000Hz
Ts = 1 / Fs;              % ����ʱ����1ms
L = 1000;                 % ��������1000
t = (0 : L - 1) * Ts;     % ����ʱ�䡣1000���㣬ÿ����1ms���൱�ڲɼ���1s
x = sin(2 * pi * 10 * t); % ԭʼ�����źţ�Ƶ��Ϊ10Hz
% x = x + 0.1 .* randn(1,1000); % �������
x(233) = x(233) + 0.5;    % ���ͻ���
x(666) = x(666) + 0.1;

figure(1); 
plot(x)
xlabel('��������(1ms/��)');ylabel('��ֵ'); 
title('ͻ���ź�');       

%% ����Ҷ�任�۲�ͻ���ź�Ƶ��
Y = fft(x,1024); % ���źŽ��и���Ҷ�任
f = Fs * (0 : (L / 2)) / L;
P2 = abs(Y / L);
P1 = P2(1 : L / 2 + 1);
figure(2)
plot(f,P1) 
title('ͻ���źŵĵ��߷���Ƶ��')
xlabel('f(Hz)')
ylabel('|P1(f)|')
axis([0,100,0,0.5])

%% ����С���任(CWT)
figure(3)
cw1 = cwt(x,1:32,'sym2','plot'); % ���ź�������С���任��������ϵ��ͼ��
title('����С���任ϵ��ͼ');


%% ��ɢС���任(DWT) Wallat�㷨
%��һ��ֱ����wavedec()����3��ֽ⣬���ع����ɽ���ϵ����ϸ��ϵ��
[d,a]=wavedec(x,3,'db4');           %��ԭʼ�źŽ���3����ɢС���ֽ�
a3=wrcoef('a',d,a,'db4',3);         %�ع���3�����ϵ��
d3=wrcoef('d',d,a,'db4',3);         %�ع���3��ϸ��ϵ��  
d2=wrcoef('d',d,a,'db4',2);         %�ع���2��ϸ��ϵ��  
d1=wrcoef('d',d,a,'db4',1);         %�ع���1��ϸ��ϵ��  

figure(4); 
subplot(411);plot(a3);ylabel('�����ź�a3');   %��������С��ϵ��
title('С���ֽ�ʾ��ͼ(����һ)');
subplot(412);plot(d3);ylabel('ϸ���ź�d3');
subplot(413);plot(d2);ylabel('ϸ���ź�d2');
subplot(414);plot(d1);ylabel('ϸ���ź�d1');
xlabel('ʱ��'); 

%% ��ɢС���任(DWT) Wallat�㷨
% ��������dwt()һ��һ��ֽ����ɽ���ϵ����ϸ��ϵ��
[ca11,cd1] = dwt(x,'db4');      % ��1��ֽ�
[ca22,cd2] = dwt(ca11,'db4');   % ��2��ֽ�
[ca3,cd3] = dwt(ca22,'db4');    % ��3��ֽ�

figure(5)
subplot(511);plot(x);    % ��������С��ϵ����ע�����ں����Դ��²���������ÿ��ϵ�����Ȼ����
title('ԭʼ�ź�x');            
subplot(512);plot(ca3);         
title('����ϵ��ca3');
subplot(513);plot(cd3);
title('ϸ��ϵ��cd3');
subplot(514);plot(cd2);
title('ϸ��ϵ��cd2');
subplot(515);plot(cd1);
title('ϸ��ϵ��cd1');
xlabel('ʱ��'); 

% Ϊ���뷨һ���Աȣ���ϵ�����ϲ�����1000�㣬��figure(4)ͼ��Ƚ�
cd_1 = dyadup(cd1);         % �ϲ�����1000����
cd_2 = dyadup(dyadup(cd2)); % �ϲ�����1000����
cd_3 = dyadup(dyadup(dyadup(cd3))); % �ϲ�����1000����
ca_3 = dyadup(dyadup(dyadup(ca3))); % �ϲ�����1000����

figure(6)
subplot(411);plot(ca_3);ylabel('�����ź�a3');   %��������С��ϵ��
title('С���ֽ�ʾ��ͼ(������)');
axis([0 1000 -2 2]);
subplot(412);plot(cd_3);ylabel('ϸ���ź�d3');
axis([0 1000 -0.1 0.1]);
subplot(413);plot(cd_2);ylabel('ϸ���ź�d2');
axis([0 1000 -0.2 0.2]);
subplot(414);plot(cd_1);ylabel('ϸ���ź�d1');
axis([0 1000 -0.5 0.5]);
xlabel('ʱ��'); 