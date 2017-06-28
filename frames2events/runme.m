function runme(algorithm, folder)
% example use
% runme(@dhalgo, '/media/datahaki/media/ethz/slowmo/images')

clear dhalgo

files = dir(fullfile(folder, '*.png'));

for c1 = 1:length(files)

uri = fullfile(files(c1).folder, files(c1).name);
img=imread(uri);

img=imresize(img,0.5);

algorithm(img)

end


