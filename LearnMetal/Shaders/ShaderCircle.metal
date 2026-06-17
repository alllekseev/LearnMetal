//
//  Circle.metal
//  LearnMetal
//
//  Created by Oleg Alekseev on 06.06.2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 ShaderCircle(float2 position, half4 color, float2 size, float diameter) {

    float2 centered = position - size / 2.0;

    float radius = diameter / 2.0;
    float sdf = length(centered) - radius;

    float mask = smoothstep(-1.0, 1.0, sdf);

    return mask;
}
