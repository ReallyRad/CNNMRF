require 'torch'
require 'nn'
require 'image'
require 'paths'

paths.dofile('mylib/myoptimizer.lua')
paths.dofile('mylib/tv.lua')
paths.dofile('mylib/style.lua')
paths.dofile('mylib/content.lua')
paths.dofile('mylib/mrf.lua')

transfer_CNNMRF_wrapper = require 'transfer_CNNMRF_wrapper'

-- list of parameters:
-- content_name: the content image located in folder "data/content"
-- style_name: the style image located in folder "data/style" 
-- ini_method: initial method, set to "image" to use the content image as the initialization; set to "random" to use random noise. 
-- num_iter: number of iterations for each resolution. In our paper we use four resolutions.
-- mrf_layers: the layer for MRF constraint. Usualy layer 21 alone already gives decent results. Including layer 12 may improves the results but at significantly more computational cost.
-- mrf_patch_size: the patch size for MRF constraint. By default set to 5. 
-- mrf_num_rotation: To matching objects of different poses, we use a number of rotational copies of the style image. The total number of rotatoin is "2 * mrf_num_rotation + 1"
-- mrf_num_scale: To matching objects of different scales, we use a number of scaled copies of the style image. The total number of scaling is "2 * mrf_num_scale + 1"
-- content_weight: The weight for content constraint. Increasing this value will make the result more content faithful. Decreasing the value will make the method more style faithful. Notice this value should be increase (for example, doubled) if layer 12 is included for MRF constraint,  
local list_params = { 
                    {'0', '0', 'image', {400, 400, 400, 200}, {21}, {3}, 3, 3, 2e0},
                    {'1', '1', 'image', {400, 400, 400, 200}, {21}, {3}, 3, 3, 2e0},                     
					{'potrait1', 'picasso', 'image', {400, 400, 400, 200}, {12, 21}, {3, 3}, 1, 1, 1e1} -- interpolation: balanced
                    -- {'potrait1', 'picasso', 'image', {400, 400, 400, 200}, {12, 21}, {3, 3}, 1, 1, 2e1} -- interpolation: strong content
                    -- {'potrait1', 'picasso', 'image', {400, 400, 400, 200}, {12, 21}, {3, 3}, 1, 1, 7e0} -- interpolation: more style
                    }    

for i_test = 1, #list_params do
    local state = transfer_CNNMRF_wrapper.state(list_params[i_test][1], list_params[i_test][2], list_params[i_test][3], list_params[i_test][4], list_params[i_test][5], list_params[i_test][6], list_params[i_test][7], list_params[i_test][8], list_params[i_test][9])
end


do return end
