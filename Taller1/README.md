# Computación visual - Taller 1
| Integrante  | github nick |
|-------------|-------------|
|Rubén Buelvas|rubenbuelvas |
|José Nieto   |jdnietov     |

# Discusión

## Imagen

El procesamiento de imagen realizado en el ejercicio consiste en tres etapas:
1. Aplicación de filtros
   1. Promedio de grises y LUMA
   2. Máscaras de convolución
2. Creación de histogramas.
3. Segmentación de la imagen.

### Generalidades

La imagen procesada se muestra estática sobre el `PApplet` de Processing. Por otra parte, para aplicar un filtro, la imagen se carga dentro del contexto de otra instancia de `PGraphics`, llamada `Canvas`. Los métodos principales dentro de esta clase son:

```
Canvas(String imgName);
void display(int x, int y, int sx, int sy);
void loadImg();
void apply(int mode);
void grayAvg();
void luma();
void segment(float min, float max);
void convolute(int maskId);
```

### Filtros: Promedio de grises y LUMA

#### Promedio de grises
El promedio de grises se ejecuta con la función `void grayAvg()`, la cual visita cada pixel y reemplaza su valor por el promedio de sus componentes de color, como se explica en la línea de código:

```
color p = img.pixels[idx];
img.pixels[idx] = color((red(p) + blue(p) + green(p)) / 3);
```

donde `idx` corresponde al índice del pixel individual.

#### LUMA
La fórmula que se escogió para la aplicación de LUMA fue, entre las que proponía la múltiple bibliografía, la siguiente:

```
0.212 * red(p) + 0.701 * green(p) + 0.087 * blue(p);
```

ya que esta fórmula es utilizada como estándar en sistemas HDTV por la recomendación BT.709.

### Máscaras de convolución

`void convolute(int maskId)` se refiere a la función que aplica una máscara de convolución, identificada con el valor `maskId`, sobre la imagen previamente cargada en una instancia de `Canvas`. Esta función, junto con `color conv(...)`, que aplica el kernel sobre un pixel individual, fueron modificadas a partir del código de ejemplo disponible en la [página oficial de Processing](https://processing.org/examples/convolution.html).

Las máscaras de convolución disponibles para prueba son las siguientes:
- `SHARPEN` y `SHARPEN2` para afilar los contornos de la imagen y darles mayor profundidad.
- `EDGE_DETECT1` y `EDGE_DETECT2` para resaltar los bordes de la imagen, opacando el resto de sus contenidos.
- `BOX_BLUR` para un desenfoque suave.



## Video

El procesamiento de video se hizo por medio de la aplicación del filtro LUMA y de máscaras de convolución.

El video original se reproduce en la parte superior izquierda de la pantalla, las modificaciones se cargan en instancias de `PGraphics` y se despliegan en la parte derecha de la pantalla.

```
image(movie, 0, 0);
image(luma(movie), 640, 0); 
image(convolute(movie, 2), 640, 360); 
```

Se utilizan funciones sacadas del canvas del programa que manipula las imágenes. Éstas funciones reciben el objeto `Movie`, cuyo comportamiento, en este contexto, es el mismo del de un objeto `PImage`. Los cambios realizados sobre la imagen se guardan en un objeto `PGraphics`, que es lo que retorna la función.
