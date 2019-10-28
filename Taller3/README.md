# Taller raster

## Integrantes


| Integrante  | github nick |
|-------------|-------------|
|Rubén Buelvas|rubenbuelvas |
|José Nieto   |jdnietov     |

## Discusión

Los resultados fueron positivos, en general el rendimiento no se ve muy afectado por realizar el proceso de llenar el triángulo, en cambio, sí se notan cambios al hacer correr encima el algoritmo de anti-aliasing. 

El concepto de anti-aliasing es muy interesante y encontramos que el video que está en el artículo de gamingscan, en el que habla LinusTech, es bastante ilustrativo para entender qué hace el anti-aliasing, cómo funciona y qué impacto tiene en el rendimiento.

Para el algoritmo del anti-aliasing se utilizó el dado en la fuente del scratchpixel. Con la técnica de dividir el pixel en subpíxeles. Además de esta forma también se probó utilizando la información de pixeles vecinos en vez de dividir el pixel en subpíxeles, obteniendo un resultado muy similar.

## Fuentes
https://www.gamingscan.com/what-is-anti-aliasing/

https://lunaloca.com/tutorials/antialiasing/

https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation

https://www.youtube.com/watch?time_continue=1&v=hqi0114mwtY

