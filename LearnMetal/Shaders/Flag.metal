//
//  Flag.metal
//  LearnMetal
//
//  Created by Oleg Alekseev on 05.06.2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 Flag(float2 position, half4 color, float2 size) {
    float2 uv = position / size;

    float step1 = step(0.33, uv.y);
    float step2 = step(0.66, uv.y);

    half4 whiteAndRed = mix(half4(1.0, 1.0, 1.0, 1.0), half4(0.0, 0.0, 1.0, 1.0), step1);
    return mix(whiteAndRed, half4(1.0, 0.0, 0.0, 1.0), step2);
}
