function dhalgo(img)
% code by jph
%
% shortcomings of algorithm:
% - only 1 event between 2 frames (per pixel)
% - no interpolation of time of event
%
% IMPORTANT:
% if you would like to modify the algorithm
% please copy the file and make the modifs in the new file.

% saturation buffer
persistent sbuf

% magic constant
theta=.18;

gry=rgb2gray(img); % [uint8]
img=[]; % <- discard image
ins=log(double(gry)+1); % intensity on a logarithmic scale

if isempty(sbuf)
  disp('initialize dhalgo')
  sbuf=ins; % initialize saturation buffer to first image
end

evt0=gry*0; % events array with positive polarity [uint8]
evt1= evt0; % events array with negative polarity [uint8]

% loop through all the pixels
for i=1:size(ins,1)
for j=1:size(ins,2)

while sbuf(i,j)+theta<ins(i,j)
  sbuf(i,j)=sbuf(i,j)+theta;
  evt0(i,j)=255;
end

while ins(i,j)<sbuf(i,j)-theta
  sbuf(i,j)=sbuf(i,j)-theta;
  evt1(i,j)=255;
end

end
end

% visualization
vis=repmat(gry,[1 1 3]);
vis(:,:,1)=vis(:,:,1)+evt1; % red
vis(:,:,2)=vis(:,:,2)+evt0; % green

imshow(imresize(vis,2))
pause(eps)

