//
//  ShaderRectangle.metal
//  LearnMetal
//
//  Created by Oleg Alekseev on 08.06.2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 ShaderRectange(float2 position, half4 color, float2 size, float2 rectangleSize) {
    float2 centered = position - size * 2.0;
    float2 halfSize = size / 2;
    float2 d = abs(centered) - halfSize;

//    float sdf = length(max(d, 0)) - rectangleSize;

    half4 lavand = half4(204.0/255.0, 204.0/255.0, 255.0/255.0, 1.0);
    half4 mandarin = half4(243.0/255.0, 122.0/255.0, 72.0/255.0, 1.0);

//    half4 mask = (1.0, -1.0, sdf);

//    return smoothstep(lavand, mandarin, <#half4 x#>)
}
