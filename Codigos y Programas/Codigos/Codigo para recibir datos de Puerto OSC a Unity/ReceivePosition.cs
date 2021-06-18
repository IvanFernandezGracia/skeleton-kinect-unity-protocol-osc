using UnityEngine;
using System.Collections;

public class ReceivePosition : MonoBehaviour {
    
   	public OSC osc;
    public string Adress_nombre;
     float factor_escala=200.0f;
	// Use this for initialization
	void Start () {
	   osc.SetAddressHandler(Adress_nombre, OnReceiveXYZ );
       
    }
	
	// Update is called once per frame
	void Update () {
	
	}

	void OnReceiveXYZ(OscMessage message){
		float x = message.GetFloat(0)/factor_escala;
         float y = message.GetFloat(1)/factor_escala;
		float z = message.GetFloat(2)/factor_escala;

		transform.position = new Vector3(x,y,z);
	}

    

    

    


}
