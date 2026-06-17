//
//  ChannelMix.metal
//  LearnMetal
//
//  Created by Oleg Alekseev on 06.06.2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 ChannelMix(float2 position, half4 color, float2 size) {
    float2 uv = position / size;

    return half4(uv.x, uv.y, uv.x * uv.y, 1.0);
}
