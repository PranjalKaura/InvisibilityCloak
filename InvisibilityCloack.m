videofile = "video7.mp4";
flagInitialFrame = 0;
imageInitial = [];
video = VideoWriter('newfile.avi');
open(video);
MOV = VideoReader(videofile);
nFrames = MOV.Duration*MOV.FrameRate - 1;
for i = 1:nFrames
    img = readFrame(MOV);
    
    if(~flagInitialFrame)
        imageInitial = img;
        flagInitialFrame = 1;
    else
        red = img(:, :, 1);
        green = img(:, :, 2);
        blue = img(:, :, 3);
        Cloack = img(:, :, 1) + img(:, :, 2) < 0.5*img(:, :, 3);

        img(Cloack(:, :, [1, 1, 1])) = imageInitial(Cloack(:, :, [1, 1, 1]));
        
    end

    image(img);
    writeVideo(video,img)
    pause(0.001);
end
close(video)
