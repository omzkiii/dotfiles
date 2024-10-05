precision mediump float;
varying vec2 v_texcoord;

uniform sampler2D tex;

void main() {
    vec2 tc = vec2(v_texcoord.x, v_texcoord.y);

    // Distance from the center
    float dx = abs(0.5 - tc.x);
    float dy = abs(0.5 - tc.y);

    // Square it to smooth the edges
    dx *= dx;
    dy *= dy;

    tc.x -= 0.5;
    tc.x *= 1.0 + (dy * 0.03);
    tc.x += 0.5;

    tc.y -= 0.5;
    tc.y *= 1.0 + (dx * 0.03);
    tc.y += 0.5;

    // Get texel and add scanline effect
    vec4 cta = texture2D(tex, vec2(tc.x, tc.y));
    cta.rgb += sin(tc.y * 1250.0) * 0.02;

    // Calculate brightness
    float brightness = dot(cta.rgb, vec3(0.299, 0.587, 0.114));

    // Neon glow effect
    vec3 neonColor = vec3(0.0, 1.0, 0.8); // Neon color
    float glowFactor = smoothstep(0.5, 1.0, brightness); // Adjust threshold as needed

    // Create glow effect
    vec4 glow = vec4(0.0);
    if (glowFactor > 0.0) {
        // Sample neighboring pixels to create a simple glow effect
        glow += texture2D(tex, tc + vec2(0.005, 0.0)); // Right
        glow += texture2D(tex, tc + vec2(-0.005, 0.0)); // Left
        glow += texture2D(tex, tc + vec2(0.0, 0.005)); // Up
        glow += texture2D(tex, tc + vec2(0.0, -0.005)); // Down
        glow *= 0.25; // Average the sampled colors
    }

    // Mix original color with glow
    cta.rgb = mix(cta.rgb, glowColor, glowFactor * 0.8) + glow * 0.2; // Increase the glow intensity

    // Cutoff for out-of-bound areas
    if (tc.y > 1.0 || tc.x < 0.0 || tc.x > 1.0 || tc.y < 0.0)
        cta = vec4(0.0);

    // Apply final color
    gl_FragColor = cta;
}
