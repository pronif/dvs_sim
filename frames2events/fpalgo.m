function events = fpalgo(img, t)
% code by jph and fp
%
%
% IMPORTANT:
% if you would like to modify the algorithm
% please copy the file and make the modifs in the new file.

% saturation buffer
persistent sbuf
persistent tbuf
persistent prev_ins

% magic constant
theta=.8;

if size(img,3)==3
    grey=rgb2gray(img);
else
    grey = img;
end

img=0; % <- discard image
ins=log((double(grey)+1)); % intensity

if isempty(sbuf)
  disp('initialize fpalgo')
  sbuf=ins; % initialize saturation buffer to first image
end

evt0=uint8(grey*0); % events array with positive polarity
evt1=uint8(grey*0); % events array with negative polarity

events = cell(0,1);

% loop through all the pixels
for i=1:size(ins,1)
for j=1:size(ins,2)

while sbuf(i,j)+theta<ins(i,j)
  sbuf(i,j)=sbuf(i,j)+theta;
  %evt0(i,j)=255;
  evt0(i,j)=evt0(i,j) + 64;
  tnew = interp1([prev_ins(i,j) ins(i,j)],[tbuf t], sbuf(i,j));
  events{end+1,1} = [tnew i j 1];
end

while ins(i,j)<sbuf(i,j)-theta
  sbuf(i,j)=sbuf(i,j)-theta;
  evt1(i,j)=255;
  tnew = interp1([prev_ins(i,j) ins(i,j)],[tbuf t], sbuf(i,j));
  events{end+1,1} = [tnew i j 0];
end

end
end

% update the persistent variables
prev_ins = ins;
tbuf = t;

% change events to a matrix ond order them
events = cell2mat(events);
events = sortrows(events);

% visualization
vis=repmat(grey,[1 1 3]);
vis(:,:,1)=vis(:,:,1)+evt1;
vis(:,:,2)=vis(:,:,2)+evt0;

imshow(imresize(vis,2.0))
pause(eps)

