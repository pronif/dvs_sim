function fprunme(algorithm, folder)
% example use
% fprunme(@fpalgo, '/Users/federicoproni/Desktop/media/bird_short')

clear fpalgo

delete 'events.csv'

files = dir(fullfile(folder, '*.png'));

% time of the initial image
t = 0;
% image period
delta_t = 0.05;

for c1 = 1:length(files)

uri = fullfile(files(c1).folder, files(c1).name);
img=imread(uri);

img=imresize(img,1.5);

events = algorithm(img, t);

dlmwrite('events.csv', events, '-append')

t = t + delta_t;

end


