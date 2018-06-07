#!/bin/bash

for f in `find . | grep .md`
do
    dir=$(dirname $f)
    name=$(basename $f | awk -F. '{print $1}')
    mkdir -pv HTML/${dir}
    mkdir -pv WIKI/${dir}
    pandoc -toc -f markdown -t html5 -o HTML/${dir}/${name}.html -s $f
    pandoc -toc -f markdown -t mediawiki -o WIKI/${dir}/${name}.wiki -s $f
done

cd HTML 
cat > index.html <<EOF         
<!doctype html>
<head>
  <meta charset="utf-8">
  <meta name="description" content="blog.onwalk.net 一个半路出家程序猿的日志." >
  <meta name="keywords" content="LINUX系统，服务器应用，运维与基础架构,个人随笔" >
</head>
<body>
<h1 align="center">深蓝作品集</h1>
<center>Author:潘海涛 Email:xz@onwalk.net</center>
<hr />
<h2>版权声明</h2>
<li>在满足非商业用途的前提条件下，任何人都可以自由的<u>转载/引用/再创作</u>此文档，但必须保留作者署名并注明出处。</li>
<hr />
</h2>
EOF

for d in `ls`
do
    case $d in
        Essay)       title="个人随笔" ;;
        LinuxSystem) title="系统"     ;;
        PaaS)        title="PaaS"     ;;
        Application) title="应用程序" ;;
        Langage)     title="语言"     ;;
        OPS)         title="运维"     ;; 
        DB)          title="数据库"   ;; 
        Solution)    title="解决方案" ;;
        Viewpoint)   title="视角"     ;;
    esac
    echo "<h2> $title </h2> <hr />" >> index.html

    for f in `find $d | grep .html`
    do
        
        #num=`cat HTML/Application/openssl-howto.html | grep -n \<body\> | awk -F: '{print $1}'`
        #line_num=[ $num + 1 ]
        title=`sed -n '14p' $f | awk -F'>' '{print $2}' | awk -F'<' '{print $1}'`
        echo "<a href=\"$f\"> $title </a> <br>" >> index.html
    done
done

cat >> index.html <<EOF         
</body>
<center> <footer >深蓝@onwalk.net</footer> </center>
</html>
EOF
