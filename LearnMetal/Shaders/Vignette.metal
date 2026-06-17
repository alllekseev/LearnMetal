//
//  Vignette.metal
//  LearnMetal
//
//  Created by Oleg Alekseev on 06.06.2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 Vignette(float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float2 center = float2(0.5, 0.5);

    float dist = length(uv - center);
    float maxDist = length(center);
//    float maxDist = 0.5;
    float normalizeDist = dist / maxDist;

    float vignette = 1.0 - normalizeDist;
//    float vignette = clamp(1.0 - normalizeDist, 0.0, 1.0);
    float red = vignette;
    float green = uv.x * vignette;
    float blue = uv.y * vignette;

    return half4(red, green, blue, 1.0);
}
