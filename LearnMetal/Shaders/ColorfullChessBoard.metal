//
//  Lines.metal
//  LearnMetal
//
//  Created by Oleg Alekseev on 06.06.2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 ColorfullChessBoard(float2 position, half4 color, float2 size) {
    float2 uv = position / size * 8.0;

    float isEven = fmod(floor(uv.x) + floor(uv.y), 2);

    half4 lavand = half4(204.0/255.0, 204.0/255.0, 255.0/255.0, 1.0); /*181, 126, 220*/
    half4 mandarin = half4(243.0/255.0, 122.0/255.0, 72.0/255.0, 1.0); /*243, 122, 72*/

    return mix(lavand, mandarin, isEven);
}
