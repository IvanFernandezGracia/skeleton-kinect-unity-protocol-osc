clc; clear all ; close all
% INICIALIZACION DE KINECT, CAMARA RGB Y SENSOR DE DISTANCIA
imaqreset;
depthVid= videoinput('kinect',2);
triggerconfig (depthVid, 'manual');
depthVid.FramesPerTrigger=1;
depthVid.TriggerRepeat=inf;
set(getselectedsource(depthVid),'TrackingMode','Skeleton');
viewer=vision.DeployableVideoPlayer();
start(depthVid);
himg=figure;
pause(5)
% SELECCIONAR PUNTOS SELECCIONADOS Y LOS DIBUJA
while ishandle(himg)
    %tic
    trigger(depthVid);
    [depthMap,~,depthMetaData]=getdata(depthVid);
    %[imgColor, ts_color, metaData_Color] = getdata(vid2);
    %imshow(depthMap,[0 4096]);
    %imshow(vid2)
    %size(depthMetaData)
    if sum(depthMetaData.IsSkeletonTracked)>0
        skeletonJoints = depthMetaData.JointDepthIndices(:,:,depthMetaData.IsSkeletonTracked);
        %hold on;
        %plot(skeletonJoints(:,1), skeletonJoints(:,2),'*');
        %for ii=1:20
        %    t(ii)=depthMap(skeletonJoints(ii,1), skeletonJoints(ii,2))
        %end 
        %plot3(t,skeletonJoints(:,1), skeletonJoints(:,2),'*');
        %cont=0;
    
        % SELECCIONA PUNTOS DEL ESQUELETO DENTRO DE 640X480
        iii=0;
        for ii=1:20
            n=skeletonJoints(ii,1);
            m=skeletonJoints(ii,2);
            if (((n<=0)||(m<=0))||((n>640)||(m>480)))
                %cont=1
                %print ('algo malo punto')
                %pause(1)
            else
                %cont=2            
                iii=iii+1;
                nn(iii)=skeletonJoints(ii,1);
                mm(iii)=(skeletonJoints(ii,2));   
                mmm(iii)=floor(-(skeletonJoints(ii,2))+481) ;
                t(iii)=depthMap(mm(iii),nn(iii));
            end     
        end
        
        %iii=iii
        %plot(nn, mm,'*');
        %i=skeletonJoints(:,1)
        %u=skeletonJoints(:,2)
        %i=nn;
        %u=mm; %(mm*-1)+640
        %if (cont==0)
        
        %DA VUELTA LA IMAGEN O PUNTOS
        cont=0
        for ii=1:iii
            if ((abs(t(3)-t(ii)))<1000)
               cont=cont+1
               nnx(cont)=nn(ii);
               mmx(cont)=mm(ii);   
               mmmx(cont)=mmm(ii) ;        
               tx(cont)=depthMap(mmx(ii),nnx(ii));
            end
        end
        
        % DIBUJAR PUNTOS DE DISTANCIA SELECCIONADOS
        plot3(tx,nnx,mmmx,'*');
        hold on 
        plot3(t(3),nn(3),mmm(3),'r*');
        hold off
        axis([0,4096,0,640,0,480]);
        % axis([0,640,0,480]);
        %pause(0.5)
        %end
        %plot(skeletonJoints(:,1), skeletonJoints(:,2),'*');
        %print ();
        %b=skeletonJoints(1,1)
        %a=skeletonJoints(1,2)
        %c=depthMap(skeletonJoints(1,1), skeletonJoints(1,2))
        grid on 
        %hold off;
    end 
    %toc
end 



