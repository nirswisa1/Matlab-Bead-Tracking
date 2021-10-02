filename = 'beads_movie_updated.avi' ;
vid_in = VideoReader(filename);
load('ex.mat');

vid_out = VideoWriter('bead_out','MPEG-4') ;
vid_out.FrameRate = 30;   % Default 30
vid_out.Quality   = 75;   % Default 75
open(vid_out) ;

max_frame=max(xyt(:,3));

frame_counter=0;
figure
while vid_in.hasFrame&&(frame_counter<max_frame)
    cla
    frame_counter = frame_counter + 1;
    im = vid_in.readFrame ;
    imshow(im)
    hold on
    
    % option 1 - if 
    if frame_counter<=75
        start_trail=1;
    else
        start_trail=frame_counter-75;
    end
    % option 2 - max
    start_trail=max([1,frame_counter-75]);
    
    plot(xyt(start_trail:frame_counter,1),xyt(start_trail:frame_counter,2))
    
    plot(xyt(frame_counter,1),xyt(frame_counter,2),'O','MarkerSize',30)

    
    title( sprintf('Frame No. %d',frame_counter) ) ; 
    drawnow
    fr = getframe();
    writeVideo(vid_out,fr);
end
close(vid_out) ;