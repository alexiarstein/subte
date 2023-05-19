#!/bin/bash
# Estado de la Red de Subterraneos de Buenos Aires
# Autora: Alexia Rivera <lachicadesistemas@gmail.com>
# Licencia: GNU GPL 3.0
# Web: https://github.com/alexiarstein
# ---------------------------------------------------
# Cronearlo:
# 0 * * * * /bin/bash path al script subte.sh
# Este cron lo hace correr cada 1hr. Setea este tiempo
# A lo que te resulte más conveniente.
# Alexia.

fecha=$(date +"Ultima Actualización: %d %b %Y a las %H:%M:%S")

wget https://www.enelsubte.com/estado/
grep -oP '(?<=<div class="pastilla linea-).*?(?=">)' index.html > tmp_letra
sed -i 's/A/<span style="font-weight: bold; color: lightblue;">A<\/span>/' tmp_letra
sed -i 's/B/<span style="font-weight: bold; color: red;">B<\/span>/' tmp_letra
sed -i 's/C/<span style="font-weight: bold; color: blue;">C<\/span>/' tmp_letra
sed -i 's/D/<span style="font-weight: bold; color: green;">D<\/span>/' tmp_letra
sed -i 's/E/<span style="font-weight: bold; color: purple;">E<\/span>/' tmp_letra
sed -i 's/H/<span style="font-weight: bold; color: yellow;">H<\/span>/' tmp_letra
sed -i 's/P/<span style="font-weight: bold; color: orange;">P<\/span>/' tmp_letra
sed -i 's/U/<span style="font-weight: bold; color: pink;">U<\/span>/' tmp_letra
grep -oP '(?<=<div class="estado-subtes-estado">).*?(?=</div>)' index.html    > tmp_estado

sed -i 's/$/<br \/>/' tmp_estado
echo "<html><head><title>Estado del subte</title></head><body>" > index.php
echo "<!-- Página autogenerada via subte.sh by Alexia Rivera (Ver: https://github.com/alexiarstein/subte) -->" >> index.php
echo "<h3>Estado de la red de Subterraneos de Buenos Aires</h3>" >> index.php
paste -d ' '  tmp_letra tmp_estado >> index.php
echo "<h4> $fecha </h4>" >> index.php
echo "<hr />" >> index.php
echo "2023 - <a href='https://github.com/alexiarstein'>Alexia Rivera</a> - Este software es libre y bajo licencia GNU GPL 3.0. Repositorio: <a href='https://github.com/alexiarstein/subte'>https://github.com/alexiarstein/subte</a>" >> index.php
echo "</body></html>" >> index.php
rm tmp_*
rm index.htm*
