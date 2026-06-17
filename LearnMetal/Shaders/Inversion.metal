//
//  Inversion.metal
//  LearnMetal
//
//  Created by Oleg Alekseev on 06.06.2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 Inversion(float2 position, half4 color, float2 size) {
    float2 uv = position / size;
    float isInvertion = step(0.5, uv.x);
    float brightness = uv.x;
    half4 gradient = half4(brightness, brightness, brightness, 1.0);
    half4 gradientInversion = half4(1.0 - brightness, 1.0 - brightness, 1.0 - brightness, 1.0);
    return mix(gradient, gradientInversion, isInvertion);
}
