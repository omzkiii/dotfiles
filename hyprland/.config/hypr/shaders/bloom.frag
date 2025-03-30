precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;
uniform int bloomRadius;
uniform float bloomIntensity;
uniform float bloomThreshold;

vec4 texture2D_safe(sampler2D sampler, vec2 coord) {
    return texture2D(sampler, clamp(coord, 0.0, 1.0));
}

void main() {
    // Default values if not specified
    int radius = bloomRadius <= 0 ? 10 : bloomRadius;
    float intensity = bloomIntensity <= 0.0 ? 0.7 : bloomIntensity;
    float threshold = bloomThreshold <= 0.0 ? 0.4 : bloomThreshold;

    vec4 color = texture2D(tex, v_texcoord);
    vec4 bloomThreshold4 = vec4(threshold);
    bloomThreshold4.w = 0.0;

    // Manual texture size calculation (GLSL 3.2 compatibility)
    vec2 invTextureSize = vec2(1.0 / 512.0, 1.0 / 512.0);
    
    float invBloomRadius = radius == 0 ? 1.0 : 1.0 / float(radius);
    float invBloomThreshold = 1.0 / (1.0 - threshold);
    float samples = 0.0;
    vec4 colorSum = vec4(0.0);
    
    for (int x = -radius; x <= radius; ++x) {
        for (int y = -radius; y <= radius; ++y) {
            vec2 offset = vec2(float(x), float(y)) * invTextureSize;
            vec2 coords = v_texcoord + offset;
            vec4 sampleColor = texture2D_safe(tex, coords);
            
            // Bloom threshold calculation
            sampleColor = max(sampleColor - threshold, vec4(0.0));
            
            float strength = 1.0 - (length(offset) * invBloomRadius);
            samples += strength;
            
            // Calculate strength based on color intensity
            strength *= max(max(sampleColor.x, sampleColor.y), sampleColor.z) * invBloomThreshold;
            strength *= intensity;
            
            colorSum += sampleColor * strength;
        }
    }
    
    colorSum /= samples;
    gl_FragColor = min(color + colorSum, 1.0);
}
