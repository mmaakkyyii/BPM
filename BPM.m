clear

%シミュレーションの座標の範囲とか
x_max=2;
z_max=100;
X=-x_max:0.01:x_max;
Z=0:10:z_max;
Ey=zeros(length(X),length(Z));

%導波路のパラメータとか
wg_w=0.5;

n_Si=3.48;
n_SiO2=1.44;
n=n_SiO2.*ones(length(X),length(Z));

for x=1:length(X)
    if(-wg_w/2<X(x) && X(x)<wg_w/2)
        n(x,:)=n_Si;
    end
end

[meshX,meshZ]=meshgrid(X',Z');
%mesh(meshX,meshZ,n')
bata=0.1;
figure
for z=1:length(Z)
    for x=1:length(X)
        if(-wg_w/2<X(x) && X(x)<wg_w/2)
            Ey(x,z)=cos(X(x)*2);
        else
            Ey(x,z)=exp(-abs(X(x)));
        end
    end
    plot3(X,Z(z).*ones(length(X)),Ey(:,z),'b')
    hold on
end


x1 = wg_w/2; 
x2 = -wg_w/2; 
y1 = z_max; 
y2 = 0; 
z1 = 0.02; 
z2 = 0; 
% x,y,z の最小/最大値を囲む直方体の面と頂点の指定 
v = ... 
[x1,y1,z1; 
x2,y1,z1; 
x1,y2,z1; 
x1,y1,z2; 
x2,y2,z1; 
x1,y2,z2; 
x2,y1,z2; 
x2,y2,z2]; 
f = [ 
1,2,5,3; 
1,3,6,4; 
1,4,7,2; 
4,7,8,6; 
2,5,8,7; 
3,6,8,5]; 
% patch 関数による直方体描画 
p = patch('Faces',f, 'Vertices',v); 
p.FaceColor = [0.5 1 0]; 
p.FaceAlpha = 0.2; 
grid on