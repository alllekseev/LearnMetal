//
//  CircularGradient.metal
//  LearnMetal
//
//  Created by Oleg Alekseev on 06.06.2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 CircularGradient(float2 position, half4 color, float2 size) {
    float2 uv = position / size;

    float dist = length(uv - float2(0.5, 0.5));
    float maxDist = length(float2(0.5, 0.5));
    float normalizeDist = dist / maxDist;

    float brightness = clamp(1.0 - normalizeDist, 0.0, 1.0);

    return half4(brightness, brightness, brightness, 1.0);
}
