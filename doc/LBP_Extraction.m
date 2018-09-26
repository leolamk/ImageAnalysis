
t = cputime;



function lbpfeature()
conf.calDir = './' ; % calculating directory
conf.dataDir = './images/' ; % data (image) directory 
conf.outDir = './'; % output directory
conf.prefix = 'lbp_' ;
conf.lbpPath = fullfile(conf.outDir, [conf.prefix 'feature.mat']);

imname = dir(strcat(conf.dataDir,'*.jpg'));    
im_num = length(imname);
lbp = zeros(im_num, 59);

for a = 1:length(imname)
    img = imread(fullfile(conf.dataDir,imname(a).name));
    if ndims(img)==3
       I=rgb2gray(img);
    else
       I=img;
    end
    lbp(a,:) = extractLBPFeatures(I);
    sprintf('%s%d','image',a,'completed')
end

e = cputime-t;
save(conf.lbpPath, 'lbp');
csvwrite('./lbp.csv',lbp);
end