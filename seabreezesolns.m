function [u,v,n,Txx,Tyy]=seabreezesolns(g,H,H1,R,alpha,Tx,Ty,t,x)
% Sea Breeze solutions

omega=2*pi*1/86400;  % rad/s
f=2*2*pi*sind(37)/86400; % rad/s



sig=R/omega;
fterm=1+i*sig;
k=sqrt( (omega^2*fterm-f^2/fterm)/(g*H) );

fprintf('Offshore decay scale 1/Im(k) = %.1f km, 1/Re(k)=%.f \n',1/imag(k)/1e3,1/real(k)/1e3);


Txx=real( Tx*exp(-alpha*x - i *omega*t) );
Tyy=real( Ty*exp(-alpha*x - i *omega*t) );


A=[ -i*omega*fterm-g*alpha*i*H*alpha/omega   -f ;
      f                                   -i*omega*fterm];


UU=A\[Tx;Ty];
Up=UU(1);
Vp=UU(2);
Np=i*H*alpha/omega*Up;

U=-Up;
V=f*U/(i*omega*fterm);
N=k * H * U / omega;

u=real( Up*exp(-alpha*x - i*omega*t) + U*exp(i*k*x - i*omega*t) );
v=real( Vp*exp(-alpha*x - i*omega*t) + V*exp(i*k*x - i*omega*t) );
n=real( Np*exp(-alpha*x - i*omega*t) + N*exp(i*k*x - i*omega*t) );


% Check values - final soln from paper.
A=[ -i*omega*fterm       f ;
      -f        -i*omega*(fterm + g*H*alpha^2/omega^2)];

beta=-g*H*(alpha^2+k^2)*fterm;
UU=A*[Tx;Ty]/beta;
Up=UU(1);
Vp=UU(2);
Np=H*alpha/(-i*omega)*Up;

uf=real( Up*(exp(-alpha*x) - exp(i*k*x)).*exp(-i*omega*t) );
vf=real( Vp*(exp(-alpha*x) - f*Up/((i*omega-R)*Vp)*exp(i*k*x)).*exp(-i*omega*t) );
nf=real( i*H*Up/omega*( alpha*exp(-alpha*x)+i*k*exp(i*k*x) ).*exp(-i*omega*t) );

if any(abs(uf(:)-u(:))>1e-10) || any(abs(vf(:)-v(:))>1e-10) || any(abs(nf(:)-n(:))>1e-10)
    error('Solutions don''t match!!!');
end
