//# GouraudVertex
uniform float uSpecularIntensity;
uniform float uShininess;
	
varying vec3 vLight;
varying vec2 vTextureCoord;

void main(void) {
	vec4 p = mvMatrix() * vec4(aVertexPosition, 1.0);
    gl_Position = pMatrix * p;
	
 	vTextureCoord = aTextureCoord;
	
    vec3 n = normalize( nMatrix * aVertexNormal );
	vLight = uAmbientColor + computeLights(p, n, uSpecularIntensity, uShininess);
}

//# GouraudFragment
uniform vec4 uColor;
uniform sampler2D uColorSampler;
uniform bool uHasColorSampler;

varying vec3 vLight;
varying vec2 vTextureCoord;

void main(void) {
	vec4 tc = uColor.rgba;
	if(uHasColorSampler) tc *= texture2D(uColorSampler, vTextureCoord);
	gl_FragColor = vec4(tc.rgb * vLight, uColor.a);
}