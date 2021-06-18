clc; clear all; close all;
imaqreset;
imaqhwinfo

thetaLeft = 0
depthVid = videoinput('kinect',2)

triggerconfig(depthVid,'manual');
depthVid.FramesPerTrigger = 1;
depthVid.TriggerRepeat = inf;
set(getselectedsource(depthVid),'TrackingMode','Skeleton');

CameraElevationAngle = 0
viewer= vision.DeployableVideoPlayer();

start(depthVid);
himg = figure;
            
while ishandle(himg)
    
    trigger(depthVid);
    [depthMap,~, depthMetaData] = getdata(depthVid);  
    imshow(depthMap, [0 4096]);
    
    if sum(depthMetaData.IsSkeletonTracked) > 0
        skeletonJoints = depthMetaData.JointDepthIndices(:,:,depthMetaData.IsSkeletonTracked);
        ShoulderL = ((depthMetaData.JointWorldCoordinates(5,1:2,depthMetaData.IsSkeletonTracked))-(depthMetaData.JointWorldCoordinates(6,1:2,depthMetaData.IsSkeletonTracked)))
        WristL = ((depthMetaData.JointWorldCoordinates(7,1:2,depthMetaData.IsSkeletonTracked))-(depthMetaData.JointWorldCoordinates(6,1:2,depthMetaData.IsSkeletonTracked)))
        ShoulderModL = norm(ShoulderL)
        WristModL = norm(WristL)
        DotprodL = dot(ShoulderL,WristL)
        thetaLeft = acosd(DotprodL/(ShoulderModL*WristModL))
        
        ShoulderR = ((depthMetaData.JointWorldCoordinates(9,1:2,depthMetaData.IsSkeletonTracked))-(depthMetaData.JointWorldCoordinates(10,1:2,depthMetaData.IsSkeletonTracked)))
        WristR = ((depthMetaData.JointWorldCoordinates(11,1:2,depthMetaData.IsSkeletonTracked))-(depthMetaData.JointWorldCoordinates(10,1:2,depthMetaData.IsSkeletonTracked)))
        ShoulderModR = norm(ShoulderR)
        WristModR = norm(WristR)
        DotprodR = dot(ShoulderR,WristR)
        thetaRight = acosd(DotprodR/(ShoulderModR*WristModR))     
        
        hold on;
        plot(skeletonJoints(:,1), skeletonJoints(:,2),'*');
        hold off
        while thetaLeft == 0
            htext = text(300,50,'Please Stand in Position')
            if(thetaLeft < 120 || thetaRight < 120)
                delete(htext);
            end
        end
    end
     
end
stop(depthVid)