% Script responsible for applying "boomerang" effect in a video
% Algorithm order
% While extracting video frames
% Allocate frames according to  its forward and backward position
% For instance: totalFrames = 10
% For the first frame, we are going to save the frame in position(1) and position(

% Settings
numOfRepetitions = 4; % Number of times which the video will loop

% create video object
videoObj = VideoReader('smallDemo.mp4');

% creating matlab video structure
videoStructure = struct('cdata',zeros(videoObj.Height,videoObj.Width,3,'uint8'), 'originalFrameID', 0);

% original video total number of frames
originalTotalFrame =round (videoObj.FrameRate * videoObj.Duration) -1;

% populating video structure variable with video data
frame = 1;
while hasFrame(videoObj)
   
    % extract frame data
    frameData = readFrame(videoObj);
  
    % add frame data to movie structure in normal order
    videoStructure(frame).cdata = frameData;
    videoStructure(frame).originalFrameID = frame;

    % add frame data to movie structure in reverse order
    videoStructure(2*originalTotalFrame - frame).cdata =  frameData;
    videoStructure(2*originalTotalFrame - frame).originalFrameID = frame

    % update frame
    frame = frame + 1;
end

% stack frames according to number of repetitions
videoStructure = repmat(videoStructure(1, :),  [1 numOfRepetitions]);

% Calculate the number of frames of our new video
totalFrames = size(videoStructure,2);


% Creating video file
vw = VideoWriter('boomerang');
vw.FrameRate = 120;
vm.VideoFormat = 'mp4'
open(vw);

% Show each frame and force repaint the canvas
for i = 1:totalFrames    
       writeVideo(vw, videoStructure(i).cdata);
end
close(vw);