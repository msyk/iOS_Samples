//
//  Shader.fsh
//  FirstTrial
//
//  Created by demo on 2014/06/15.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
