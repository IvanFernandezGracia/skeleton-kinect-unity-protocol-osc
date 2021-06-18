//Lo primero es incluir las declaraciones de importación adecuadas en la parte superior de su código:
import org.openkinect.processing.*;

//Además de una referencia a un objeto Kinect, es decir
Kinect kinect;

//Luego setup(), puedes inicializar ese objeto kinect:
void setup() {
  kinect = new Kinect(this);
  kinect.initDevice();
  kinect.initDepth();
}

//Acceder a los datos del sensor de kinect
//Actualmente, la biblioteca pone los datos a su disposición de cinco maneras:
//PImage (RGB) de la cámara de video kinect.
//PImage (grayscale) de la cámara IR de Kinect.
//PImage (grayscale) con el brillo de cada píxel asignado a la profundidad (más brillante = más cerca).
//PImage (RGB) con el matiz de cada píxel asignado a la profundidad.
//int[] array con datos de profundidad sin formato (números de 11 bits entre 0 y 2048).


//Dibujar RGB y profundidad  
void drag(){
  // Tamaño de la ventana en pixeles para la visualizacion de RGB o profundidad
  size(512,424) 
  
  //Utilizar el Kinect como una cámara web vieja y normal
  //Con kinect v1 no se puede obtener tanto la imagen de video como la imagen de IR. Ambos son devueltos a través de getVideoImage () 
  PImage img = kinect.getVideoImage();
  image(img, 0, 0);
  
  //Imagen de profundidad en escala de grises:
  PImage img = kinect.getDepthImage();
  image(img, 0, 0);
}

//Datos de profundidad sin procesar:
//Los valores de profundidad sin procesar oscilan entre 0 y 2048
int[] depth = kinect.getRawDepth();

//Imagen de profundidad de color
kinect.enableColorDepth(true);

//FUNCIONES UTILES
//initDevice() - comienza todo (video, profundidad, IR)
//activateDevice(int) - activar un dispositivo específico cuando se conectan varios dispositivos
//initVideo() - solo iniciar video
//enableIR(boolean) - encender o apagar la imagen de la cámara IR (v1 solamente)
//initDepth() - solo comienza la profundidad
//enableColorDepth(boolean) - activar o desactivar los valores de profundidad como imagen en color
//enableMirror(boolean) - duplicar la imagen y los datos de profundidad 
//PImage getVideoImage() - tomar la imagen de video RGB 
//PImage getDepthImage() - agarra la imagen del mapa de profundidad
//int[] getRawDepth() - agarrar los datos de profundidad sin procesar
//float getTilt() - obtener el ángulo del sensor actual (entre 0 y 30 grados) 
//setTilt(float) - ajustar el ángulo del sensor (entre 0 y 30 grados) 