vec3 palette(float t) {
    vec3 a = vec3(1, 1, 2);
    vec3 b = vec3(2, 0.2, 5);
    vec3 c = vec3(2, 0.2, 0.3);
    vec3 d = vec3(5, 3, 2);
    return a + b * cos(6.28318 * (c * t + d));
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from -1 to 1)
    // vec2 uv = fragCoord/iResolution.xy;
    // uv.x *= iResolution.x / iResolution.y;
    // uv = uv - 0.5;
    // uv = uv * 2.0;
    
    // Simplify
    vec2 uv = (fragCoord * 2.0 - iResolution.xy)/iResolution.y;
    vec2 uv_g = uv;
    vec3 finCol = vec3(0.);
    
    for (float i = 0.; i < 4.0; i++) {
        uv = fract(uv * 1.2) - 0.5;
    
        float d = length(uv) * exp(-length(uv_g));

        // Distance function
        // d -= 0.5;
        d = cos(d * 8. + iTime) / 8.;
        d = abs(d);

        // d = step(0.1, d);
        // d = smoothstep(0.0, 0.2, d);
        d = 0.02 / d;
        
        // increase contrast
        d = pow(.1 / d, .8);

        // Time varying pixel color
        // vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));

        // Output to screen
        // fragColor = vec4(col,1.0);

        // vec3 col = vec3(0.5, 0.8, 1.4);
        vec3 col = palette(length(uv_g) + i * .8 + iTime * .4);
        finCol = col * d;
    }
    
    fragColor = vec4(finCol,.5);
}