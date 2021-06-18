import oscP5.*;
import netP5.*;
import SimpleOpenNI.*;
//Son las direcciones en OSC, que se ocupan despues
String[] Formato={"/Head",//0
                  "/Neck",//1
                  "/L_Shoulder",//2
                  "/R_Shoulder",//3
                  "/L_Elbow",//4
                  "/R_Elbow",//5
                  "/R_Hand",//6
                  "/L_Hand",//7
                  "/Torso",//8
                  "/L_Knee",//9
                  "/R_Knee",//10
                  "/L_Hip",//11
                  "/R_Hip",//12
                  "/L_Foot",//13
                  "/R_Foot"};//14
                                 
//Se inician variables,datos es para enviar el array x,y,z
float[] datos;
PVector[] vector = new PVector[30];
OscP5 oscP5;
NetAddress remote;
OscMessage mensaje;
SimpleOpenNI  context; 

void setup()
{
  size(640,480);
//Kinect
  context = new SimpleOpenNI(this);
  if(context.isInit() == false)
    {
       println("No se puede inicializar SimpleopenAI, no esta conectada la camara");
       exit();
       return;  
    }
context.enableDepth();
context.enableUser(); 
//OSCP5
//Escucha loos mensajes del puerto 12001
 oscP5 = new OscP5(this,12010);
 //envia a la red local y al puerto 12001
 remote = new NetAddress("127.0.0.1",5000);
 
}
void draw() 
{
  context.update();
  image(context.userImage(),0,0);
  int[] userList = context.getUsers();
    for(int i=0;i<userList.length;i++)
    {
      //Se realiza el ciclo for por cada ciclo DRAW
      if(context.isTrackingSkeleton(userList[i]))
      {
        //LLAMA A LA LA FUNCION DRAW , QUE ESTA AL INFERIOR
        drawSkeleton(userList[i]);}
    }
} 
float[] source;
void drawSkeleton(int userId){
PVector jointPos = new PVector();

//Se obtienen las posiciones a traves de la libreria 
//y se envian por medio de OSC en la funcion "enviar"
//Se utiliza el array String para definir las direcciones ejemplo "/Head"
//*************************************************************
  context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_HEAD,jointPos);
 datos=jointPos.array();
 vector[0]=jointPos;
enviar(datos,Formato[0]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_NECK,jointPos);
 datos=jointPos.array();
  vector[1]=jointPos;
enviar(datos,Formato[1]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_SHOULDER,jointPos);
 datos=jointPos.array();
  vector[2]=jointPos;
enviar(datos,Formato[2]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_SHOULDER,jointPos);
 datos=jointPos.array();
  vector[3]=jointPos;
enviar(datos,Formato[3]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_ELBOW,jointPos);
 datos=jointPos.array();
  vector[4]=jointPos;
enviar(datos,Formato[4]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_ELBOW,jointPos);
datos=jointPos.array();
 vector[5]=jointPos;
enviar(datos,Formato[5]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HAND,jointPos);
 datos=jointPos.array();
  vector[6]=jointPos;
enviar(datos,Formato[6]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HAND,jointPos);
datos=jointPos.array();
 vector[7]=jointPos;
enviar(datos,Formato[7]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_TORSO,jointPos);
  datos=jointPos.array();
   vector[8]=jointPos;
enviar(datos,Formato[8]);
  //*************************************************************
 context.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_KNEE,jointPos);
  datos=jointPos.array();
enviar(datos,Formato[9]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_KNEE,jointPos);
 datos=jointPos.array();
enviar(datos,Formato[10]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_HIP,jointPos);
 datos=jointPos.array();
enviar(datos,Formato[11]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_HIP,jointPos);
datos=jointPos.array();
enviar(datos,Formato[12]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_LEFT_FOOT,jointPos);
  datos=jointPos.array();
enviar(datos,Formato[13]);
  //*************************************************************
 context.getJointPositionSkeleton(userId,SimpleOpenNI.SKEL_RIGHT_FOOT,jointPos);
datos=jointPos.array();
enviar(datos,Formato[14]);
  //*************************************************************

  
} 

//Envia los datos, los crea y los envia.
void enviar(float[] datos,String formato ){
  mensaje=new OscMessage(formato);
  mensaje.add(datos);
  oscP5.send(mensaje, remote);
}

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("Nuevo Usuario - userId: " + userId);
  println("\tEmpieza a Buscar el esqueleto.");
  curContext.startTrackingSkeleton(userId);
}
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}