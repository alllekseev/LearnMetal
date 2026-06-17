//
//  Chess.metal
//  LearnMetal
//
//  Created by Oleg Alekseev on 06.06.2026.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 ChessBoard(float2 position, half4 color, float2 size) {
    float2 uv = position / size * 8.0;

    half4 black = half4(0.0, 0.0, 0.0, 1.0);
    half4 white = half4(1.0, 1.0, 1.0, 1.0);

    float boardPosition = floor(uv.x) + floor(uv.y);

    return mix(black, white, fmod(boardPosition, 2));
}
